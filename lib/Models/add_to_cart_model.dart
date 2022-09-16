class AddToCartResponseModel {
  late String status;
  late String message;

  AddToCartResponseModel({required this.message, required this.status});

  AddToCartResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

class AddToCartRequestModel {
  late String userId,
      productId,
      quantity,
      status,
      qtyLimit,
      qtyPrice,
      indexValue;

  AddToCartRequestModel(
      {required this.userId,
      required this.productId,
      required this.quantity,
      required this.status,
      required this.qtyLimit,
      required this.qtyPrice,
      required this.indexValue});

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'product_id': productId,
      'quantity': quantity,
      'status': status,
      'qty_limit': qtyLimit,
      'qty_price': qtyPrice,
      'index_value': indexValue
    };
  }

  @override
  String toString() {
    return "userid :  $userId, product id : $productId , quantity : $quantity, status: $status";
  }
}
