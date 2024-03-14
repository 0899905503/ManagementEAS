// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      id: json['id'] as int?,
      // userType: json['user_type'] as String?,
      // surname: json['surname'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      // username: json['username'] as String?,
      email: json['email'] as String?,
      //  language: json['language'] as String?,
      contactNo: json['phone_number'],
      address: json['address'],
      apiToken: json['api_token'] as String?,
      // businessId: json['business_id'] as int?,
      // essentialsDepartmentId: json['essentials_department_id'],
      //essentialsDesignationId: json['essentials_designation_id'],
      // essentialsSalary: json['essentials_salary'],
      //essentialsPayPeriod: json['essentials_pay_period'] as String?,
      // essentialsPayCycle: json['essentials_pay_cycle'],
      //availableAt: json['available_at'],
      //  pausedAt: json['paused_at'],
      //  maxSalesDiscountPercent: json['max_sales_discount_percent'],
      status: json['status'] as String?,
      isRoot: json['is_root'],
      crmContactId: json['crm_contact_id'],
      isCmmsnAgnt: json['is_cmmsn_agnt'] as int?,
      cmmsnPercent: json['cmmsn_percent'] as String?,
      gender: json['gender'],
      // contactNumber: json['contact_number'],
      // currentAddress: json['current_address'],
      locationId: json['location_id'],
      initialMoney: json['initial_money'],
      firebaseToken: json['firebase_token'] as String?,
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      essentialsDepartmentName: json['essentials_department_name'] as String?,
      essentialsDesignationName: json['essentials_designation_name'] as String?,
      profileImage: json['profile_image'] as String?,
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_type': instance.userType,
      //'surname': instance.surname,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'username': instance.username,
      'email': instance.email,
      'language': instance.language,
      'contact_no': instance.contactNo,
      'address': instance.address,
      'api_token': instance.apiToken,
      'business_id': instance.businessId,
      'essentials_department_id': instance.essentialsDepartmentId,
      'essentials_designation_id': instance.essentialsDesignationId,
      'essentials_salary': instance.essentialsSalary,
      'essentials_pay_period': instance.essentialsPayPeriod,
      'essentials_pay_cycle': instance.essentialsPayCycle,
      'available_at': instance.availableAt,
      'paused_at': instance.pausedAt,
      'max_sales_discount_percent': instance.maxSalesDiscountPercent,
      'status': instance.status,
      'is_root': instance.isRoot,
      'crm_contact_id': instance.crmContactId,
      'is_cmmsn_agnt': instance.isCmmsnAgnt,
      'cmmsn_percent': instance.cmmsnPercent,
      'gender': instance.gender,
      'contact_number': instance.contactNumber,
      'current_address': instance.currentAddress,
      'location_id': instance.locationId,
      'initial_money': instance.initialMoney,
      'firebase_token': instance.firebaseToken,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'essentials_department_name': instance.essentialsDepartmentName,
      'essentials_designation_name': instance.essentialsDesignationName,
      'profile_image': instance.profileImage,
    };
