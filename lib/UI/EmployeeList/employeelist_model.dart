class EmployeeListModel {
  final int? id;
  final String? personalId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? gender;
  final String? address;
  final String? birthDate;
  final String? active;
  final String? qualification;
  final String? nationality;
  final String? ethnicity;
  final String? religion;
  final String? issueDate;
  final String? issueBy;
  final String? startDate;
  final String? language;
  final String? computerSience;
  final String? permanentAddress;
  final String? roleId;
  final String? subsidyId;
  // Thêm các trường khác tương ứng với dữ liệu

  EmployeeListModel({
    required this.id,
    required this.personalId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.address,
    required this.birthDate,
    required this.active,
    required this.qualification,
    required this.nationality,
    required this.ethnicity,
    required this.religion,
    required this.issueDate,
    required this.issueBy,
    required this.startDate,
    required this.language,
    required this.computerSience,
    required this.permanentAddress,
    required this.roleId,
    required this.subsidyId,
    // Thêm các trường khác tương ứng với dữ liệu
  });

  factory EmployeeListModel.fromJson(Map<String, dynamic> json) {
    return EmployeeListModel(
      id: json['id'] ?? 0,
      personalId: json['Personal Id'] ?? "personal id",
      firstName: json['first_name'] ?? " ",
      lastName: json['last_name'] ?? " ",
      email: json['email'] ?? " ",
      phoneNumber: json['phone_number'] ?? " ",
      gender: json['gender'] ?? "nam",
      address: json['address'] ?? " ",
      birthDate: json['birth_date'] ?? " ",
      active: json['is_active'] ?? " ",
      qualification: json['Qualification'] ?? "Qualification",
      nationality: json['Nationality'] ?? "Nationality",
      ethnicity: json['Ethnicity'] ?? "Ethnicity",
      religion: json['Religion'] ?? "Religion",
      issueDate: json['Issue Date'] ?? "Issue Date",
      issueBy: json['Issued By'] ?? "Issued By",
      startDate: json['Start Date'] ?? "Start Date",
      language: json['Language'] ?? "Language",
      computerSience: json['Computer Science'] ?? "Computer Science",
      permanentAddress: json['Permanent Address'] ?? "Permanent Address",
      roleId: json['Role_id'] ?? "Role_id",
      subsidyId: json['Subsidy_id'] ?? "Subsidy_id",
      // Thêm các trường khác tương ứng với dữ liệu
    );
  }
}
