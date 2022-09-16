import 'package:bigbaang/FrontEnd/CommonWidgets/cached_network_image.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/LoginPage/styles/phone_verification_styles.dart';
import 'package:bigbaang/FrontEnd/Pages/ProductDetailsPage/product_details_page.dart';
import 'package:bigbaang/Models/sub_category_model.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:bigbaang/service/clear_cart_api_provider.dart';
import 'package:bigbaang/service/product_details.dart';
import 'package:bigbaang/service/subcategory_api_provider.dart';
import 'package:bigbaang/widgets/appbar.dart';
import 'package:bigbaang/widgets/scrollable_category_names.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../Models/add_to_cart_model.dart';
import '../../Models/product_detail_model.dart';
import '../../service/addtocart_api_provider.dart';
import '../CommonWidgets/common_buttons.dart';
import 'ProductDetailsPage/styles/product_details_style.dart';

class AllProductViewPage extends StatefulWidget {
  final String subCategoryId;
  final String subCategoryName;
  final String retailerID;
//  final String retailerID;
  final List<SubcategoryList> subCategoryList;
  const AllProductViewPage(
      {required this.subCategoryId,
      required this.subCategoryName,
      required this.subCategoryList,
      required this.retailerID,
     // required this.retailerID,
      Key? key})
      : super(key: key);

  @override
  _AllProductViewPageState createState() => _AllProductViewPageState();
}

class _AllProductViewPageState extends State<AllProductViewPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = true;
  // SubCategoryProductsModel? _subCategoryProductsModel;

  @override
  void initState() {
    getSubCategory();
    super.initState();
  }

  getSubCategory() async {
    context.read<SubCategoryBasedProductAPIPorvider>().initialize();
    context.read<SubCategoryBasedProductAPIPorvider>().getSubCategoryProducts(
          widget.subCategoryId,
      widget.retailerID
        );
  }

  @override
  Widget build(BuildContext context) {
    print(" All Product ----------------------");
    final subCategoryBasedProductAPIProvider =
        Provider.of<SubCategoryBasedProductAPIPorvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: FlexibleSpaceBar(
          background: AppBarProductPage(
            appBartext: widget.subCategoryName,
            scaffoldKey: scaffoldKey,
            onlySearch: true,
            showCart: true,
            showFilter: true,
          ),
        ),
      ),
      body: SizedBox(
        height: deviceHeight(context),
        child: Column(
          children: [
            ScrollableCategoryNames(
              subCategoryList: widget.subCategoryList,
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  subCategoryBasedProductAPIProvider.isLoading
                      ? SizedBox(
                          height: 300,
                          width: deviceWidth(context),
                          child: const Center(
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                            ),
                          ),
                        )
                      : subCategoryBasedProductAPIProvider.subCategoryModel !=
                                  null &&
                              subCategoryBasedProductAPIProvider
                                      .subCategoryModel!
                                      .subcategoryProductDetails ==
                                  null
                          ? SizedBox(
                              height: 300,
                              width: deviceWidth(context),
                              child: Center(
                                child: Text(
                                  subCategoryBasedProductAPIProvider
                                      .subCategoryModel!.message,
                                  style: CommonStyles.blackText10BoldW500(),
                                ),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          subCategoryBasedProductAPIProvider
                                              .subCategoryModel!
                                              .subcategoryProductDetails!
                                              .length,
                                      itemBuilder: (context, index) {
                                        return SubCategoryBasedProducts(
                                          productDetails:
                                              subCategoryBasedProductAPIProvider
                                                      .subCategoryModel!
                                                      .subcategoryProductDetails![
                                                  index],
                                          baseUrl:
                                              subCategoryBasedProductAPIProvider
                                                  .subCategoryModel!
                                                  .productImageUrl!,
                                          subCategoryId: widget.subCategoryId,
                                        );
                                      }),
                                ],
                              ),
                            )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubCategoryBasedProducts extends StatefulWidget {
  const SubCategoryBasedProducts(
      {Key? key,
      required this.productDetails,
      required this.baseUrl,
      required this.subCategoryId})
      : super(key: key);
  final ProductDetails productDetails;
  final String baseUrl, subCategoryId;
  @override
  _SubCategoryBasedProductsState createState() =>
      _SubCategoryBasedProductsState();
}

class _SubCategoryBasedProductsState extends State<SubCategoryBasedProducts> {
  bool _loadingATC = false;

  @override
  Widget build(BuildContext context) {
    final addToCartAPIProvider = Provider.of<AddToCartAPIProvider>(context);
    final cartListApiProvider =
        Provider.of<CartListAPIProvider>(context, listen: false);
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(
                              productDetails: widget.productDetails,
                              subCategoryId: widget.subCategoryId,
                            )));
                  },
                  child: Container(
                    height: 170,
                    decoration: BoxDecoration(
                        //  border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 30,
                            width: 100,
                            decoration: const BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                )),
                            child: Center(
                              child: widget.productDetails.cartStatus == null
                                  ? Text(
                                      "${widget.productDetails.discount.first} % OFF",
                                      style: CommonStyles.textDataWhite12Bold(),
                                    )
                                  : Text(
                                      "${widget.productDetails.discount[int.parse(widget.productDetails.cartStatus!.indexValue)]} % OFF",
                                      style: CommonStyles.textDataWhite12Bold(),
                                    ),
                            ),
                          ),
                        ),
                        Utils.getSizedBox(height: 10),
                        Card(
                          elevation: 20,
                          shadowColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: cachedNetworkImage(
                                115,
                                140,
                                widget.baseUrl +
                                    widget.productDetails.productImage),
                          ),
                        )
                        // cachedNetworkImage(
                        //   imageUrl: _subCategoryProductsModel!
                        //           .productImageUrl! +
                        //       _subCategoryProductsModel!
                        //           .subcategoryProductDetails![
                        //               index]
                        //           .productImage,
                        //   height: 130,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              Utils.getSizedBox(width: 20),
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Utils.getSizedBox(height: 5),
                      Text(
                        widget.productDetails.productName,
                        style: CommonStyles.blackText14BoldW500(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Utils.getSizedBox(height: 15),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        padding:
                            const EdgeInsets.only(left: 20, bottom: 2, top: 2),
                        height: 25,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(3)),
                        child: dropDown(widget.productDetails),
                      ),
                      Utils.getSizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0, left: 6.0),
                        child: Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  widget.productDetails.cartStatus == null
                                      ? TextSpan(
                                          text:
                                              "Rs ${widget.productDetails.salePrice[widget.productDetails.selectedQuantityIndex]} ",
                                          style: CommonStyles.blueBold12())
                                      : TextSpan(
                                          text:
                                              'Rs ${widget.productDetails.salePrice[int.parse(widget.productDetails.cartStatus!.indexValue)]} ',
                                          style: ProductDetailsStyle
                                              .smallTextSize13()),
                                  TextSpan(
                                      text: '  MRP : ',
                                      style: ProductDetailsStyle
                                          .smallTextSize12gray()),
                                  widget.productDetails.cartStatus == null
                                      ? TextSpan(
                                          text:
                                              "Rs ${widget.productDetails.mrp[widget.productDetails.selectedQuantityIndex]}",
                                          style: ProductDetailsStyle
                                              .smallTextSize12grayLineThrough(),
                                        )
                                      : TextSpan(
                                          text:
                                              ' Rs ${widget.productDetails.mrp[int.parse(widget.productDetails.cartStatus!.indexValue)]}',
                                          style: ProductDetailsStyle
                                              .smallTextSize12grayLineThrough(),
                                        ),
                                ],
                              ),
                            ),
                            Utils.getSizedBox(width: 20),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(2)),
                              width: 50,
                              child: Center(
                                child: widget.productDetails.cartStatus == null
                                    ? Text(
                                        "${widget.productDetails.discount[widget.productDetails.selectedQuantityIndex]}% OFF",
                                        style: ProductDetailsStyle
                                            .textFieldStyleWhite8(),
                                      )
                                    : Text(
                                        '${widget.productDetails.discount[int.parse(widget.productDetails.cartStatus!.indexValue)]}% OFF',
                                        style: ProductDetailsStyle
                                            .textFieldStyleWhite8()),
                              ),
                            )
                          ],
                        ),
                      ),
                      Utils.getSizedBox(height: 4),
                      widget.productDetails.cartStatus != null
                          ? incrementDecrementAddedProduct(
                              widget.productDetails)
                          : MaterialButton(
                              elevation: 5,
                              minWidth:
                                  MediaQuery.of(context).size.width * 0.35,
                              height: 35,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              onPressed: () async {
                                setState(() {
                                  _loadingATC = true;
                                });
                                final addToCartApiProvider = Provider.of<AddToCartAPIProvider>(context,listen: false);
                                final productDetailsAPIProvider =
                                Provider.of<ProductDetailsAPIProvider>(context,listen: false);

                                await addToCartAPIProvider.addToCart(
                                    AddToCartRequestModel(
                                        userId: ApiService.userID!,
                                        productId: widget.productDetails.id,
                                        qtyLimit: widget.productDetails.qty[
                                            widget.productDetails
                                                .selectedQuantityIndex],
                                        qtyPrice:
                                            widget.productDetails.salePrice[
                                                widget.productDetails
                                                    .selectedQuantityIndex],
                                        indexValue: widget.productDetails
                                            .selectedQuantityIndex
                                            .toString(),
                                        quantity: "+1",
                                        status: "1")).then((value) {
                                  print("addToCartResponse Product page---------" +
                                      addToCartApiProvider.addToCartResponse!.status
                                          .toString());

                                  if (addToCartApiProvider.addToCartResponse!.status ==
                                      "0") {
                                    showAlertDialog(context, addToCartApiProvider,
                                        widget.productDetails);
                                  }
                                });;
                                // await widget.function();
                                // await widget.fun;
                                await context
                                    .read<SubCategoryBasedProductAPIPorvider>()
                                    .getSubCategoryProducts(
                                      widget.subCategoryId,widget.productDetails.retailerId
                                    );
                                cartListApiProvider.getCartList;
                                setState(() {
                                  _loadingATC = false;
                                });
                              },
                              child: _loadingATC
                                  ? const SizedBox(
                                      height: 10,
                                      width: 10,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      "Add",
                                      style: PhoneVerificationStyles
                                          .sendOTPButtonTextStyle(),
                                    ),
                              color: const Color(0xff6677d1),
                              splashColor: Colors.green,
                            )
                    ],
                  ),
                ),
              )
            ],
          )

          // Utils.getSizedBox(height: 10),
        ],
      ),
    );
  }

  showAlertDialog(
      BuildContext context,
      AddToCartAPIProvider addToCartAPIProvider,
   productDetails) {
    final clearCartAPI =
    Provider.of<ClearCartAPIProvider>(context, listen: false);

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        setState(() {
          Navigator.of(context).pop();
        });
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () async {
        await clearCartAPI.getClearCart();
        await addToCartAPIProvider.addToCart(AddToCartRequestModel(
            userId: ApiService.userID!,
            productId: widget.productDetails.id,
            qtyPrice: widget.productDetails.salePrice[widget.productDetails.selectedQuantityIndex],
            qtyLimit: widget.productDetails.qty[
           widget.productDetails
                .selectedQuantityIndex],
            indexValue: widget.productDetails.selectedQuantityIndex.toString(),
            quantity: "+1",
            status: "1")
        ).then((value) {
          context.read<ProductDetailsAPIProvider>().getProductDetails(widget.productDetails.id);
        });
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Alert",
        style: CommonStyles.greenBold(),
      ),
      content: Text(addToCartAPIProvider.addToCartResponse!.message),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget incrementDecrementAddedProduct(ProductDetails productDetails) {
    final addToCartApiProvider = Provider.of<AddToCartAPIProvider>(context);
    final cartListApiProvider =
        Provider.of<CartListAPIProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        materialButtonCommonWithAdditionSubtracition(
            fun: () async {
              setState(() {
                _loadingATC = true;
              });
              if (int.parse(productDetails.cartStatus!.quantity) > 1) {
                // productDetails.decrementAddedCount();
                await addToCartApiProvider.addToCart(AddToCartRequestModel(
                    userId: ApiService.userID!,
                    productId: productDetails.id,
                    qtyLimit: productDetails
                        .qty[productDetails.selectedQuantityIndex],
                    qtyPrice: productDetails
                        .salePrice[productDetails.selectedQuantityIndex],
                    indexValue: productDetails.selectedQuantityIndex.toString(),
                    quantity: "-1",
                    status: "1"));
              } else {
                productDetails.isAddedToCart = false;
                // productDetails.decrementAddedCount();
                await addToCartApiProvider.addToCart(AddToCartRequestModel(
                    userId: ApiService.userID!,
                    productId: productDetails.id,
                    qtyLimit: productDetails
                        .qty[productDetails.selectedQuantityIndex],
                    qtyPrice: productDetails
                        .salePrice[productDetails.selectedQuantityIndex],
                    indexValue: productDetails.selectedQuantityIndex.toString(),
                    quantity: "0",
                    status: "0"));
              }
              await context
                  .read<SubCategoryBasedProductAPIPorvider>()
                  .getSubCategoryProducts(widget.subCategoryId,widget.productDetails.retailerId);
             await cartListApiProvider.getCartList;

              setState(() {
                _loadingATC = false;
              });
            },
            iconData: FontAwesomeIcons.minus),

        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            child: _loadingATC
                ? const SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color: Colors.blue,
                    ),
                  )
                : Text(
                    productDetails.cartStatus!.quantity.toString(),
                    style: CommonStyles.blackText12BoldW400(),
                    textAlign: TextAlign.center,
                  ),
          ),
        ),

        materialButtonCommonWithAdditionSubtracition(
            fun: () async {
              setState(() {
                _loadingATC = true;
                productDetails.incrementAddedCount();
              });
              await addToCartApiProvider.addToCart(AddToCartRequestModel(
                  userId: ApiService.userID!,
                  productId: productDetails.id,
                  qtyLimit:
                      productDetails.qty[productDetails.selectedQuantityIndex],
                  qtyPrice: productDetails
                      .salePrice[productDetails.selectedQuantityIndex],
                  indexValue: productDetails.selectedQuantityIndex.toString(),
                  quantity: "+1",
                  status: "1"));
              // widget.function;
              await context
                  .read<SubCategoryBasedProductAPIPorvider>()
                  .getSubCategoryProducts(widget.subCategoryId,widget.productDetails.retailerId);
              await cartListApiProvider.getCartList;
              setState(() {
                _loadingATC = false;
              });
            },
            iconData: FontAwesomeIcons.plus),

      ],
    );
  }
  // Column(
  //   children: List.generate(
  //       ApiService.subCategoryModel!.subcategoryProductDetails!
  //           .length,
  //       (index) {}),
  // ),
  // Utils.getSizedBox(height: 5),

  Widget dropDown(ProductDetails productDetails) {
    return DropdownButton(
      hint: Text(
        productDetails.qty[productDetails.selectedQuantityIndex],
        style: CommonStyles.textw300BlackS10(),
      ),
      iconSize: 20.0,
      underline: Container(),
      isExpanded: true,
      elevation: 0,
      icon: const Icon(
        Icons.arrow_drop_down_outlined,
        size: 25,
      ),
      style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
      items: productDetails.qty.map(
        (val) {
          return DropdownMenuItem<String>(
            enabled: productDetails.qty.length > 1,
            value: val,
            onTap: () {
              setState(
                () {
                  productDetails.selectedQuantityIndex =
                      productDetails.qty.indexOf(val.toString());
                },
              );
            },
            child: Text(
              val,
              style: CommonStyles.blackText14BoldW500(),
            ),
          );
        },
      ).toList(),
      onChanged: (val) {
        setState(
          () {
            productDetails.selectedQuantityIndex =
                productDetails.qty.indexOf(val.toString());
          },
        );
      },
    );
  }
}
