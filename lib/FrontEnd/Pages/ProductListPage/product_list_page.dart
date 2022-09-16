import 'package:bigbaang/FrontEnd/CommonWidgets/cached_network_image.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/LoginPage/styles/phone_verification_styles.dart';
import 'package:bigbaang/FrontEnd/Pages/ProductDetailsPage/product_details_page.dart';
import 'package:bigbaang/Models/product_detail_model.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:bigbaang/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../Models/add_to_cart_model.dart';
import '../../../service/addtocart_api_provider.dart';
import '../../CommonWidgets/common_buttons.dart';
import '../ProductDetailsPage/styles/product_details_style.dart';

class ProductListPage extends StatefulWidget {
  final String headerName;
  final String imageBaseUrl;
  final List<ProductDetails> productDetails;
  const ProductListPage(
      {required this.productDetails,
      required this.imageBaseUrl,
      required this.headerName,
      Key? key})
      : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addToCartAPIProvider = Provider.of<AddToCartAPIProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: FlexibleSpaceBar(
          background: AppBarProductPage(
            appBartext: widget.headerName,
            scaffoldKey: scaffoldKey,
            onlySearch: true,
            showFilter: true,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          color: Colors.white,
          child: ListView.builder(
              itemCount: widget.productDetails.length,
              scrollDirection: Axis.vertical,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 170,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 3,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProductDetailsPage(
                                            productDetails:
                                                widget.productDetails[index],
                                          )));
                                },
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    //   height: 180,

                                    /* decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black12),
                                        borderRadius: BorderRadius.circular(16)),*/
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0),
                                            height: 30,
                                            width: 175,
                                            decoration: const BoxDecoration(
                                                color: Colors.lightGreen,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight: Radius.circular(16),
                                                )),
                                            child: Center(
                                              child: Text(
                                                "${widget.productDetails[index].discount[widget.productDetails[index].selectedQuantityIndex]} % OFF",
                                                style: CommonStyles
                                                    .textDataWhite12Bold(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        //  Utils.getSizedBox(height: 10),
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(16),
                                            bottomRight: Radius.circular(16),
                                          ),
                                          child: cachedNetworkImage(
                                              132,
                                              175,
                                              widget.imageBaseUrl +
                                                  widget.productDetails[index]
                                                      .productImage),
                                        )
                                      ],
                                    ),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //  Utils.getSizedBox(height: 5),
                                    FittedBox(
                                      child: Text(
                                        widget.productDetails[index].productName
                                            .toUpperCase(),
                                        style: CommonStyles.blueBold14(),
                                      ),
                                    ),
                                    Utils.getSizedBox(height: 10),
                                    Container(
                                      margin: EdgeInsets.only(right: 20),
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        bottom: 2,
                                        top: 2,
                                      ),
                                      height: 25,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: dropDown(
                                          widget.productDetails[index]),
                                    ),
                                    Utils.getSizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 6.0, left: 6.0),
                                      child: Row(
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                    text:
                                                        'Rs ${widget.productDetails[index].salePrice[widget.productDetails[index].selectedQuantityIndex]}   ',
                                                    style: ProductDetailsStyle
                                                        .smallTextSize13()),
                                                TextSpan(
                                                    text: 'MRP : ',
                                                    style: ProductDetailsStyle
                                                        .smallTextSize12gray()),
                                                TextSpan(
                                                  text:
                                                      ' Rs ${widget.productDetails[index].mrp[widget.productDetails[index].selectedQuantityIndex]}',
                                                  style: ProductDetailsStyle
                                                      .smallTextSize12grayLineThrough(),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //  Utils.getSizedBox(width: 25),
                                        ],
                                      ),
                                    ),
                                    Utils.getSizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      width: 50,
                                      child: Center(
                                        child: Text(
                                            '${widget.productDetails[index].discount[widget.productDetails[index].selectedQuantityIndex]}% OFF',
                                            style: ProductDetailsStyle
                                                .textFieldStyleWhite8()),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Utils.getSizedBox(height: 10),
                      widget.productDetails[index].getIsAddedToCart()
                          ? incrementDecrementAddedProduct(
                              widget.productDetails[index])
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
                                  widget.productDetails[index].isAddedToCart =
                                      true;
                                  widget.productDetails[index]
                                      .incrementAddedCount();
                                });
                                await addToCartAPIProvider.addToCart(
                                    AddToCartRequestModel(
                                        userId: ApiService.userID!,
                                        productId:
                                            widget.productDetails[index].id,
                                        qtyLimit:
                                            widget.productDetails[index].qty[
                                                widget.productDetails[index]
                                                    .selectedQuantityIndex],
                                        qtyPrice: widget.productDetails[index]
                                                .salePrice[
                                            widget.productDetails[index]
                                                .selectedQuantityIndex],
                                        indexValue: widget.productDetails[index]
                                            .selectedQuantityIndex
                                            .toString(),
                                        quantity: "+1",
                                        status: "1"));
                              },
                              child: Text(
                                "Add",
                                style: PhoneVerificationStyles
                                    .sendOTPButtonTextStyle(),
                              ),
                              color: const Color(0xff6677d1),
                              splashColor: Colors.green,
                            )
                      // Utils.getSizedBox(height: 10),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget incrementDecrementAddedProduct(ProductDetails productDetails) {
    final addToCartApiProvider = Provider.of<AddToCartAPIProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        materialButtonCommonWithAdditionSubtracition(
            fun: () async {
              if (productDetails.getAddedCartCount() > 1) {
                productDetails.decrementAddedCount();
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
                productDetails.decrementAddedCount();
                await addToCartApiProvider.addToCart(AddToCartRequestModel(
                    userId: ApiService.userID!,
                    productId: productDetails.id,
                    qtyLimit: productDetails
                        .qty[productDetails.selectedQuantityIndex],
                    indexValue: productDetails.selectedQuantityIndex.toString(),
                    qtyPrice: productDetails
                        .salePrice[productDetails.selectedQuantityIndex],
                    quantity: "0",
                    status: "0"));
              }
              setState(() {});
            },
            iconData: FontAwesomeIcons.minus),

        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: 10,
            child: Text(
              productDetails.getAddedCartCount().toString(),
              style: CommonStyles.blackText14BoldW500(),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        materialButtonCommonWithAdditionSubtracition(
            fun: () async {
              setState(() {
                productDetails.incrementAddedCount();
              });
              await addToCartApiProvider.addToCart(AddToCartRequestModel(
                  userId: ApiService.userID!,
                  productId: productDetails.id,
                  qtyLimit:
                      productDetails.qty[productDetails.selectedQuantityIndex],
                  qtyPrice: productDetails
                      .salePrice[productDetails.selectedQuantityIndex],
                  quantity: "+1",
                  indexValue: productDetails.selectedQuantityIndex.toString(),
                  status: "1"));
            },
            iconData: FontAwesomeIcons.plus),

        // Text(
        //   "ADD",
        //   style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 18),
        //   textAlign: TextAlign.center,
        // ),
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
            // enabled: productDetails.qty.length > 1,
            value: val,
            // onTap: () {
            //   setState(
            //     () {
            //       productDetails.selectedQuantityIndex =
            //           productDetails.qty.indexOf(val.toString());
            //     },
            //   );
            // },
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
