class OrderHistoryModel {
  String? status;
  String? message;
  String? retailerProfileurl;
  List<OrderHistory>? orderHistory;

  OrderHistoryModel(
      {this.status, this.message, this.retailerProfileurl, this.orderHistory});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    retailerProfileurl = json['retailer_profileurl'];
    if (json['order_history'] != null) {
      orderHistory = <OrderHistory>[];
      json['order_history'].forEach((v) {
        orderHistory!.add(new OrderHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['retailer_profileurl'] = this.retailerProfileurl;
    if (this.orderHistory != null) {
      data['order_history'] =
          this.orderHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderHistory {
  String? id;
  List<ProductDetails>? productDetails;
  CustomerName? customerName;
  HotelDetails? hotelDetails;
  String? address;
  String? itemTotal;
  String? total;
  String? deliveryFee;
  String? lat;
  String? long;
  String? outletId;
  String? taxes;
  String? deliveryDate;
  String? status;

  OrderHistory(
      {this.id,
      this.productDetails,
      this.customerName,
      this.hotelDetails,
      this.address,
      this.itemTotal,
      this.total,
      this.deliveryFee,
      this.lat,
      this.long,
      this.outletId,
      this.taxes,
      this.deliveryDate,
      this.status});

  OrderHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['product_details'] != null) {
      productDetails = <ProductDetails>[];
      json['product_details'].forEach((v) {
        productDetails!.add(new ProductDetails.fromJson(v));
      });
    }
    customerName = json['customer_name'] != null
        ? new CustomerName.fromJson(json['customer_name'])
        : null;
    hotelDetails = json['hotel_details'] != null
        ? new HotelDetails.fromJson(json['hotel_details'])
        : null;
    address = json['address'];
    itemTotal = json['item_total'];
    total = json['total'];
    deliveryFee = json['delivery_fee'];
    lat = json['lat'];
    long = json['long'];
    outletId = json['outlet_id'];
    taxes = json['taxes'];
    deliveryDate = json['delivery_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.productDetails != null) {
      data['product_details'] =
          this.productDetails!.map((v) => v.toJson()).toList();
    }
    if (this.customerName != null) {
      data['customer_name'] = this.customerName!.toJson();
    }
    if (this.hotelDetails != null) {
      data['hotel_details'] = this.hotelDetails!.toJson();
    }
    data['address'] = this.address;
    data['item_total'] = this.itemTotal;
    data['total'] = this.total;
    data['delivery_fee'] = this.deliveryFee;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['outlet_id'] = this.outletId;
    data['taxes'] = this.taxes;
    data['delivery_date'] = this.deliveryDate;
    data['status'] = this.status;
    return data;
  }
}

class ProductDetails {
  String? id;
  String? productName;
  String? qty;
  int? price;

  ProductDetails({this.id, this.productName, this.qty, this.price});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    qty = json['qty'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['qty'] = this.qty;
    data['price'] = this.price;
    return data;
  }
}

class CustomerName {
  String? id;
  String? username;
  String? mobileNo;
  String? email;
  String? password;
  String? decryptPassword;
  String? profileImage;
  String? dob;
  String? address;
  String? latitude;
  String? longitude;
  String? landMark;
  String? floor;
  String? reach;
  String? addressTypeId;
  String? selectedAddress;
  String? notification;
  String? status;
  String? isEmailVerified;
  String? isMobileVerified;
  String? deviceType;
  String? deviceToken;
  String? deviceModel;
  String? deviceVersion;
  String? createdAt;
  String? updatedAt;

  CustomerName(
      {this.id,
      this.username,
      this.mobileNo,
      this.email,
      this.password,
      this.decryptPassword,
      this.profileImage,
      this.dob,
      this.address,
      this.latitude,
      this.longitude,
      this.landMark,
      this.floor,
      this.reach,
      this.addressTypeId,
      this.selectedAddress,
      this.notification,
      this.status,
      this.isEmailVerified,
      this.isMobileVerified,
      this.deviceType,
      this.deviceToken,
      this.deviceModel,
      this.deviceVersion,
      this.createdAt,
      this.updatedAt});

  CustomerName.fromJson(Map<String, dynamic> json) {
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

class HotelDetails {
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

  HotelDetails(
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

  HotelDetails.fromJson(Map<String, dynamic> json) {
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
