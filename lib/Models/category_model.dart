class CategoryListData {
  late String status;
  late String message;
  late String categoryBaseurl;
  late List<CategoryList>? categoryList;

  CategoryListData(
      {required this.status,
      required this.message,
      required this.categoryBaseurl,
      required this.categoryList});

  CategoryListData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    categoryBaseurl = json['category_baseurl'];
    if (json['category_list'] != null) {
      categoryList = [];
      json['category_list'].forEach((v) {
        categoryList!.add(CategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    data['category_baseurl'] = categoryBaseurl;
    if (categoryList != null) {
      data['category_list'] = categoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryList {
  late String id;
  late String categoryName;
  late String categoryImg;
  late String status;
  String? createdAt;

  CategoryList(
      {required this.id,
      required this.categoryName,
      required this.categoryImg,
      required this.status,
      this.createdAt});

  CategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    categoryImg = json['category_img'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['category_img'] = categoryImg;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}
