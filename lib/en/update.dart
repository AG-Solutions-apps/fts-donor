import 'package:bbbbbb/er/er.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for all fields
  late TextEditingController _fullNameController;
  late TextEditingController _titleController;
  late TextEditingController _typeController;
  late TextEditingController _genderController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _whatsappController;
  late TextEditingController _fatherNameController;
  late TextEditingController _motherNameController;
  late TextEditingController _spouseNameController;
  late TextEditingController _dobController;
  late TextEditingController _doaController;
  late TextEditingController _panController;
  late TextEditingController _websiteController;
  late TextEditingController _resAddressController;
  late TextEditingController _resAreaController;
  late TextEditingController _resLandmarkController;
  late TextEditingController _resCityController;
  late TextEditingController _resStateController;
  late TextEditingController _resPinCodeController;
  late TextEditingController _offAddressController;
  late TextEditingController _offAreaController;
  late TextEditingController _offLandmarkController;
  late TextEditingController _offCityController;
  late TextEditingController _offStateController;
  late TextEditingController _offPinCodeController;
  late TextEditingController _corrPreferenceController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final profile = Provider.of<AuthProvider>(context, listen: false).donorProfile;
    final company = profile?.individualCompany;
    
    _fullNameController = TextEditingController(text: company?.fullName ?? '');
    _titleController = TextEditingController(text: company?.title ?? '');
    _typeController = TextEditingController(text: company?.type ?? '');
    _genderController = TextEditingController(text: company?.gender ?? '');
    _emailController = TextEditingController(text: company?.email ?? '');
    _phoneController = TextEditingController(text: company?.mobilePhone ?? '');
    _whatsappController = TextEditingController(text: company?.mobilePhone ?? '');
    _fatherNameController = TextEditingController(text: company?.fatherName ?? '');
    _motherNameController = TextEditingController(text: company?.motherName ?? '');
    _spouseNameController = TextEditingController(text: company?.spouseName ?? '');
    _dobController = TextEditingController(text: company?.dob ?? '');
    _doaController = TextEditingController(text: company?.dob ?? '');
    _panController = TextEditingController(text: company?.panNo ?? '');
    _websiteController = TextEditingController(text: company?.email ?? '');
    
    // Residential Address
    _resAddressController = TextEditingController(text: company?.address ?? '');
    _resAreaController = TextEditingController(text: '');
    _resLandmarkController = TextEditingController(text: '');
    _resCityController = TextEditingController(text: company?.city ?? '');
    _resStateController = TextEditingController(text: company?.state ?? '');
    _resPinCodeController = TextEditingController(text: company?.pinCode ?? '');
    
    // Office Address
    _offAddressController = TextEditingController(text: company?.address ?? '');
    _offAreaController = TextEditingController(text: '');
    _offLandmarkController = TextEditingController(text: '');
    _offCityController = TextEditingController(text: company?.city ?? '');
    _offStateController = TextEditingController(text: company?.state ?? '');
    _offPinCodeController = TextEditingController(text: company?.pinCode ?? '');
    
    _corrPreferenceController = TextEditingController(text: 'Branch Office');
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _titleController.dispose();
    _typeController.dispose();
    _genderController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _whatsappController.dispose();
    _fatherNameController.dispose();
    _motherNameController.dispose();
    _spouseNameController.dispose();
    _dobController.dispose();
    _doaController.dispose();
    _panController.dispose();
    _websiteController.dispose();
    _resAddressController.dispose();
    _resAreaController.dispose();
    _resLandmarkController.dispose();
    _resCityController.dispose();
    _resStateController.dispose();
    _resPinCodeController.dispose();
    _offAddressController.dispose();
    _offAreaController.dispose();
    _offLandmarkController.dispose();
    _offCityController.dispose();
    _offStateController.dispose();
    _offPinCodeController.dispose();
    _corrPreferenceController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      
      final data = {
        'indicomp_full_name': _fullNameController.text.trim(),
        'title': _titleController.text.trim(),
        'indicomp_type': _typeController.text.trim(),
        'indicomp_gender': _genderController.text.trim(),
        'indicomp_email': _emailController.text.trim(),
        'indicomp_mobile_phone': _phoneController.text.trim(),
        'indicomp_mobile_whatsapp': _whatsappController.text.trim(),
        'indicomp_father_name': _fatherNameController.text.trim(),
        'indicomp_mother_name': _motherNameController.text.trim(),
        'indicomp_spouse_name': _spouseNameController.text.trim(),
        'indicomp_dob_annualday': _dobController.text.trim(),
        'indicomp_doa': _doaController.text.trim(),
        'indicomp_pan_no': _panController.text.trim(),
        'indicomp_website': _websiteController.text.trim(),
        'indicomp_res_reg_address': _resAddressController.text.trim(),
        'indicomp_res_reg_area': _resAreaController.text.trim(),
        'indicomp_res_reg_ladmark': _resLandmarkController.text.trim(),
        'indicomp_res_reg_city': _resCityController.text.trim(),
        'indicomp_res_reg_state': _resStateController.text.trim(),
        'indicomp_res_reg_pin_code': _resPinCodeController.text.trim(),
        'indicomp_off_branch_address': _offAddressController.text.trim(),
        'indicomp_off_branch_area': _offAreaController.text.trim(),
        'indicomp_off_branch_ladmark': _offLandmarkController.text.trim(),
        'indicomp_off_branch_city': _offCityController.text.trim(),
        'indicomp_off_branch_state': _offStateController.text.trim(),
        'indicomp_off_branch_pin_code': _offPinCodeController.text.trim(),
        'indicomp_corr_preffer': _corrPreferenceController.text.trim(),
      };

      print('Sending update data: $data');

      final result = await authProvider.updateDonorProfile(data);
      
      setState(() => _isLoading = false);

      if (mounted) {
        if (result['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'Failed to update profile'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5), // Exact consistent warm theme matching dashboard canvas
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF8F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0E1726)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Update Profile',
          style: TextStyle(
            color: Color(0xFF0E1726),
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              onPressed: _isLoading ? null : _updateProfile,
              child: _isLoading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1A237E)),
                      ),
                    )
                  : const Text(
                      'Save Changes',
                      style: TextStyle(
                        color: Color(0xFF1A237E),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // Keyboard auto dismiss setup
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Identity Section Group
                _buildFormSection(
                  title: 'Personal Information',
                  icon: Icons.assignment_ind_outlined,
                  children: [
                    _buildPremiumTextField(
                      controller: _fullNameController,
                      label: 'Full Name',
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    _buildPremiumTextField(
                      controller: _titleController,
                      label: 'Title (e.g., Shri / Smt. / Mrs.)',
                      icon: Icons.title_outlined,
                    ),
                    _buildPremiumTextField(
                      controller: _typeController,
                      label: 'Type (e.g., Private / Individual)',
                      icon: Icons.business_outlined,
                    ),
                    _buildPremiumTextField(
                      controller: _genderController,
                      label: 'Gender',
                      icon: Icons.wc_outlined,
                    ),
                    _buildPremiumTextField(
                      controller: _emailController,
                      label: 'Email Address',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    _buildPremiumTextField(
                      controller: _phoneController,
                      label: 'Mobile Number',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    _buildPremiumTextField(
                      controller: _whatsappController,
                      label: 'WhatsApp Number',
                      icon: Icons.chat_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Family Information Group
                _buildFormSection(
                  title: 'Family Details',
                  icon: Icons.family_restroom_outlined,
                  children: [
                    _buildPremiumTextField(
                      controller: _fatherNameController,
                      label: 'Father\'s Name',
                      icon: Icons.person_outline,
                    ),
                    _buildPremiumTextField(
                      controller: _motherNameController,
                      label: 'Mother\'s Name',
                      icon: Icons.person_outline,
                    ),
                    _buildPremiumTextField(
                      controller: _spouseNameController,
                      label: 'Spouse\'s Name',
                      icon: Icons.person_outline,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Schedule Timing References Group
                _buildFormSection(
                  title: 'Important Dates',
                  icon: Icons.calendar_month_outlined,
                  children: [
                    _buildPremiumTextField(
                      controller: _dobController,
                      label: 'Date of Birth/Anniversary (YYYY-MM-DD)',
                      icon: Icons.calendar_today_outlined,
                      keyboardType: TextInputType.datetime,
                    ),
                    _buildPremiumTextField(
                      controller: _doaController,
                      label: 'Date of Anniversary (YYYY-MM-DD)',
                      icon: Icons.calendar_today_outlined,
                      keyboardType: TextInputType.datetime,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Tax and Portal Data References Group
                _buildFormSection(
                  title: 'Other Details',
                  icon: Icons.analytics_outlined,
                  children: [
                    _buildPremiumTextField(
                      controller: _panController,
                      label: 'PAN Number',
                      icon: Icons.credit_card_outlined,
                    ),
                    _buildPremiumTextField(
                      controller: _websiteController,
                      label: 'Website URL',
                      icon: Icons.language_outlined,
                      keyboardType: TextInputType.url,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Home Physical Base Group
                _buildFormSection(
                  title: 'Residential Address',
                  icon: Icons.roofing_outlined,
                  children: [
                    _buildPremiumTextField(
                      controller: _resAddressController,
                      label: 'Address Line',
                      icon: Icons.home_outlined,
                      maxLines: 2,
                    ),
                    _buildPremiumTextField(
                      controller: _resAreaController,
                      label: 'Area / Sector',
                      icon: Icons.map_outlined,
                    ),
                    _buildPremiumTextField(
                      controller: _resLandmarkController,
                      label: 'Landmark Descriptor',
                      icon: Icons.place_outlined,
                    ),
                    _buildPremiumTextField(
                      controller: _resCityController,
                      label: 'City',
                      icon: Icons.location_city_outlined,
                    ),
                    _buildPremiumTextField(
                      controller: _resStateController,
                      label: 'State',
                      icon: Icons.location_on_outlined,
                    ),
                    _buildPremiumTextField(
                      controller: _resPinCodeController,
                      label: 'PIN Code',
                      icon: Icons.pin_drop_outlined,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Corporate Building Physical Base Group
                _buildFormSection(
                  title: 'Office Address',
                  icon: Icons.apartment_outlined,
                  children: [
                    _buildPremiumTextField(
                      controller: _offAddressController,
                      label: 'Address Line',
                      icon: Icons.business_outlined,
                      maxLines: 2,
                    ),
                    _buildPremiumTextField(
                      controller: _offAreaController,
                      label: 'Area / Sector',
                      icon: Icons.map_outlined,
                    ),
                    _buildPremiumTextField(
                      controller: _offLandmarkController,
                      label: 'Landmark Descriptor',
                      icon: Icons.place_outlined,
                    ),
                    _buildPremiumTextField(
                      controller: _offCityController,
                      label: 'City',
                      icon: Icons.location_city_outlined,
                    ),
                    _buildPremiumTextField(
                      controller: _offStateController,
                      label: 'State',
                      icon: Icons.location_on_outlined,
                    ),
                    _buildPremiumTextField(
                      controller: _offPinCodeController,
                      label: 'PIN Code',
                      icon: Icons.pin_drop_outlined,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Routing Rules Framework Preference Configuration Group
                _buildFormSection(
                  title: 'Correspondence Preference',
                  icon: Icons.contact_mail_outlined,
                  children: [
                    _buildPremiumTextField(
                      controller: _corrPreferenceController,
                      label: 'Routing Targets (Residence / Office / Branch Office)',
                      icon: Icons.mail_outlined,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Dashboard Section View Layer Generation Block Helper
  Widget _buildFormSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0E1726).withOpacity(0.02),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF1A237E), size: 18),
              const SizedBox(width: 8),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0E1726),
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  // Premium Custom Form Input Generator Field Block
  Widget _buildPremiumTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF0E1726),
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8), fontWeight: FontWeight.w500),
          prefixIcon: Icon(icon, color: const Color(0xFF64748B), size: 18),
          filled: true,
          fillColor: const Color(0xFFF8FAFC), // Subtle inner field fill tint matching modern assets
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFF1A237E),
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
          ),
          errorStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}