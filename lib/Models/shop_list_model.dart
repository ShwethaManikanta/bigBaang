class ShopListModel {
  String? status;
  String? message;
  String? vendorBaseurl;
  List<RetailerList>? retailerList;

  ShopListModel(
      {this.status, this.message, this.vendorBaseurl, this.retailerList});

  ShopListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    vendorBaseurl = json['vendor_baseurl'];
    if (json['retailer_list'] != null) {
      retailerList = <RetailerList>[];
      json['retailer_list'].forEach((v) {
        retailerList!.add(new RetailerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['vendor_baseurl'] = this.vendorBaseurl;
    if (this.retailerList != null) {
      data['retailer_list'] =
          this.retailerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RetailerList {
  String? id;
  String? retailerName;
  String? email;
  String? mobileNo;
  String? password;
  String? decryptPassword;
  String? pwdOtp;
  String? retailerImage;
  String? aadharImage;
  String? licenseImage;
  String? gstNumber;
  String? address;
  String? latitude;
  String? longitude;
  String? rating;
  String? foodType;
  String? shopTime;
  String? orderOnline;
  String? curbsidePickup;
  String? storeFront;
  String? deliveryOption;
  String? status;
  String? onlineStatus;
  String? deviceType;
  String? deviceToken;
  String? loggedin;
  String? createdAt;

  RetailerList(
      {this.id,
      this.retailerName,
      this.email,
      this.mobileNo,
      this.password,
      this.decryptPassword,
      this.pwdOtp,
      this.retailerImage,
      this.aadharImage,
      this.licenseImage,
      this.gstNumber,
      this.address,
      this.latitude,
      this.longitude,
      this.rating,
      this.foodType,
      this.shopTime,
      this.orderOnline,
      this.curbsidePickup,
      this.storeFront,
      this.deliveryOption,
      this.status,
      this.onlineStatus,
      this.deviceType,
      this.deviceToken,
      this.loggedin,
      this.createdAt});

  RetailerList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    retailerName = json['retailer_name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    password = json['password'];
    decryptPassword = json['decrypt_password'];
    pwdOtp = json['pwd_otp'];
    retailerImage = json['retailer_image'];
    aadharImage = json['aadhar_image'];
    licenseImage = json['license_image'];
    gstNumber = json['gst_number'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    rating = json['rating'];
    foodType = json['food_type'];
    shopTime = json['shop_time'];
    orderOnline = json['order_online'];
    curbsidePickup = json['curbside_pickup'];
    storeFront = json['store_front'];
    deliveryOption = json['delivery_option'];
    status = json['status'];
    onlineStatus = json['online_status'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    loggedin = json['loggedin'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['retailer_name'] = this.retailerName;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['password'] = this.password;
    data['decrypt_password'] = this.decryptPassword;
    data['pwd_otp'] = this.pwdOtp;
    data['retailer_image'] = this.retailerImage;
    data['aadhar_image'] = this.aadharImage;
    data['license_image'] = this.licenseImage;
    data['gst_number'] = this.gstNumber;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['rating'] = this.rating;
    data['food_type'] = this.foodType;
    data['shop_time'] = this.shopTime;
    data['order_online'] = this.orderOnline;
    data['curbside_pickup'] = this.curbsidePickup;
    data['store_front'] = this.storeFront;
    data['delivery_option'] = this.deliveryOption;
    data['status'] = this.status;
    data['online_status'] = this.onlineStatus;
    data['device_type'] = this.deviceType;
    data['device_token'] = this.deviceToken;
    data['loggedin'] = this.loggedin;
    data['created_at'] = this.createdAt;
    return data;
  }
}
