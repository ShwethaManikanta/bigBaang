class ProductsInCart {
  final String productName, urlImage, unit;
  final int totalQuantity, actualAmount, amountAfterDiscount, cartQuantity;
  // final
  final String imageAsset;

  ProductsInCart(this.imageAsset,
      {required this.productName,
      required this.urlImage,
      required this.unit,
      required this.totalQuantity,
      required this.actualAmount,
      required this.amountAfterDiscount,
      required this.cartQuantity});
}

class CartListResponseModel {
  late String status;
  late String message;
  String? productImageUrl;
  String? countProduct;
  String? total;
  List<CartDetails>? cartDetails;

  CartListResponseModel(
      {required this.status,
      required this.message,
      required this.countProduct,
      required this.total,
      required this.productImageUrl,
      required this.cartDetails});

  CartListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['cart_details'] != null) {
      countProduct = json['count_product'];
      total = json['total'] ?? "0";
      productImageUrl = json['product_image_url'];
      cartDetails = [];
      json['cart_details'].forEach((v) {
        cartDetails!.add(CartDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;

    if (cartDetails != null) {
      data['count_product'] = countProduct;
      data['total'] = total;
      data['cart_details'] = cartDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartDetails {
  late String id;
  late String productId;
  late String productName;
  late String retailerId;
  late String productImage;
  late String quantity;
  late String quantityLimit;
  late String qtyPrice;
  late String product_total;
  late String indexValue;

  CartDetails(
      {required this.id,
      required this.productId,
      required this.productName,
      required this.retailerId,
      required this.productImage,
      required this.quantity,
      required this.quantityLimit,
      required this.qtyPrice,
      required this.product_total,
      required this.indexValue});

  CartDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    retailerId = json['retailer_id'];
    productImage = json['product_image'];
    quantity = json['quantity'];
    quantityLimit = json['quantity_limit'];
    qtyPrice = json['qty_price'];
    product_total = json['product_total'];
    indexValue = json['index_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['retailer_id'] = retailerId;
    data['product_image'] = productImage;
    data['quantity'] = quantity;
    data['quantity_limit'] = quantityLimit;
    data['qty_price'] = qtyPrice;
    data['product_total'] = product_total;
    data['index_value'] = indexValue;
    return data;
  }
}
