// lib/models/donor_profile.dart
class DonorProfile {
  final IndividualCompany individualCompany;
  final List<FamilyDetail> familyDetails;
  final List<CompanyDetail> companyDetails;
  final List<RelatedGroup> relatedGroup;
  final List<DonorReceipt> donorReceipts;
  final List<MembershipDetail> membershipDetails;
  final List<ImageUrl> imageUrl;

  DonorProfile({
    required this.individualCompany,
    required this.familyDetails,
    required this.companyDetails,
    required this.relatedGroup,
    required this.donorReceipts,
    required this.membershipDetails,
    required this.imageUrl,
  });

  factory DonorProfile.fromJson(Map<String, dynamic> json) {
    return DonorProfile(
      individualCompany: IndividualCompany.fromJson(json['individualCompany'] ?? {}),
      familyDetails: (json['family_details'] as List? ?? [])
          .map((e) => FamilyDetail.fromJson(e))
          .toList(),
      companyDetails: (json['company_details'] as List? ?? [])
          .map((e) => CompanyDetail.fromJson(e))
          .toList(),
      relatedGroup: (json['related_group'] as List? ?? [])
          .map((e) => RelatedGroup.fromJson(e))
          .toList(),
      donorReceipts: (json['donor_receipts'] as List? ?? [])
          .map((e) => DonorReceipt.fromJson(e))
          .toList(),
      membershipDetails: (json['membership_details'] as List? ?? [])
          .map((e) => MembershipDetail.fromJson(e))
          .toList(),
      imageUrl: (json['image_url'] as List? ?? [])
          .map((e) => ImageUrl.fromJson(e))
          .toList(),
    );
  }
}

class IndividualCompany {
  final int id;
  final String imageLogo;
  final String fullName;
  final String title;
  final String type;
  final String gender;
  final String status;
  final String source;
  final String mobilePhone;
  final String email;
  final String panNo;
  final String dob;
  final String joiningDate;
  final String lastLogin;
  final String city;
  final String state;
  final String pinCode;
  final String address;
  final int ftsId;
  final String spouseName;
  final String fatherName;
  final String motherName;
  String get donorImageUrl {
  return imageLogo.isNotEmpty
      ? 'https://agstest.in/api2/public/assets/images/donor_images/$imageLogo'
      : 'https://agstest.in/api2/public/assets/images/no_image.jpg';
}

  IndividualCompany({
    required this.id,
    required this.imageLogo,
    required this.fullName,
    required this.title,
    required this.type,
    required this.gender,
    required this.status,
    required this.source,
    required this.mobilePhone,
    required this.email,
    required this.panNo,
    required this.dob,
    required this.joiningDate,
    required this.lastLogin,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.address,
    required this.ftsId,
    required this.spouseName,
    required this.fatherName,
    required this.motherName,
  });

  factory IndividualCompany.fromJson(Map<String, dynamic> json) {
    return IndividualCompany(
      id: json['id'] ?? 0,
      imageLogo: json['indicomp_image_logo'] ?? '',
      fullName: json['indicomp_full_name'] ?? '',
      title: json['title'] ?? '',
      type: json['indicomp_type'] ?? '',
      gender: json['indicomp_gender'] ?? '',
      status: json['indicomp_status'] ?? '',
      source: json['indicomp_source'] ?? '',
      mobilePhone: json['indicomp_mobile_phone'] ?? '',
      email: json['indicomp_email'] ?? '',
      panNo: json['indicomp_pan_no'] ?? '',
      dob: json['indicomp_dob_annualday'] ?? '',
      joiningDate: json['indicomp_joining_date'] ?? '',
      lastLogin: json['last_login'] ?? '',
      city: json['indicomp_res_reg_city'] ?? '',
      state: json['indicomp_res_reg_state'] ?? '',
      pinCode: json['indicomp_res_reg_pin_code'] ?? '',
      address: json['indicomp_res_reg_address'] ?? '',
      ftsId: json['indicomp_fts_id'] ?? 0,
      spouseName: json['indicomp_spouse_name'] ?? '',
      fatherName: json['indicomp_father_name'] ?? '',
      motherName: json['indicomp_mother_name'] ?? '',
      
    );
    
  }
  
}

class FamilyDetail {
  final int id;
  final String fullName;
  final String title;
  final String gender;
  final String belongsTo;
  final String donorType;
  final String status;
  final String mobilePhone;
  final String email;

  FamilyDetail({
    required this.id,
    required this.fullName,
    required this.title,
    required this.gender,
    required this.belongsTo,
    required this.donorType,
    required this.status,
    required this.mobilePhone,
    required this.email,
  });

  factory FamilyDetail.fromJson(Map<String, dynamic> json) {
    return FamilyDetail(
      id: json['id'] ?? 0,
      fullName: json['indicomp_full_name'] ?? '',
      title: json['title'] ?? '',
      gender: json['indicomp_gender'] ?? '',
      belongsTo: json['indicomp_belongs_to'] ?? '',
      donorType: json['indicomp_donor_type'] ?? '',
      status: json['indicomp_status'] ?? '',
      mobilePhone: json['indicomp_mobile_phone'] ?? '',
      email: json['indicomp_email'] ?? '',
    );
  }
}

class CompanyDetail {
  final int id;
  final String fullName;
  final String title;
  final String contactName;
  final String mobilePhone;
  final String email;
  final String city;
  final String state;

  CompanyDetail({
    required this.id,
    required this.fullName,
    required this.title,
    required this.contactName,
    required this.mobilePhone,
    required this.email,
    required this.city,
    required this.state,
  });

  factory CompanyDetail.fromJson(Map<String, dynamic> json) {
    return CompanyDetail(
      id: json['id'] ?? 0,
      fullName: json['indicomp_full_name'] ?? '',
      title: json['title'] ?? '',
      contactName: json['indicomp_com_contact_name'] ?? '',
      mobilePhone: json['indicomp_mobile_phone'] ?? '',
      email: json['indicomp_email'] ?? '',
      city: json['indicomp_res_reg_city'] ?? '',
      state: json['indicomp_res_reg_state'] ?? '',
    );
  }
}

class RelatedGroup {
  final String fullName;

  RelatedGroup({required this.fullName});

  factory RelatedGroup.fromJson(Map<String, dynamic> json) {
    return RelatedGroup(
      fullName: json['indicomp_full_name'] ?? '',
    );
  }
}

class DonorReceipt {
  final String receiptNo;
  final String fullName;
  final String receiptDate;
  final String amount;

  DonorReceipt({
    required this.receiptNo,
    required this.fullName,
    required this.receiptDate,
    required this.amount,
  });

  factory DonorReceipt.fromJson(Map<String, dynamic> json) {
    return DonorReceipt(
      receiptNo: json['receipt_no'] ?? '',
      fullName: json['indicomp_full_name'] ?? '',
      receiptDate: json['receipt_date'] ?? '',
      amount: json['receipt_total_amount'] ?? '0',
    );
  }
}

class MembershipDetail {
  final int id;
  final String receiptNo;
  final String receiptDate;
  final String amount;
  final String validity;
  final String donationType;
  final String financialYear;

  MembershipDetail({
    required this.id,
    required this.receiptNo,
    required this.receiptDate,
    required this.amount,
    required this.validity,
    required this.donationType,
    required this.financialYear,
  });

  factory MembershipDetail.fromJson(Map<String, dynamic> json) {
    return MembershipDetail(
      id: json['id'] ?? 0,
      receiptNo: json['receipt_no'] ?? '',
      receiptDate: json['receipt_date'] ?? '',
      amount: json['receipt_total_amount'] ?? '0',
      validity: json['m_ship_vailidity'] ?? '',
      donationType: json['receipt_donation_type'] ?? '',
      financialYear: json['receipt_financial_year'] ?? '',
    );
  }
}

class ImageUrl {
  final String imageFor;
  final String imageUrl;

  ImageUrl({
    required this.imageFor,
    required this.imageUrl,
  });

  factory ImageUrl.fromJson(Map<String, dynamic> json) {
    return ImageUrl(
      imageFor: json['image_for'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}