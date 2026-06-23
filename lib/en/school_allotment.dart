import 'package:bbbbbb/en/detail.dart';
import 'package:bbbbbb/er/er.dart';
import 'package:bbbbbb/nodel/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SchoolAllotmentScreen extends StatefulWidget {
  const SchoolAllotmentScreen({super.key});

  @override
  State<SchoolAllotmentScreen> createState() => _SchoolAllotmentScreenState();
}

class _SchoolAllotmentScreenState extends State<SchoolAllotmentScreen> {
  List<SchoolAllotment> _allotments = [];
  bool _isLoading = true;
  String _searchQuery = '';
  String _selectedFilter = 'All';
  
  // Advanced State Sort Configuration
  bool _isDescending = true;
  String _currentSortField = 'fromDate'; 

  final List<String> _filterOptions = [
    'All',
    '2025-26',
    '2024-25',
    '2023-24',
  ];

  @override
  void initState() {
    super.initState();
    _loadAllotments();
  }

  Future<void> _loadAllotments() async {
    setState(() => _isLoading = true);
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final allotments = await authProvider.fetchSchoolAllotments();
    
    setState(() {
      _allotments = allotments;
      _isLoading = false;
    });
  }

  List<SchoolAllotment> get _filteredAllotments {
    var filtered = _allotments;
    
    // Apply financial year filter criteria
    if (_selectedFilter != 'All') {
      filtered = filtered.where((item) => 
        item.allotmentYear == _selectedFilter
      ).toList();
    }
    
    // Apply cross-field fuzzy search parameters
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((item) => 
        item.fullName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        item.schoolId.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }
    
    // Exact sorting algorithms executed based on selected properties
    filtered.sort((a, b) {
      int comparison = 0;
      switch (_currentSortField) {
        case 'name':
          comparison = a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase());
          break;
        case 'year':
          comparison = a.allotmentYear.compareTo(b.allotmentYear);
          break;
        case 'ots':
          final aOts = int.tryParse(a.noOfOts.toString()) ?? 0;
          final bOts = int.tryParse(b.noOfOts.toString()) ?? 0;
          comparison = aOts.compareTo(bOts);
          break;
        case 'schools':
          comparison = a.noOfSchoolsAllotted.compareTo(b.noOfSchoolsAllotted);
          break;
        case 'toDate':
          comparison = a.toDate.compareTo(b.toDate);
          break;
        case 'fromDate':
        default:
          comparison = a.fromDate.compareTo(b.fromDate);
          break;
      }
      return _isDescending ? -comparison : comparison;
    });
    
    return filtered;
  }

  int get _totalSchoolsAllotted {
    int total = 0;
    for (var allotment in _allotments) {
      total += allotment.noOfSchoolsAllotted;
    }
    return total;
  }

  int get _totalOTS {
    int total = 0;
    for (var allotment in _allotments) {
      total += int.tryParse(allotment.noOfOts.toString()) ?? 0;
    }
    return total;
  }

  void _sortBy(String field) {
    setState(() {
      if (_currentSortField == field) {
        _isDescending = !_isDescending;
      } else {
        _currentSortField = field;
        _isDescending = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
          'School Allotments',
          style: TextStyle(
            color: Color(0xFF0E1726),
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFF1A237E)),
            onPressed: _loadAllotments,
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Container - Total Schools Allotted
         Container(
  margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
  padding: const EdgeInsets.all(14),
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      colors: [
        Color(0xFF1A237E),
        Color(0xFF283593),
      ],
    ),
    borderRadius: BorderRadius.circular(16),
  ),
  child: Row(
    children: [
   

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Container(
  padding: const EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 8,
  ),
  decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.15),
    borderRadius: BorderRadius.circular(12),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(
        Icons.school_outlined,
        color: Colors.white,
        size: 14,
      ),
      const SizedBox(width: 6),
      const Text(
        'Number Of Schools Alloted:',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(width: 6),
      Text(
        _totalSchoolsAllotted.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
),

          
          ],
        ),
      ),
    ],
  ),
),

          // Filter, Search Section
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFFAF8F5),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search by company name or ID...',
                            hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                            prefixIcon: Icon(Icons.search, color: Color(0xFF64748B), size: 20),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedFilter,
                          icon: const Icon(Icons.filter_list, color: Color(0xFF1A237E), size: 18),
                          dropdownColor: Colors.white,
                          items: _filterOptions.map((option) {
                            return DropdownMenuItem(
                              value: option,
                              child: Text(
                                option == 'All' ? 'All Years' : option,
                                style: const TextStyle(fontSize: 13, color: Color(0xFF0E1726), fontWeight: FontWeight.w500),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedFilter = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
               
                // Sort Chips Row
               
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Showing ${_filteredAllotments.length} results',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (_searchQuery.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.clear, size: 16, color: Color(0xFF94A3B8)),
                            SizedBox(width: 4),
                            Text(
                              'Clear',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF94A3B8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Main List View - All data displayed without pagination
          Expanded(
            child: _isLoading
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1A237E)),
                        ),
                        SizedBox(height: 16),
                        Text('Loading allotments...', style: TextStyle(color: Color(0xFF64748B))),
                      ],
                    ),
                  )
                : _filteredAllotments.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.school_outlined, size: 64, color: Colors.grey[300]),
                            const SizedBox(height: 16),
                            const Text(
                              'No allotments found',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Try adjusting your search criteria or tags',
                              style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                        itemCount: _filteredAllotments.length,
                        itemBuilder: (context, index) {
                          final allotment = _filteredAllotments[index];
                          return _buildAllotmentMobileCard(allotment);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  // Stats Item Widget
  Widget _buildStatsItem(IconData icon, String label, String value, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: color.withOpacity(0.8), size: 18),
            const SizedBox(width: 6),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: color.withOpacity(0.7),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Interactive UI Helper Components
  Widget _buildSortChip(String label, String field) {
    final isSelected = _currentSortField == field;
    return GestureDetector(
      onTap: () => _sortBy(field),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A237E) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? const Color(0xFF1A237E) : const Color(0xFFE2E8F0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : const Color(0xFF475569),
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 4),
              Icon(
                _isDescending ? Icons.arrow_downward : Icons.arrow_upward,
                color: Colors.white,
                size: 12,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAllotmentMobileCard(SchoolAllotment allotment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0E1726).withOpacity(0.03),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row Component within Mobile Card
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  allotment.fullName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0E1726),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  allotment.allotmentYear,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          
          // Data Analytics Badges Frame Area
          Row(
            children: [
              _buildMetricChip(Icons.token_outlined, '${allotment.noOfOts} OTS', const Color(0xFF0F172A)),
              const SizedBox(width: 10),
              _buildMetricChip(Icons.school_outlined, '${allotment.noOfSchoolsAllotted} Schools', const Color(0xFF0284C7)),
              const Spacer(),
              _buildActionButton(
                icon: Icons.visibility_outlined,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SchoolDetailScreen(
                        allotmentId: allotment.id,
                        allotmentYear: allotment.allotmentYear,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildMetricChip(IconData icon, String val, Color primaryTint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: primaryTint.withOpacity(0.06),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: primaryTint),
          const SizedBox(width: 4),
          Text(
            val,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: primaryTint),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF8F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Icon(icon, color: const Color(0xFF1A237E), size: 18),
      ),
    );
  }

  void _showSchoolDetails(SchoolAllotment allotment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.85,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.fromLTRB(24, 14, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Allotment Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0E1726),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _buildDetailRow('Company Name', allotment.fullName),
                        _buildDetailRow('Allotment Year', allotment.allotmentYear),
                        _buildDetailRow('No. of OTS', allotment.noOfOts),
                        _buildDetailRow('Schools Allotted', allotment.noOfSchoolsAllotted.toString()),
                        _buildDetailRow('From Date', _formatDate(allotment.fromDate)),
                        _buildDetailRow('To Date', _formatDate(allotment.toDate)),
                        _buildDetailRow('Financial Year', allotment.financialYear),
                        _buildDetailRow('School ID', allotment.schoolId),
                        _buildDetailRow('FTS ID', allotment.ftsId.toString()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A237E),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Close Details',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : 'N/A',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0E1726),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return 'N/A';
    try {
      final parsed = DateTime.parse(date);
      return DateFormat('d MMM yyyy').format(parsed);
    } catch (e) {
      return date;
    }
  }
}