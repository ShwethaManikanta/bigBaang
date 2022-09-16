import 'dart:convert';

class SaveProductRequestModel {
  late String userId, productId, status;
  SaveProductRequestModel(
      {required this.productId, required this.status, required this.userId});

  Map<String, dynamic> toJson() {
    return {'user_id': userId, 'product_id': productId, 'status': status};
  }
}

class SaveProductResponseModel {
  late String status, message;

  SaveProductResponseModel({required this.status, required this.message});

  SaveProductResponseModel.fromJson(Map<String, dynamic> jsonResponse) {
    status = jsonResponse['status'];
    message = jsonResponse['message'];
  }
}

class SuccessCommonResponseModel {
  late String status, message;

  SuccessCommonResponseModel({required this.status, required this.message});

  SuccessCommonResponseModel.fromJson(Map<String, dynamic> jsonResponse) {
    status = jsonResponse['status'];
    message = jsonResponse['message'];
  }
}
