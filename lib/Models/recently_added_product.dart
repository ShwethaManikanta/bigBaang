import 'package:bigbaang/Models/product_detail_model.dart';

class RecentlyAddedProductModel {
  late String status;
  late String message;
  late String productImageUrl;
  List<ProductDetails>? productDetails;

  RecentlyAddedProductModel(
      {required this.status,
      required this.message,
      required this.productImageUrl,
      required this.productDetails});

  RecentlyAddedProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    productImageUrl = json['product_image_url'];
    if (json['product_details'] != null) {
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
    data['product_image_url'] = productImageUrl;
    if (productDetails != null) {
      data['product_details'] = productDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
