import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "user_type")
  String? userType;
  // @JsonKey(name: "surname")
  // String? surname;
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "last_name")
  String? lastName;
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "language")
  String? language;
  @JsonKey(name: "contact_no")
  dynamic contactNo;
  @JsonKey(name: "address")
  dynamic address;
  @JsonKey(name: "api_token")
  String? apiToken;
  @JsonKey(name: "business_id")
  int? businessId;
  @JsonKey(name: "essentials_department_id")
  dynamic essentialsDepartmentId;
  @JsonKey(name: "essentials_designation_id")
  dynamic essentialsDesignationId;
  @JsonKey(name: "essentials_salary")
  dynamic essentialsSalary;
  @JsonKey(name: "essentials_pay_period")
  String? essentialsPayPeriod;
  @JsonKey(name: "essentials_pay_cycle")
  dynamic essentialsPayCycle;
  @JsonKey(name: "available_at")
  dynamic availableAt;
  @JsonKey(name: "paused_at")
  dynamic pausedAt;
  @JsonKey(name: "max_sales_discount_percent")
  dynamic maxSalesDiscountPercent;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "is_root")
  dynamic isRoot;
  @JsonKey(name: "crm_contact_id")
  dynamic crmContactId;
  @JsonKey(name: "is_cmmsn_agnt")
  int? isCmmsnAgnt;
  @JsonKey(name: "cmmsn_percent")
  String? cmmsnPercent;
  @JsonKey(name: "gender")
  dynamic gender;
  @JsonKey(name: "contact_number")
  dynamic contactNumber;
  @JsonKey(name: "current_address")
  dynamic currentAddress;
  @JsonKey(name: "location_id")
  dynamic locationId;
  @JsonKey(name: "initial_money")
  dynamic initialMoney;
  @JsonKey(name: "firebase_token")
  String? firebaseToken;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "essentials_department_name")
  String? essentialsDepartmentName;
  @JsonKey(name: "essentials_designation_name")
  String? essentialsDesignationName;
  @JsonKey(name: "profile_image")
  String? profileImage;

  String get fullName {
    return "${firstName ?? ""} ${lastName ?? ""}";
  }

  String get joined {
    return "${"joined"} ${createdAt?.year ?? ""}";
  }

  UserEntity({
    this.id,
    this.userType,
    //this.surname,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.language,
    this.contactNo,
    this.address,
    this.apiToken,
    this.businessId,
    this.essentialsDepartmentId,
    this.essentialsDesignationId,
    this.essentialsSalary,
    this.essentialsPayPeriod,
    this.essentialsPayCycle,
    this.availableAt,
    this.pausedAt,
    this.maxSalesDiscountPercent,
    this.status,
    this.isRoot,
    this.crmContactId,
    this.isCmmsnAgnt,
    this.cmmsnPercent,
    this.gender,
    this.contactNumber,
    this.currentAddress,
    this.locationId,
    this.initialMoney,
    this.firebaseToken,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.essentialsDepartmentName,
    this.essentialsDesignationName,
    this.profileImage,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
