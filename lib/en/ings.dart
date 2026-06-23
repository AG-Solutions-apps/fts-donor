import 'package:bbbbbb/en/bb.dart';
import 'package:bbbbbb/en/donor.dart';
import 'package:bbbbbb/en/update.dart';
import 'package:bbbbbb/er/er.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final profile = authProvider.donorProfile;

    if (authProvider.isProfileLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFFAF8F5),
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1A237E)),
          ),
        ),
      );
    }

    if (profile == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFFAF8F5),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFAF8F5),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0E1726)),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Profile Settings',
            style: TextStyle(
              color: Color(0xFF0E1726),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: const Center(
          child: Text(
            'No profile data available',
            style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w500),
          ),
        ),
      );
    }

    final company = profile.individualCompany;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF8F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0E1726)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile Settings',
          style: TextStyle(
            color: Color(0xFF0E1726),
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: const Icon(Icons.edit_outlined, color: Color(0xFF1A237E)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const UpdateProfileScreen(),
                  ),
                );
              },
            ),
          ),
        ]
        ),
      body: DefaultTabController(
        length: 3,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Premium Hero Profile Header Card
            Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          profile.individualCompany.donorImageUrl,
          width: 110,
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 110,
              height: 100,
              color: Colors.grey.shade200,
              child: const Icon(
                Icons.person,
                size: 40,
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactField(
              Icons.person_outline,
              'Name',
              company.fullName ?? 'N/A',
            ),

            const Divider(
              height: 10,
              color: Color(0xFFF1F5F9),
            ),

            _buildContactField(
              Icons.calendar_today_outlined,
              'Date of Birth',
              _formatDate(company.dob),
            ),

            const SizedBox(height: 2),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF334155),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'FTS ID: ${company.ftsId ?? "1"}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),
              const SizedBox(height: 20),

              // Quick Actions Block Module
              _buildSectionHeading('Quick Actions'),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildActionTile(
                      context,
                      icon: Icons.lock_open_outlined,
                      title: 'Change Password',
                      subtitle: 'Update account authentication password',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ChangePasswordScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, indent: 56, color: Color(0xFFF1F5F9)),
                    _buildActionTile(
                      context,
                      icon: Icons.badge_outlined,
                      title: 'Update Profile Details',
                      subtitle: 'Edit your structural identity info',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const UpdateProfileScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // TabBar Section
              const TabBar(
                isScrollable: true,
                labelColor: Color(0xFF1A237E),
                unselectedLabelColor: Color(0xFF94A3B8),
                indicatorColor: Color(0xFF1A237E),
                indicatorWeight: 3,
                padding: EdgeInsets.zero,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                tabs: [
                  Tab(text: 'Personal'),
                  Tab(text: 'Residential'),
                  Tab(text: 'Office'),
                
                ],
              ),
              const SizedBox(height: 16),

              // TabBarView Content
              SizedBox(
                height: 600, // Adjust this height based on your content
                child: TabBarView(
                  children: [
                    // Personal Tab
                    _buildPersonalTabContent(context, profile, company),
                    
                    // Residential Tab
                    _buildResidentialTabContent(context, profile, company),
                    
                    // Office Tab
                    _buildOfficeTabContent(context, profile, company),
                    
                    // Networks Tab
                  
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Personal Tab Content (without header and quick actions)
  Widget _buildPersonalTabContent(BuildContext context, DonorProfile profile, IndividualCompany company) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Detailed Personal Identifiers Card
          _buildSectionHeading('Personal Information'),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildModernInfoRow(Icons.cake_outlined, 'Date of Anniversary', _formatDate(company.dob)),
                _buildModernInfoRow(Icons.credit_card_outlined, 'PAN Number', company.panNo ?? 'N/A'),
                _buildModernInfoRow(Icons.language_outlined, 'Website / Channel', company.email ?? 'N/A'),
                _buildModernInfoRow(Icons.person_2_outlined, 'Father\'s Name', company.fatherName ?? 'N/A'),
                _buildModernInfoRow(Icons.person_3_outlined, 'Mother\'s Name', company.motherName ?? 'N/A'),
                _buildModernInfoRow(Icons.escalator_warning_outlined, 'Spouse\'s Name', company.spouseName ?? 'N/A'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Residential Tab Content
  Widget _buildResidentialTabContent(BuildContext context, DonorProfile profile, IndividualCompany company) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Residential Physical Address Grid
          _buildSectionHeading('Residential Address'),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildModernInfoRow(Icons.home_outlined, 'Address Line', company.address ?? 'N/A'),
                _buildModernInfoRow(Icons.location_city_outlined, 'City Council', company.city ?? 'N/A'),
                _buildModernInfoRow(Icons.map_outlined, 'State Province', company.state ?? 'N/A'),
                _buildModernInfoRow(Icons.pin_outlined, 'PIN Code', company.pinCode ?? 'N/A'),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Communication Delivery Preferences Panel
          _buildSectionHeading('Correspondence Preference'),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1A237E).withOpacity(0.04),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.near_me_outlined, color: Color(0xFF1A237E), size: 18),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Primary Routing Node Target',
                      style: TextStyle(fontSize: 13, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    'Branch Office',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A237E).withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Office Tab Content
  Widget _buildOfficeTabContent(BuildContext context, DonorProfile profile, IndividualCompany company) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Enterprise Office Address Grid
          _buildSectionHeading('Office Address'),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildModernInfoRow(Icons.apartment_outlined, 'Address Line', company.address ?? 'N/A'),
                _buildModernInfoRow(Icons.location_city_outlined, 'City Council', company.city ?? 'N/A'),
                _buildModernInfoRow(Icons.map_outlined, 'State Province', company.state ?? 'N/A'),
                _buildModernInfoRow(Icons.pin_outlined, 'PIN Code', company.pinCode ?? 'N/A'),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Communication Delivery Preferences Panel
          _buildSectionHeading('Correspondence Preference'),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1A237E).withOpacity(0.04),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.near_me_outlined, color: Color(0xFF1A237E), size: 18),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Primary Routing Node Target',
                      style: TextStyle(fontSize: 13, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    'Branch Office',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A237E).withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Networks Tab Content
  Widget _buildNetworksTabContent(BuildContext context, DonorProfile profile, IndividualCompany company) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Related Ecosystem Details Grid Section
          _buildSectionHeading('Related Networks'),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Family Multi-Item Array List Mapping
                Text(
                  'Family Network (${profile.familyDetails.length})',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8), letterSpacing: 0.5),
                ),
                const SizedBox(height: 6),
                profile.familyDetails.isNotEmpty
                    ? Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: profile.familyDetails.map((family) => _buildNetworkTag('${family.title} ${family.fullName}', Icons.people_outline)).toList(),
                      )
                    : const Text('No linked family members found', style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 12)),
                
                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 16),

                // Corporate Array Lists Mapping
                Text(
                  'Associated Corporate Units (${profile.companyDetails.length})',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8), letterSpacing: 0.5),
                ),
                const SizedBox(height: 6),
                profile.companyDetails.isNotEmpty
                    ? Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: profile.companyDetails.map((comp) => _buildNetworkTag('${comp.title} ${comp.fullName}', Icons.business_outlined)).toList(),
                      )
                    : const Text('No linked commercial profiles found', style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Status Tab Content
  Widget _buildStatusTabContent(BuildContext context, DonorProfile profile, IndividualCompany company) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // System Account Node Status
          _buildSectionHeading('Account Status'),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildModernInfoRow(Icons.verified_user_outlined, 'Status', company.status ?? 'Active', highlightValue: true),
                _buildModernInfoRow(Icons.login_outlined, 'Last Login', _formatDate(company.lastLogin)),
                _buildModernInfoRow(Icons.calendar_today_outlined, 'Member Since', _formatDate(company.joiningDate)),
                _buildModernInfoRow(Icons.fingerprint_outlined, 'FTS ID', company.ftsId.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Dashboard Interface Element Generators
  Widget _buildSectionHeading(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0E1726),
        ),
      ),
    );
  }

  Widget _buildNetworkTag(String val, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF8F5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: const Color(0xFF64748B)),
          const SizedBox(width: 6),
          Text(
            val,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF1A237E).withOpacity(0.06),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF1A237E), size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFF0E1726)),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF64748B)),
      onTap: onTap,
    );
  }

  Widget _buildContactField(IconData icon, String title, String description) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF64748B)),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
            Text(description, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF1E293B))),
          ],
        )
      ],
    );
  }

  Widget _buildModernInfoRow(IconData icon, String label, String value, {bool highlightValue = false}) {
    final bool isEmpty = value.isEmpty || value.toLowerCase() == 'n/a';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF94A3B8)),
          const SizedBox(width: 12),
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              !isEmpty ? value : 'Not Specified',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isEmpty 
                    ? const Color(0xFFCBD5E1)
                    : (highlightValue ? const Color(0xFF16A34A) : const Color(0xFF0E1726)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? date) {
    if (date == null || date.isEmpty || date == '0000-00-00') return 'N/A';
    try {
      final parsed = DateTime.parse(date);
      return DateFormat('MM/dd/yyyy').format(parsed);
    } catch (e) {
      return date;
    }
  }
}