// lib/providers/auth_provider.dart
import 'dart:convert';
import 'package:bbbbbb/en/donor.dart';
import 'package:bbbbbb/nodel/login_response.dart';
import 'package:bbbbbb/nodel/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final String baseUrl = 'https://agstest.in/api2/public/api';
  
  String? _token;
  UserData? _user;
  DonorProfile? _donorProfile;
  bool _isLoading = false;
  bool _isProfileLoading = false;
  String? _errorMessage;

  String? get token => _token;
  UserData? get user => _user;
  DonorProfile? get donorProfile => _donorProfile;
  bool get isLoading => _isLoading;
  bool get isProfileLoading => _isProfileLoading;
  String? get errorMessage => _errorMessage;

  // Login
  Future<bool> login(String username, String password) async {
    try {
      _setLoading(true);
      _errorMessage = null;

      final response = await http.post(
        Uri.parse('$baseUrl/donor-app-login'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'username': username.trim(),
          'password': password.trim(),
        },
      );

      _setLoading(false);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['code'] == 200 && data['data'] != null) {
          final loginData = data['data'];
          
          _token = loginData['token'];
          final userData = loginData['user'];
          
          if (_token != null && userData != null) {
            _user = UserData(
              id: userData['id'] ?? 0,
              indicompFullName: userData['indicomp_full_name'] ?? '',
              indicompEmail: userData['indicomp_email'] ?? '',
              indicompMobilePhone: userData['indicomp_mobile_phone'] ?? '',
            );
            
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', _token!);
            await prefs.setString('user_data', json.encode({
              'id': _user?.id,
              'indicomp_full_name': _user?.indicompFullName,
              'indicomp_email': _user?.indicompEmail,
              'indicomp_mobile_phone': _user?.indicompMobilePhone,
            }));
            
            await fetchDonorProfile();
            
            notifyListeners();
            return true;
          }
        } else {
          _errorMessage = data['message'] ?? 'Invalid credentials';
          return false;
        }
      } else if (response.statusCode == 401) {
        _errorMessage = 'Invalid username or password.';
        return false;
      } else {
        _errorMessage = 'Server error. Please try again.';
        return false;
      }
      return false;
    } catch (e) {
      _setLoading(false);
      _errorMessage = 'Network error: ${e.toString()}';
      return false;
    }
  }

  // Fetch Donor Profile
  Future<void> fetchDonorProfile() async {
  try {
    _isProfileLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      return;
    }

    final response = await http.get(
      Uri.parse('$baseUrl/donor-app-donors-view'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print('Profile Status: ${response.statusCode}');
    print('Profile Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      _donorProfile = DonorProfile.fromJson(data);

      print('Profile Loaded Successfully');
      notifyListeners();
    }
  } catch (e) {
    print('Error fetching profile: $e');
  } finally {
    _isProfileLoading = false;
    notifyListeners();
  }
}


  // Update Donor Profile - FIXED VERSION
  Future<Map<String, dynamic>> updateDonorProfile(Map<String, String> data) async {
    try {
      _setLoading(true);
      _errorMessage = null;

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      
      if (token == null) {
        _setLoading(false);
        return {
          'success': false,
          'message': 'Please login again.',
        };
      }

      print('Updating profile with data: $data');

      final response = await http.put(
        Uri.parse('$baseUrl/donor-app-update-donor-profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: data,
      );

      print('Update response status: ${response.statusCode}');
      print('Update response body: ${response.body}');

      _setLoading(false);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['code'] == 200) {
          // Refresh profile after update
          await fetchDonorProfile();
          return {
            'success': true,
            'message': 'Profile updated successfully.',
          };
        } else {
          return {
            'success': false,
            'message': responseData['message'] ?? 'Failed to update profile.',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Failed to update profile. Status code: ${response.statusCode}',
        };
      }
    } catch (e) {
      _setLoading(false);
      print('Update profile error: $e');
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
      };
    }
  }

  // Forgot Password
  Future<Map<String, dynamic>> forgotPassword(String username, String email) async {
    try {
      _setLoading(true);
      _errorMessage = null;

      final response = await http.post(
        Uri.parse('$baseUrl/donor-app-forget-password'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'username': username.trim(),
          'email': email.trim(),
        },
      );

      _setLoading(false);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'success': data['code'] == 200,
          'message': data['message'] ?? 'Password sent to email.',
        };
      }
      return {
        'success': false,
        'message': 'Failed to send password.',
      };
    } catch (e) {
      _setLoading(false);
      return {
        'success': false,
        'message': 'Network error. Please try again.',
      };
    }
  }

  // Change Password
  Future<Map<String, dynamic>> changePassword(
    String oldPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      _setLoading(true);
      _errorMessage = null;

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      
      if (token == null) {
        _setLoading(false);
        return {
          'success': false,
          'message': 'Please login again.',
        };
      }

      if (newPassword != confirmPassword) {
        _setLoading(false);
        return {
          'success': false,
          'message': 'New password and confirm password do not match.',
        };
      }

      if (newPassword.length < 6) {
        _setLoading(false);
        return {
          'success': false,
          'message': 'Password must be at least 6 characters.',
        };
      }

      final response = await http.post(
        Uri.parse('$baseUrl/donor-app-change-password'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'old_password': oldPassword.trim(),
          'new_password': newPassword.trim(),
          'confirm_password': confirmPassword.trim(),
        },
      );

      _setLoading(false);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['code'] == 200) {
          return {
            'success': true,
            'message': data['message'] ?? 'Password changed successfully.',
          };
        } else {
          return {
            'success': false,
            'message': data['message'] ?? 'Failed to change password.',
          };
        }
      }
      return {
        'success': false,
        'message': 'Failed to change password.',
      };
    } catch (e) {
      _setLoading(false);
      return {
        'success': false,
        'message': 'Network error. Please try again.',
      };
    }
  }

  // Check Token
  Future<bool> checkToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final userDataString = prefs.getString('user_data');
      
      if (token != null && userDataString != null) {
        _token = token;
        final userData = json.decode(userDataString);
        _user = UserData(
          id: userData['id'] ?? 0,
          indicompFullName: userData['indicomp_full_name'] ?? '',
          indicompEmail: userData['indicomp_email'] ?? '',
          indicompMobilePhone: userData['indicomp_mobile_phone'] ?? '',
        );
        
        await fetchDonorProfile();
        
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      
      if (token != null) {
        await http.post(
          Uri.parse('$baseUrl/donor-app-donor-logout'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );
      }
    } catch (e) {
      print('Logout error: $e');
    } finally {
      _token = null;
      _user = null;
      _donorProfile = null;
      _errorMessage = null;
      _isProfileLoading = false;
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('user_data');
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  // lib/providers/auth_provider.dart - Add this method

  // Fetch School Allotment List
  Future<List<SchoolAllotment>> fetchSchoolAllotments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      
      if (token == null) {
        return [];
      }

      final response = await http.get(
        Uri.parse('$baseUrl/donor-app-school-alloted-list'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('School Allotment Status: ${response.statusCode}');
      print('School Allotment Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null) {
          final List<dynamic> allotments = data['data'];
          return allotments.map((e) => SchoolAllotment.fromJson(e)).toList();
        }
      }
      return [];
    } catch (e) {
      print('Error fetching school allotments: $e');
      return [];
    }
  }
  // lib/providers/auth_provider.dart - Add this method

  // Fetch School Detail by ID
  Future<List<SchoolDetail>> fetchSchoolDetail(int allotmentId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      
      if (token == null) {
        return [];
      }

      final response = await http.get(
        Uri.parse('$baseUrl/donor-app-school-alloted-view-by-id/$allotmentId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('School Detail Status: ${response.statusCode}');
      print('School Detail Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null) {
          final List<dynamic> details = data['data'];
          return details.map((e) => SchoolDetail.fromJson(e)).toList();
        }
      }
      return [];
    } catch (e) {
      print('Error fetching school detail: $e');
      return [];
    }
  }
}