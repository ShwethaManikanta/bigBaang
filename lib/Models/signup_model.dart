import 'dart:convert';

class SignUpRequest {
  String name;
  String mobile;
  String email;
  String profileImage;
  String password, deviceType, deviceToken;
  SignUpRequest(
      {required this.name,
      required this.mobile,
      required this.email,
      required this.password,
      required this.deviceType,
      required this.deviceToken,
      required this.profileImage});

  SignUpRequest copyWith(
      {String? regName,
      String? mobile,
      String? email,
      String? password,
      String? deviceType,
      String? deviceToken,
      String? profileImage}) {
    return SignUpRequest(
        name: regName ?? this.name,
        mobile: mobile ?? this.mobile,
        email: email ?? this.email,
        password: password ?? this.password,
        deviceType: deviceType ?? this.deviceType,
        deviceToken: deviceToken ?? this.deviceToken,
        profileImage: profileImage ?? this.profileImage);
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'customer_name': name,
      'mobile': mobile,
      'password': password,
      'device_type': deviceType,
      'device_token': deviceToken,
      'profile_image': profileImage,
    };
  }

  factory SignUpRequest.fromMap(Map<String, dynamic>? map) {
    return SignUpRequest(
        name: map?['name'],
        mobile: map?['mobile'],
        email: map?['email'],
        password: map?['password'],
        deviceToken: map?['device_token'],
        deviceType: map?['device_type'],
        profileImage: map?['profile_image']);
  }

  String toJson() => json.encode(toMap());

  factory SignUpRequest.fromJson(String source) =>
      SignUpRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'SignUpRequest(name: $name, mobile: $mobile, email: $email, password: $password, device_type: $deviceType, device_token: $deviceToken, profileImage: $profileImage)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SignUpRequest &&
        o.name == name &&
        o.mobile == mobile &&
        o.email == email &&
        o.password == password &&
        o.deviceType == deviceType &&
        o.deviceToken == deviceToken &&
        o.profileImage == profileImage;
  }

  @override
  int get hashCode =>
      email.hashCode ^
      name.hashCode ^
      mobile.hashCode ^
      password.hashCode ^
      deviceType.hashCode ^
      deviceToken.hashCode ^
      profileImage.hashCode;
}

// new

class SignUpResponseModel {
  late String status;
  late String message;
  late UserDetails? userDetails;

  SignUpResponseModel(
      {required this.status, required this.message, required this.userDetails});

  SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userDetails = json['user_details'] != null
        ? UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
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

  UserDetails(
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

  UserDetails.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

class SignUpRequestModel {
  late String email,
      password,
      customerName,
      profileImage,
      mobile,
      deviceType,
      deviceToken;

  SignUpRequestModel(
      {required this.customerName,
      required this.email,
      required this.profileImage,
      required this.mobile,
      required this.password,
      required this.deviceType,
      required this.deviceToken});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'customer_name': customerName,
      'profile_image': profileImage,
      'mobile': mobile,
      'device_type': deviceType,
      "device_token": deviceToken
    };
  }
}
