import 'package:bigbaang/Models/product_detail_model.dart';

class SubCategoryModel {
  late String status;
  late String message;
  String? subcategoryBaseurl;
  List<SubcategoryList>? subcategoryList;

  SubCategoryModel(
      {required this.status,
      required this.message,
      required this.subcategoryBaseurl,
      required this.subcategoryList});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['subcategory_list'] != null) {
      subcategoryList = [];
      subcategoryBaseurl = json['subcategory_baseurl'];

      json['subcategory_list'].forEach((v) {
        subcategoryList!.add(SubcategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    if (subcategoryList != null) {
      data['subcategory_baseurl'] = subcategoryBaseurl;

      data['subcategory_list'] =
          subcategoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubcategoryList {
  late String id;
  late String categoryId;
  late String subcategoryImage;
  late String subcategoryName;
  late String status;
  String? createdAt;

  SubcategoryList(
      {required this.id,
      required this.categoryId,
      required this.subcategoryImage,
      required this.subcategoryName,
      required this.status,
      this.createdAt});

  SubcategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subcategoryImage = json['subcategory_image'];
    subcategoryName = json['subcategory_name'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['subcategory_image'] = subcategoryImage;
    data['subcategory_name'] = subcategoryName;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}

//Sub Category Products
class SubCategoryProductsModel {
  late String status;
  late String message;
  late String? productImageUrl;
  List<ProductDetails>? subcategoryProductDetails;

  SubCategoryProductsModel(
      {required this.status,
      required this.message,
      required this.productImageUrl,
      required this.subcategoryProductDetails});

  SubCategoryProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['product_image_url'] != null) {
      productImageUrl = json['product_image_url'];
    }
    if (json['subcategory_product_details'] != null) {
      subcategoryProductDetails = [];
      json['subcategory_product_details'].forEach((v) {
        subcategoryProductDetails!.add(ProductDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    data['product_image_url'] = productImageUrl;
    if (subcategoryProductDetails != null) {
      data['subcategory_product_details'] =
          subcategoryProductDetails!.map((v) => v.toJson()).toList();
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
