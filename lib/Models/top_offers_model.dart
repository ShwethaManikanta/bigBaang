import 'package:bigbaang/Models/product_detail_model.dart';

class TopOffersModel {
  late String status;
  late String message;
  String? productImageUrl;
  List<ProductDetails>? productDetails;

  TopOffersModel(
      {required this.status,
      required this.message,
      required this.productImageUrl,
      required this.productDetails});

  TopOffersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['product_details'] != null) {
      productImageUrl = json['product_image_url'];
      productDetails = [];
      json['product_details'].forEach((v) {
        productDetails!.add(ProductDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    if (productDetails != null) {
      data['product_image_url'] = productImageUrl;
      data['product_details'] = productDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
