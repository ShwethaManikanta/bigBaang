class ProfileModel {
  String? status;
  String? message;
  String? userId;
  UserDetails? userDetails;
  List<GetAllAddress>? getAllAddress;
  String? profileBaseurl;

  ProfileModel(
      {this.status,
      this.message,
      this.userId,
      this.userDetails,
      this.getAllAddress,
      this.profileBaseurl});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userId = json['user_id'];
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
    if (json['get_all_address'] != null) {
      getAllAddress = <GetAllAddress>[];
      json['get_all_address'].forEach((v) {
        getAllAddress!.add(new GetAllAddress.fromJson(v));
      });
    }
    profileBaseurl = json['profile_baseurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    if (this.getAllAddress != null) {
      data['get_all_address'] =
          this.getAllAddress!.map((v) => v.toJson()).toList();
    }
    data['profile_baseurl'] = this.profileBaseurl;
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
  late String landMark;
  late String floor;
  late String reach;
  late String addressTypeId;
  late String selectedAddress;
  late String notification;
  late String status;
  late String isEmailVerified;
  late String isMobileVerified;
  late String deviceType;
  late String deviceToken;
  late String deviceModel;
  late String deviceVersion;
  String? createdAt;
  String? updatedAt;

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
      required this.landMark,
      required this.floor,
      required this.reach,
      required this.addressTypeId,
      required this.selectedAddress,
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
    landMark = json['land_mark'];
    floor = json['floor'];
    reach = json['reach'];
    addressTypeId = json['address_type_id'];
    selectedAddress = json['selected_address'];
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
    data['id'] = this.id;
    data['username'] = this.username;
    data['mobile_no'] = this.mobileNo;
    data['email'] = this.email;
    data['password'] = this.password;
    data['decrypt_password'] = this.decryptPassword;
    data['profile_image'] = this.profileImage;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['land_mark'] = this.landMark;
    data['floor'] = this.floor;
    data['reach'] = this.reach;
    data['address_type_id'] = this.addressTypeId;
    data['selected_address'] = this.selectedAddress;
    data['notification'] = this.notification;
    data['status'] = this.status;
    data['is_email_verified'] = this.isEmailVerified;
    data['is_mobile_verified'] = this.isMobileVerified;
    data['device_type'] = this.deviceType;
    data['device_token'] = this.deviceToken;
    data['device_model'] = this.deviceModel;
    data['device_version'] = this.deviceVersion;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class GetAllAddress {
  String? id;
  String? addressTypeId;
  String? userId;
  String? address;
  String? landmark;
  String? doorNo;
  String? street;
  String? state;
  String? pincode;
  String? lat;
  String? long;
  String? status;
  String? createdAt;

  GetAllAddress(
      {this.id,
      this.addressTypeId,
      this.userId,
      this.address,
      this.landmark,
      this.doorNo,
      this.street,
      this.state,
      this.pincode,
      this.lat,
      this.long,
      this.status,
      this.createdAt});

  GetAllAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressTypeId = json['address_type_id'];
    userId = json['user_id'];
    address = json['address'];
    landmark = json['landmark'];
    doorNo = json['door_no'];
    street = json['street'];
    state = json['state'];
    pincode = json['pincode'];
    lat = json['lat'];
    long = json['long'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address_type_id'] = this.addressTypeId;
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['landmark'] = this.landmark;
    data['door_no'] = this.doorNo;
    data['street'] = this.street;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ProfileUpdateRequestModel {
  late String userId, email, customerName, mobile, profileImage, deviceToken;

  ProfileUpdateRequestModel(
      {required this.userId,
      required this.email,
      required this.customerName,
      required this.profileImage,
      required this.mobile,
      required this.deviceToken});

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'email': email,
      'customer_name': customerName,
      'profile_image': profileImage,
      'mobile': mobile,
      'device_token': deviceToken
    };
  }
}

class ProfileUpdateResponseModel {
  late String status;
  late String message;
  late UserDetails? userDetails;

  ProfileUpdateResponseModel(
      {required this.status, required this.message, required this.userDetails});

  ProfileUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userDetails = json['user_details'] != null
        ? UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    if (userDetails != null) {
      data['user_details'] = userDetails!.toJson();
    }
    return data;
  }
}
