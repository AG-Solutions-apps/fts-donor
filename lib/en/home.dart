import 'package:bbbbbb/en/n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
// Keep your existing working logic imports unmodified
import 'package:bbbbbb/en/ings.dart';
import 'package:bbbbbb/en/school_allotment.dart';
import 'package:bbbbbb/er/er.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
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
          elevation: 0,
          backgroundColor: const Color(0xFFFAF8F5),
          title: const Text(
            'Fts Donor App',
            style: TextStyle(color: Color(0xFF0E1726), fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Color(0xFF0E1726)),
              onPressed: () async {
                await authProvider.logout();
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
            ),
          ],
        ),
        body: const Center(
          child: Text('No profile data available', style: TextStyle(color: Color(0xFF0E1726))),
        ),
      );
    }

    final company = profile.individualCompany;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
        bottomNavigationBar: Padding(
  padding: const EdgeInsets.only(
    left: 16,
    right: 16,
    bottom: 16,
  ),
  child: Container(
    height: 52,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
    _navItem(
      context,
      Icons.home_rounded,
      "Home",
      true,
      const HomeScreen(),
    ),

    _navItem(
      context,
      Icons.school,
      "School",
      false,
      const SchoolAllotmentScreen(),
    ),

    _navItem(
      context,
      Icons.favorite_rounded,
      "Donate",
      false,
      const ProfileSettingsScreen(), // Create this screen
    ),

    _navItem(
      context,
      Icons.people_alt_rounded,
      "Group",
      false,
      const FamilyScreen(), // Create this screen
    ),

    _navItem(
      context,
      Icons.person_rounded,
      "Profile",
      false,
      const ProfileSettingsScreen(),
    ),
  ],
),
  ),
), // Exact warm ivory background matching image
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFAF8F5),
        iconTheme: const IconThemeData(color: Color(0xFF0E1726)),
        title: const Text(
          'Fts Donor App',
          style: TextStyle(
            color: Color(0xFF0E1726),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
         
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFF0E1726)),
            onPressed: () async {
              await authProvider.logout();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header Block
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome, ${company.fullName}',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0E1726),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          _buildTopBadge(company.type ?? "N/A", const Color(0xFF0F172A), Colors.white),
                          _buildTopBadge(company.status ?? "Active", const Color(0xFFEAB308), const Color(0xFF713F12)),
                          _buildTopBadge(company.source ?? "Direct", const Color(0xFFDBEAFE), const Color(0xFF1E40AF)),
                        ],
                      ),
                    ],
                  ),
                ),
                // Top Right Stat Counters Metrics Block
                Row(
                  children: [
                    _buildTopCountItem(Icons.people_outline, profile.familyDetails.length.toString(), 'Family Members'),
                    const SizedBox(width: 12),
                    _buildTopCountItem(Icons.business, profile.companyDetails.length.toString(), 'Companies'),
                    const SizedBox(width: 12),
                    _buildTopCountItem(Icons.receipt_long_outlined, profile.donorReceipts.length.toString(), 'Receipts'),
                  ],
                ),
              ],
            ),
          

            // Profile Media, ID, and Contact Card Row
           
            const SizedBox(height: 16),

            // Layout Container Row for Donations, Memberships and Family Members
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // Total Donations Card Box
                    Container(
  padding: const EdgeInsets.all(18),
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF2563EB),
        Color(0xFF1D4ED8),
        Color(0xFF1E40AF),
      ],
    ),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF2563EB).withOpacity(0.25),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'Total Donations',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
          ),
          Icon(
            Icons.favorite_rounded,
            color: Colors.white,
            size: 22,
          ),
        ],
      ),
      const SizedBox(height: 8),
      const Text(
        '₹0',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      const Text(
        'Current year contributions',
        style: TextStyle(
          fontSize: 12,
          color: Colors.white70,
        ),
      ),
      const SizedBox(height: 14),
      Container(
        height: 1,
        color: Colors.white24,
      ),
      const SizedBox(height: 14),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.receipt_long,
                size: 16,
                color: Colors.white70,
              ),
              const SizedBox(width: 6),
              Text(
                '${profile.donorReceipts.length} receipts issued',
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Donate Now',
              style: TextStyle(
                color: Color(0xFF1D4ED8),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    ],
  ),
),
                      const SizedBox(height: 16),

                      // Membership Accent Card
                      if (profile.membershipDetails.isNotEmpty) ...[
                        Builder(
                          builder: (context) {
                            final membership = profile.membershipDetails.first;
                            return Container(
  padding: const EdgeInsets.all(18),
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF0F172A),
        Color(0xFF1E3A8A),
        Color(0xFF2563EB),
      ],
    ),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF1E40AF).withOpacity(0.25),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Membership',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.verified,
                  color: Colors.white,
                  size: 14,
                ),
                SizedBox(width: 4),
                Text(
                  'Active',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      _buildMembershipRow(
        'Receipt No.',
        membership.receiptNo,
      ),
      const SizedBox(height: 10),
      _buildMembershipRow(
        'Amount',
        '₹${_formatAmount(membership.amount)}',
      ),
      if (membership.validity.isNotEmpty) ...[
        const SizedBox(height: 10),
        _buildMembershipRow(
          'Valid Until',
          membership.validity,
        ),
      ],
    ],
  ),
);
                          },
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                
                // Right Segment Stack: Family Members Container Box
                
              ],
              
            ),
             const SizedBox(height: 20),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Receipts',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF0E1726)),
                ),
                Text(
                  '${profile.donorReceipts.length}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0E1726)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 185,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: profile.donorReceipts.length,
                itemBuilder: (context, index) {
                  final receipt = profile.donorReceipts[index];
                  return Container(
                    width: 210,
                    margin: const EdgeInsets.only(right: 12, bottom: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1F2), // Accent delicate pink tint container matching layout asset
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.wallet, size: 14, color: Color(0xFF1E293B)),
                            const SizedBox(width: 4),
                            Text(
                              'Receipt : ${receipt.receiptNo}',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(receipt.fullName, style: const TextStyle(fontSize: 11, color: Color(0xFF475569))),
                                Text(_formatDate(receipt.receiptDate), style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                              ],
                            ),
                            Text(
                              '₹${_formatAmount(receipt.amount)}',
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
           
            const SizedBox(height: 20),

            // Bottom Core Tracking State: Recent Activity Component Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1D4ED8), // Vibrant Royal Cobalt Blue module design metric matching image layout
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Activity',
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const Icon(Icons.access_time, color: Colors.white70, size: 18),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildActivityTimelineRow('Last Login', _formatDate(company.lastLogin), Colors.yellow),
                  const Divider(color: Colors.white24, height: 12),
                  _buildActivityTimelineRow('Last Updated', _formatDate(company.lastLogin), Colors.amberAccent),
                  const Divider(color: Colors.white24, height: 12),
                  _buildActivityTimelineRow('Joining Date', _formatDate(company.joiningDate), Colors.lightBlueAccent),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // UI Construction Helper Elements
  Widget _buildTopBadge(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(color: text, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildTopCountItem(IconData icon, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(icon, size: 15, color: const Color(0xFF475569)),
            const SizedBox(width: 4),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0E1726))),
          ],
        ),
        Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
      ],
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

  Widget _buildMembershipRow(String title, String val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        Text(val, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildFamilyMemberItem(dynamic family) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xFFE2E8F0),
            child: const Icon(Icons.person, size: 16, color: Color(0xFF64748B)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${family.title} ${family.fullName}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                ),
                Text(
                  '${family.gender} • Individual',
                  style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                ),
                if (family.donorType != null && family.donorType.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF08A),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      family.donorType,
                      style: const TextStyle(color: Color(0xFF713F12), fontSize: 9, fontWeight: FontWeight.bold),
                    ),
                  )
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
Widget _navItem(
  BuildContext context,
  IconData icon,
  String label,
  bool selected,
  Widget screen,
) {
  return InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => screen,
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: selected
                ? const Color(0xFF1A237E)
                : const Color(0xFF94A3B8),
            size: 16,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: selected
                  ? FontWeight.w700
                  : FontWeight.w500,
              color: selected
                  ? const Color(0xFF1A237E)
                  : const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    ),
  );
}
Widget _centerDonateButton() {
  return Container(
    height: 54,
    width: 54,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFDC2626),
          Color(0xFFEF4444),
        ],
      ),
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFDC2626)
              .withOpacity(0.35),
          blurRadius: 15,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: const Icon(
      Icons.favorite_rounded,
      color: Colors.white,
      size: 28,
    ),
  );
}
  Widget _buildActivityTimelineRow(String title, String val, Color statusColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 13)),
          ],
        ),
        Text(val, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Safe formatting parsing utilities
  String _formatDate(String? date) {
    if (date == null || date.isEmpty || date == '0000-00-00') return 'N/A';
    try {
      final parsed = DateTime.parse(date);
      return DateFormat('dd MMM yyyy').format(parsed);
    } catch (e) {
      return date;
    }
  }

  String _formatAmount(String amount) {
    try {
      final value = double.parse(amount);
      return NumberFormat('#,##,###').format(value);
    } catch (e) {
      return amount;
    }
  }
  
}