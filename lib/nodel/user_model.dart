// lib/models/user_model.dart
class User {
  final int id;
  final String fullName;
  final String email;
  final String mobilePhone;
  final String? token;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.mobilePhone,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      fullName: json['indicomp_full_name'] ?? '',
      email: json['indicomp_email'] ?? '',
      mobilePhone: json['indicomp_mobile_phone'] ?? '',
    );
  }
}
// lib/models/school_allotment.dart
// lib/models/school_allotment.dart
class SchoolAllotment {
  final int id;
  final String fullName;
  final String allotmentYear;
  final String noOfOts;
  final int noOfSchoolsAllotted;
  final String fromDate;
  final String toDate;
  final String financialYear;
  final int ftsId;
  final String schoolId;

  SchoolAllotment({
    required this.id,
    required this.fullName,
    required this.allotmentYear,
    required this.noOfOts,
    required this.noOfSchoolsAllotted,
    required this.fromDate,
    required this.toDate,
    required this.financialYear,
    required this.ftsId,
    required this.schoolId,
  });

  factory SchoolAllotment.fromJson(Map<String, dynamic> json) {
    return SchoolAllotment(
      id: json['id'] ?? 0,
      fullName: json['indicomp_full_name'] ?? '',
      allotmentYear: json['schoolalot_year'] ?? '',
      noOfOts: json['receipt_no_of_ots'] ?? '0',
      noOfSchoolsAllotted: json['no_of_schools_allotted'] ?? 0,
      fromDate: json['schoolalot_from_date'] ?? '',
      toDate: json['schoolalot_to_date'] ?? '',
      financialYear: json['schoolalot_financial_year'] ?? '',
      ftsId: json['schoolallot_indicomp_fts_id'] ?? 0,
      schoolId: json['schoolalot_school_id'] ?? '',
    );
  }
}
// lib/models/school_detail.dart
class SchoolDetail {
  final int id;
  final String schoolCode;
  final String village;
  final String district;
  final String state;
  final String achal;
  final String cluster;
  final String subCluster;

  SchoolDetail({
    required this.id,
    required this.schoolCode,
    required this.village,
    required this.district,
    required this.state,
    required this.achal,
    required this.cluster,
    required this.subCluster,
  });

  factory SchoolDetail.fromJson(Map<String, dynamic> json) {
    return SchoolDetail(
      id: json['id'] ?? 0,
      schoolCode: json['school_code'] ?? '',
      village: json['village'] ?? '',
      district: json['district'] ?? '',
      state: json['school_state'] ?? '',
      achal: json['achal'] ?? '',
      cluster: json['cluster'] ?? '',
      subCluster: json['sub_cluster'] ?? '',
    );
  }
}