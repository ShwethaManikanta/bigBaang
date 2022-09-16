import 'dart:convert';

class SignInRequest {
  String phoneNumber;
  // String password;
  String deviceType;
  String deviceToken;
  SignInRequest(
      {required this.phoneNumber,
      required this.deviceToken,
      required this.deviceType});

  Map<String, dynamic> toMap() {
    return {
      'mobile': phoneNumber,
      'device_token': deviceToken,
      'device_type': deviceType
    };
  }

  String toJson() => json.encode(toMap());
}

class SignInResponse {
  late String status;
  late String message;
  late CustomerDetails? customerDetails;

  SignInResponse(
      {required this.status,
      required this.message,
      required this.customerDetails});

  SignInResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    customerDetails = json['customer_details'] != null
        ? CustomerDetails.fromJson(json['customer_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    if (customerDetails != null) {
      data['customer_details'] = customerDetails!.toJson();
    }
    return data;
  }
}

class CustomerDetails {
  late String id;
  late String username;
  late String mobileNo;
  late String email;
  late String password;
  late String decryptPassword;
  late String profileImage;
  late String dob;
  late String address;
  late String latitude;
  late String longitude;
  late String notification;
  late String status;
  late String isEmailVerified;
  late String isMobileVerified;
  late String deviceType;
  late String deviceToken;
  late String deviceModel;
  late String deviceVersion;
  late String createdAt;
  late String updatedAt;

  CustomerDetails(
      {required this.id,
      required this.username,
      required this.mobileNo,
      required this.email,
      required this.password,
      required this.decryptPassword,
      required this.profileImage,
      required this.dob,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.notification,
      required this.status,
      required this.isEmailVerified,
      required this.isMobileVerified,
      required this.deviceType,
      required this.deviceToken,
      required this.deviceModel,
      required this.deviceVersion,
      required this.createdAt,
      required this.updatedAt});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    mobileNo = json['mobile_no'];
    email = json['email'];
    password = json['password'];
    decryptPassword = json['decrypt_password'];
    profileImage = json['profile_image'];
    dob = json['dob'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    notification = json['notification'];
    status = json['status'];
    isEmailVerified = json['is_email_verified'];
    isMobileVerified = json['is_mobile_verified'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    deviceModel = json['device_model'];
    deviceVersion = json['device_version'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['username'] = username;
    data['mobile_no'] = mobileNo;
    data['email'] = email;
    data['password'] = password;
    data['decrypt_password'] = decryptPassword;
    data['profile_image'] = profileImage;
    data['dob'] = dob;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['notification'] = notification;
    data['status'] = status;
    data['is_email_verified'] = isEmailVerified;
    data['is_mobile_verified'] = isMobileVerified;
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    data['device_model'] = deviceModel;
    data['device_version'] = deviceVersion;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
