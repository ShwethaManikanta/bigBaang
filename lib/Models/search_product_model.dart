import 'package:bigbaang/Models/product_detail_model.dart';

class SearchProductModel {
  late String status;
  late String message;
  late String? productImageUrl;
  late List<ProductDetails>? productDetails;

  SearchProductModel(
      {required this.status,
      required this.message,
      required this.productImageUrl,
      required this.productDetails});

  SearchProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['subcategory_product_details'] != null) {
      productImageUrl = json['product_image_url'];
      productDetails = [];
      json['subcategory_product_details'].forEach((v) {
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
      data['subcategory_product_details'] =
          productDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubcategoryProductDetails {
  late String id;
  late String categoryId;
  late String categoryName;
  late String subcategoryId;
  late String subcategoryName;
  late String retailerId;
  late String retailerName;
  late String productName;
  late String productImage;
  late String salePrice;
  late String mrp;
  late String qty;
  late String serviceTax;
  late String discount;
  late String productStock;
  late String description;
  late String onlineStatus;

  SubcategoryProductDetails(
      {required this.id,
      required this.categoryId,
      required this.categoryName,
      required this.subcategoryId,
      required this.subcategoryName,
      required this.retailerId,
      required this.retailerName,
      required this.productName,
      required this.productImage,
      required this.salePrice,
      required this.mrp,
      required this.qty,
      required this.serviceTax,
      required this.discount,
      required this.productStock,
      required this.description,
      required this.onlineStatus});

  SubcategoryProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    subcategoryId = json['subcategory_id'];
    subcategoryName = json['subcategory_name'];
    retailerId = json['retailer_id'];
    retailerName = json['retailer_name'];
    productName = json['product_name'];
    productImage = json['product_image'];
    salePrice = json['sale_price'];
    mrp = json['mrp'];
    qty = json['qty'];
    serviceTax = json['service_tax'];
    discount = json['discount'];
    productStock = json['product_stock'];
    description = json['description'];
    onlineStatus = json['online_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['subcategory_id'] = subcategoryId;
    data['subcategory_name'] = subcategoryName;
    data['retailer_id'] = retailerId;
    data['retailer_name'] = retailerName;
    data['product_name'] = productName;
    data['product_image'] = productImage;
    data['sale_price'] = salePrice;
    data['mrp'] = mrp;
    data['qty'] = qty;
    data['service_tax'] = serviceTax;
    data['discount'] = discount;
    data['product_stock'] = productStock;
    data['description'] = description;
    data['online_status'] = onlineStatus;
    return data;
  }
}
