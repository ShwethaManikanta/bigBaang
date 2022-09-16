class CheckOutModel {
  String? status;
  String? message;
  String? productImageUrl;
  String? retailerImageUrl;
  GetAllAddressCustomer? getAllAddressCustomer;
  RetailerDetails? retailerDetails;
  UserDetails? userDetails;
  String? countProduct;
  String? mrpTotal;
  String? tax;
  String? discountBag;
  String? deliveryFee;
  String? orderTotal;
  List<CheckoutDetails>? checkoutDetails;

  CheckOutModel(
      {this.status,
      this.message,
      this.productImageUrl,
      this.retailerImageUrl,
      this.getAllAddressCustomer,
      this.retailerDetails,
      this.userDetails,
      this.countProduct,
      this.mrpTotal,
      this.tax,
      this.discountBag,
      this.deliveryFee,
      this.orderTotal,
      this.checkoutDetails});

  CheckOutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    productImageUrl = json['product_image_url'];
    retailerImageUrl = json['retailer_image_url'];
    getAllAddressCustomer = json['get_all_address_customer'] != null &&
            json['get_all_address_customer'] != ""
        ? GetAllAddressCustomer.fromJson(json['get_all_address_customer'])
        : null;
    retailerDetails = json['retailerDetails'] != null
        ? new RetailerDetails.fromJson(json['retailerDetails'])
        : null;
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
    countProduct = json['count_product'];
    mrpTotal = json['mrp_total'];
    tax = json['tax'];
    discountBag = json['discount_bag'];
    deliveryFee = json['delivery_fee'];
    orderTotal = json['order_total'];
    if (json['checkout_details'] != null) {
      checkoutDetails = <CheckoutDetails>[];
      json['checkout_details'].forEach((v) {
        checkoutDetails!.add(new CheckoutDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['product_image_url'] = this.productImageUrl;
    data['retailer_image_url'] = this.retailerImageUrl;
    if (this.getAllAddressCustomer != null) {
      data['get_all_address_customer'] = this.getAllAddressCustomer!.toJson();
    }
    if (this.retailerDetails != null) {
      data['retailerDetails'] = this.retailerDetails!.toJson();
    }
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    data['count_product'] = this.countProduct;
    data['mrp_total'] = this.mrpTotal;
    data['tax'] = this.tax;
    data['discount_bag'] = this.discountBag;
    data['delivery_fee'] = this.deliveryFee;
    data['order_total'] = this.orderTotal;
    if (this.checkoutDetails != null) {
      data['checkout_details'] =
          this.checkoutDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAllAddressCustomer {
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

  GetAllAddressCustomer(
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

  GetAllAddressCustomer.fromJson(Map<String, dynamic> json) {
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

class RetailerDetails {
  String? id;
  String? retailerName;
  String? retailetImage;
  String? retaileAddress;
  String? lat;
  String? long;
  String? duration;
  String? distance;

  RetailerDetails(
      {this.id,
      this.retailerName,
      this.retailetImage,
      this.retaileAddress,
      this.lat,
      this.long,
      this.duration,
      this.distance});

  RetailerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    retailerName = json['retailer_name'];
    retailetImage = json['retailet_image'];
    retaileAddress = json['retaile_address'];
    lat = json['lat'];
    long = json['long'];
    duration = json['duration'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['retailer_name'] = this.retailerName;
    data['retailet_image'] = this.retailetImage;
    data['retaile_address'] = this.retaileAddress;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['duration'] = this.duration;
    data['distance'] = this.distance;
    return data;
  }
}

class UserDetails {
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

  UserDetails(
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

class CheckoutDetails {
  String? id;
  String? productId;
  String? productName;
  String? retailerId;
  String? productImage;
  String? quantity;
  String? quantityLimit;
  String? qtyPrice;
  String? indexValue;
  int? productTotal;

  CheckoutDetails(
      {this.id,
      this.productId,
      this.productName,
      this.retailerId,
      this.productImage,
      this.quantity,
      this.quantityLimit,
      this.qtyPrice,
      this.indexValue,
      this.productTotal});

  CheckoutDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    retailerId = json['retailer_id'];
    productImage = json['product_image'];
    quantity = json['quantity'];
    quantityLimit = json['quantity_limit'];
    qtyPrice = json['qty_price'];
    indexValue = json['index_value'];
    productTotal = json['product_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['retailer_id'] = this.retailerId;
    data['product_image'] = this.productImage;
    data['quantity'] = this.quantity;
    data['quantity_limit'] = this.quantityLimit;
    data['qty_price'] = this.qtyPrice;
    data['index_value'] = this.indexValue;
    data['product_total'] = this.productTotal;
    return data;
  }
}
