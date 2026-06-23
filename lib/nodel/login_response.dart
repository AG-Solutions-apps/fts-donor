// lib/models/login_response.dart
class LoginResponse {
  final int code;
  final String message;
  final LoginData? data;

  LoginResponse({
    required this.code,
    required this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }
}

class LoginData {
  final String token;
  final UserData user;

  LoginData({
    required this.token,
    required this.user,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'] ?? '',
      user: UserData.fromJson(json['user'] ?? {}),
    );
  }
}

class UserData {
  final int id;
  final String indicompFullName;
  final String indicompEmail;
  final String indicompMobilePhone;

  UserData({
    required this.id,
    required this.indicompFullName,
    required this.indicompEmail,
    required this.indicompMobilePhone,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? 0,
      indicompFullName: json['indicomp_full_name'] ?? '',
      indicompEmail: json['indicomp_email'] ?? '',
      indicompMobilePhone: json['indicomp_mobile_phone'] ?? '',
    );
  }
}