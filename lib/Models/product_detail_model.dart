class ProductDetailModel {
  late String status;
  late String messege;
  late String productUrl;
  late ProductDetails? productDetails;

  ProductDetailModel(
      {required this.status,
      required this.messege,
      required this.productUrl,
      required this.productDetails});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messege = json['messege'];
    productUrl = json['product_url'];
    productDetails = (json['product_details'] != null
        ? ProductDetails.fromJson(json['product_details'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['messege'] = messege;
    data['product_url'] = productUrl;
    if (productDetails != null) {
      data['product_details'] = productDetails!.toJson();
    }
    return data;
  }
}

class ProductDetails {
  late String id;
  late String categoryId;
  late String categoryName;
  late String subcategoryId;
  late String subcategoryName;
  late String retailerId;
  late String retailerName;
  late String productName;
  late String productImage;
  late List<String> salePrice;
  late List<String> mrp;
  late List<String> qty;
  late String serviceTax;
  late List<String> discount;
  late String productStock;
  late String description;
  late String onlineStatus;
  CartStatus? cartStatus;
  String? saveStatus;

  int selectedQuantityIndex = 0;
  int _addedCartcount = 0;
  bool _isAdded = false;
  bool saveProductForLater = false;

  ProductDetails(
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
      required this.cartStatus,
      required this.serviceTax,
      required this.discount,
      required this.productStock,
      required this.description,
      required this.onlineStatus,
      required this.saveStatus});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    subcategoryId = json['subcategory_id'];
    subcategoryName = json['subcategory_name'];
    retailerId = json['retailer_id'];
    retailerName = json['retailer_name'];
    productName = json['product_name'];
    productImage = json['product_image'];
    salePrice = json['sale_price'].cast<String>();
    mrp = json['mrp'].cast<String>();
    qty = json['qty'].cast<String>();
    serviceTax = json['service_tax'];
    discount = json['discount'].cast<String>();
    cartStatus = json['cart_status'] == null || json['cart_status'] == "0"
        ? null
        : CartStatus.fromJson(json['cart_status']);
    productStock = json['product_stock'];
    description = json['description'];
    onlineStatus = json['online_status'];
    saveStatus = json['save_status'] ?? "0";
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

  set addedCartCount(int count) {
    _addedCartcount = count;
  }

  set isAddedToCart(bool value) {
    _isAdded = value;
  }

  bool getIsAddedToCart() {
    return _isAdded;
  }

  int getAddedCartCount() {
    return _addedCartcount;
  }

  incrementAddedCount() {
    _addedCartcount++;
  }

  decrementAddedCount() {
    _addedCartcount--;
  }
}

class CartStatus {
  late String id;
  late String productId;
  late String userId;
  late String quantity;
  late String qtyLimit;
  late String qtyPrice;
  late String indexValue;
  late String status;
  String? createdAt;

  CartStatus(
      {required this.id,
      required this.productId,
      required this.userId,
      required this.quantity,
      required this.qtyLimit,
      required this.qtyPrice,
      required this.indexValue,
      required this.status,
      this.createdAt});

  CartStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    quantity = json['quantity'];
    qtyLimit = json['qty_limit'];
    qtyPrice = json['qty_price'];
    indexValue = json['index_value'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['product_id'] = productId;
    data['user_id'] = userId;
    data['quantity'] = quantity;
    data['qty_limit'] = qtyLimit;
    data['qty_price'] = qtyPrice;
    data['index_value'] = indexValue;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}
