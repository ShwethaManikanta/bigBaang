import 'dart:convert';
import 'package:bigbaang/Models/banner_model.dart';
import 'package:bigbaang/Models/category_model.dart';
import 'package:bigbaang/Models/checkout_model.dart';
import 'package:bigbaang/Models/image_upload_response_model.dart';
import 'package:bigbaang/Models/login_model.dart';
import 'package:bigbaang/Models/place_order_model.dart';
import 'package:bigbaang/Models/product_detail_model.dart';
import 'package:bigbaang/Models/save_product_models.dart';
import 'package:bigbaang/Models/search_product_model.dart';
import 'package:bigbaang/Models/signup_model.dart';
import 'package:bigbaang/Models/sub_category_model.dart';
import 'package:bigbaang/Models/user_model.dart';
import 'package:http/http.dart';

ApiService apiServices = ApiService();

class ApiService {
  static String? userID;
  static String? userName;
  static CategoryListData? categoriesList;
  static SubCategoryModel? subCategoryModel;
  static BannerModel? bannerModelList;
  static ProductDetailModel? productModelDetails;

  final String baseURL = "https://bigbaang.in/bigbaang_admin/";

  Future<CustomerLoginJson> signIn(SignInRequest signInRequest) async {
    Uri loginApiUrl = Uri.parse('${baseURL}index.php/Api_customer/signin');
    print("RUNNING ------");
    Response response = await post(loginApiUrl, body: signInRequest.toMap());
    print("The Status code" + response.statusCode.toString());
    print(response.body.toString());
    print(response.statusCode.toString());
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse.toString());
    CustomerLoginJson customerLoginJson =
        CustomerLoginJson.fromJson(jsonResponse);
    if (customerLoginJson.customerDetails!.id == null) {
      userID = customerLoginJson.customerDetails!.id;
      print("User Id is" + userID.toString());
    }

    return customerLoginJson;
  }

  Future<String> signUp(SignUpRequest signUpRequest) async {
    Uri loginApiUrl = Uri.parse('${baseURL}index.php/Api_customer/signup');
    Response response = await post(loginApiUrl, body: signUpRequest.toMap());
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse['message'];
  }

  Future<void> getCategoryList() async {
    Uri categoryAPIurl =
        Uri.parse("${baseURL}index.php/Api_customer/listcategory");
    Response response = await get(categoryAPIurl);
    //  print(response.statusCode);
    var jsonResponse = jsonDecode(response.body);
    // print(jsonResponse.toString());
    CategoryListData categoryList = CategoryListData.fromJson(jsonResponse);
    // print(categoryList.toString());
    categoriesList = categoryList;
    //  print(categoriesList.categoryList.toString());
    // print("category model   " + categoryList.toString());
  }

  Future<void> getBannerImg() async {
    Uri bannerApiUrl = Uri.parse("${baseURL}index.php/Api_customer/bannerList");
    Response response = await get(bannerApiUrl);
    // print(response.statusCode);
    var jsonResponse = jsonDecode(response.body);
    // print(jsonResponse.toString());
    BannerModel bannerModel = BannerModel.fromJson(jsonResponse);
    // print(bannerModel.toString());
    bannerModelList = bannerModel;
  }

  Future<void> getProductDetails(String productId) async {
    Uri productDetails =
        Uri.parse("${baseURL}index.php/Api_customer/product_details");
    Response response =
        await post(productDetails, body: {"product_id": productId});
    print("productDtails " + response.statusCode.toString());
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse.toString());

    ProductDetailModel productDetailModel =
        ProductDetailModel.fromJson(jsonResponse);
    print(productDetailModel.toString());
    productModelDetails = productDetailModel;
  }

  Future<CategoryListData?> getRetailerCategory(String retailerId) async {
    print("Retailer0------ ID----" + retailerId);
    Uri category = Uri.parse("${baseURL}index.php/Api_customer/listcategory");
    Response response = await post(category, body: {"retailer_id": retailerId});
    print(response.statusCode);

    print("Retailer ID ---------------" + retailerId);
    print("---------------------------------------");
    print("Categroy " + response.statusCode.toString());
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse.toString());

    CategoryListData categoryListData = CategoryListData.fromJson(jsonResponse);
    return categoryListData;
  }

  Future<SubCategoryModel?> getSubCategory(String categoryId,
       String retailerId
      ) async {
    print("SUBCATEGORY ID----" + categoryId);
    Uri subCategory =
        Uri.parse("${baseURL}index.php/Api_customer/list_subcategory");
    Response response =
        await post(subCategory, body: {"category_id": categoryId,
          "retailer_id" : retailerId
        });

    print(response.statusCode);
    print("---------------------------------------");
    print("subCategroy " + response.statusCode.toString());
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse.toString());

    SubCategoryModel subCategoryProduct =
        SubCategoryModel.fromJson(jsonResponse);
    return subCategoryProduct;
  }

  Future<ImageResponse?> uploadImages(
      ImageUploadModel uploadImageService) async {
    ImageResponse? imageResponse;
    Uri uploadImageUrl = Uri.parse('${baseURL}index.php/Api_vendor/doUpload');
    var request = MultipartRequest("POST", uploadImageUrl);
    request.fields['file_type'] = uploadImageService.fileType;
    request.files.add(await MultipartFile.fromPath(
        "file_name", uploadImageService.fileName.path));

    final streamResponse = await request.send();
    final response = await Response.fromStream(streamResponse);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print("Json Response after uploading file " + jsonResponse.toString());
      imageResponse = ImageResponse.fromJson(jsonResponse);
    }

    return imageResponse;
  }

  Future<SaveProductResponseModel?> saveProduct(
      {required SaveProductRequestModel saveProductRequestModel}) async {
    SaveProductResponseModel? saveProductResponseModel;
    Uri url = Uri.parse('${baseURL}index.php/Api_customer/add_save_later');

    print(saveProductRequestModel.productId +
        "----" +
        saveProductRequestModel.status +
        "----" +
        saveProductRequestModel.userId);

    var request = await post(url, body: saveProductRequestModel.toJson());
    if (request.statusCode == 200) {
      final jsonResponse = jsonDecode(request.body);
      saveProductResponseModel =
          SaveProductResponseModel.fromJson(jsonResponse);
    }
    return saveProductResponseModel;
  }

  Future<SubCategoryProductsModel?> getSubCategoryBasedProducts(
      String subCategoryId,
      {String filterMode = "0"}) async {
    SubCategoryProductsModel? _subCategoryModel;
    Uri url =
        Uri.parse('${baseURL}index.php/Api_customer/subcategory_based_product');
    var response = await post(url, body: {
      "subcategory_id": subCategoryId,
      "filter": filterMode,
      "user_id": userID
    });
    print("Subcategory Products Api Call --- SubCategory Id" + subCategoryId);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print("Json response for subcategory based Products" +
          jsonResponse.toString());
      _subCategoryModel = SubCategoryProductsModel.fromJson(jsonResponse);
    }

    return _subCategoryModel;
  }

  Future<SuccessCommonResponseModel?> addRecentlySearchedProducts(
      {required String productId, required String productName}) async {
    SuccessCommonResponseModel? successCommonResponseModel;
    Uri url = Uri.parse("${baseURL}index.php/Api_customer/add_search_product");
    var response = await post(url,
        body: {"product_id": productId, "product_name": productName});
    print("Add to search calling in product id: " + productId);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print("Json response for add search products" + jsonResponse.toString());
      successCommonResponseModel =
          SuccessCommonResponseModel.fromJson(jsonResponse);
    }
    return successCommonResponseModel;
  }

  Future<CheckOutModel?> getCheckOutList(String userId) async {
    print("user ID----" + userId);
    Uri url = Uri.parse("${baseURL}index.php/Api_customer/checkout_list");
    Response response = await post(url, body: {"user_id": userId});
    print(response.statusCode);
    print("---------------------------------------");
    print("Response code " + response.statusCode.toString());
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse.toString());

    CheckOutModel checkOutModel = CheckOutModel.fromJson(jsonResponse);
    return checkOutModel;
  }

  Future<SearchProductModel?> getSearchResults(String searchKey) async {
    Uri searchUrl =
        Uri.parse("${baseURL}index.php/Api_customer/search_product");
    SearchProductModel? _searchProductModel;
    print("USR ID =--------------------=  ${userID}");
    var response = await post(searchUrl,
        body: {"search_key": searchKey, "user_id": userID});

    print("Http post Response from search product ------  " + response.body);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print(
          "json response for search Products ------" + jsonResponse.toString());
      _searchProductModel = SearchProductModel.fromJson(jsonResponse);
    }

    return _searchProductModel;
  }

  Future<String> addEditAddress({
    required String userId,
    required String type,
    required String address,
    required String land_mark,
    required String lat,
    required String long,
  }) async {
    print("user ID----" + userId);
    Uri url = Uri.parse("${baseURL}index.php/Api_customer/edit_search_address");
    Response response = await post(url, body: {
      "user_id": userId,
      "type": type,
      "address": address,
      "land_mark": land_mark,
      "lat": lat,
      "long": long,
    });
    print(response.statusCode);
    print("---------------------------------------");
    print("Response code " + response.statusCode.toString());
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse.toString());
    return jsonResponse['status'];
  }

  Future<PlaceOrderModel?> getOrders(
    String retailerId,
    String itemTotal,
    String taxes,
    String deliveryFee,
    String address,
    String lat,
    String long,
    String toPay,
    String transactionID,
  ) async {
    Uri url = Uri.parse("${baseURL}index.php/Api_customer/buyproduct");
    Response response = await post(url, body: {
      "user_id": userID,
      "retailer_id": retailerId,
      "item_total": itemTotal,
      "taxes": taxes,
      "delivery_fee": deliveryFee,
      "address": address,
      "lat": lat,
      "long": long,
      "to_pay": toPay,
      "transaction_id": transactionID
    });
    print("Response From Order Placed ---------- ${response.statusCode}");
    print("Response From Order Placed ---------- ${response.body}");
    print("---------------------------------------");
    print("Response code " + response.statusCode.toString());
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse.toString());
    PlaceOrderModel placeOrderModel = PlaceOrderModel.fromJson(jsonResponse);
    return placeOrderModel;
  }

  Future<PlaceOrderModel?> deleteOrder(String order_id) async {
    Uri searchUrl = Uri.parse("${baseURL}index.php/Api_customer/cancel_order");
    PlaceOrderModel? _cancelOrder;
    var response = await post(searchUrl, body: {"order_id": order_id});
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print(
          "json response for search Products ------" + jsonResponse.toString());
      _cancelOrder = PlaceOrderModel.fromJson(jsonResponse);
    }

    return _cancelOrder;
  }
}
