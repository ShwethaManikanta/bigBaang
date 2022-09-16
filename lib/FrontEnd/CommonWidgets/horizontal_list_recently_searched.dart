import 'package:bigbaang/FrontEnd/CommonWidgets/cached_network_image.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_buttons.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/Models/add_to_cart_model.dart';
import 'package:bigbaang/Models/product_detail_model.dart';
import 'package:bigbaang/service/addtocart_api_provider.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:bigbaang/service/recently_searched_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../widgets/offer_tag.dart';
import '../Pages/ProductDetailsPage/product_details_page.dart';
import '../Pages/ProductDetailsPage/styles/product_details_style.dart';
import '../Pages/ProductListPage/product_list_page.dart';

class HorizontalListRecentlySearched extends StatefulWidget {
  const HorizontalListRecentlySearched({Key? key}) : super(key: key);

  @override
  State<HorizontalListRecentlySearched> createState() =>
      _HorizontalListTopOffersState();
}

class _HorizontalListTopOffersState
    extends State<HorizontalListRecentlySearched> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() async {
    if (context.read<RecentlySearchedAPIProvider>().recentlySearchedModel ==
        null) {
      await context
          .read<RecentlySearchedAPIProvider>()
          .recentlySearchedProducts;
    }
  }

  @override
  Widget build(BuildContext context) {
    final recentlySearchedAPIProvider =
        Provider.of<RecentlySearchedAPIProvider>(context);

    if (recentlySearchedAPIProvider.isLoading) {
      return SizedBox(
        height: 100,
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
      );
    } else if (recentlySearchedAPIProvider.recentlySearchedModel == null) {
      return Center(
        child: Text(
          "Oops! Something went Wrong!!",
          style: CommonStyles.blackText14BoldW500(),
        ),
      );
    } else if (recentlySearchedAPIProvider.recentlySearchedModel!.status ==
        "0") {
      return Center(
        child: Text(
          recentlySearchedAPIProvider.recentlySearchedModel!.message,
          style: CommonStyles.blackText14BoldW500(),
        ),
      );
    }
    return SizedBox(
      height: 400,
      child: ListView.builder(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          addAutomaticKeepAlives: true,
          shrinkWrap: true,
          itemCount: recentlySearchedAPIProvider
                      .recentlySearchedModel!.productDetails!.length >
                  6
              ? 7
              : recentlySearchedAPIProvider
                  .recentlySearchedModel!.productDetails!.length,
          itemBuilder: (context, index) {
            if (index == 6) {
              return viewMoreCard();
            }
            return CategoryWidgetProductDetails(
                key: Key(recentlySearchedAPIProvider
                    .recentlySearchedModel!.productDetails![index].id),
                productDetails: recentlySearchedAPIProvider
                    .recentlySearchedModel!.productDetails![index],
                baseUrl: recentlySearchedAPIProvider
                    .recentlySearchedModel!.productImageUrl!,
                index: index);
          }),
    );
  }

  viewMoreCard() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductListPage(
                productDetails: context
                    .read<RecentlySearchedAPIProvider>()
                    .recentlySearchedModel!
                    .productDetails!,
                imageBaseUrl: context
                    .read<RecentlySearchedAPIProvider>()
                    .recentlySearchedModel!
                    .productImageUrl!,
                headerName: "Popular Products")));
      },
      child: Card(
        shadowColor: Colors.lightBlueAccent,
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: 370,
          width: 200,
          /* decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.circular(16),
          ),*/
          child: Stack(
            children: [
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Container(
              //     height: 200,
              //     width: 200,
              //     decoration: const BoxDecoration(color: Colors.black54),
              //   ),
              // ),
              Card(
                elevation: 20,
                margin: EdgeInsets.symmetric(horizontal: 18, vertical: 100),
                shadowColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "View All",
                        style: CommonStyles.textw400BlueS14(),
                      ),
                      Text(
                        "Popular Products",
                        style: CommonStyles.textw400BlueS14(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryWidgetProductDetails extends StatefulWidget {
  final ProductDetails productDetails;
  final String baseUrl;
  final int index;
  const CategoryWidgetProductDetails(
      {Key? key,
      required this.productDetails,
      required this.index,
      required this.baseUrl})
      : super(key: key);

  @override
  State<CategoryWidgetProductDetails> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidgetProductDetails> {
  @override
  void initState() {
    super.initState();
  }

  bool _updatingValue = false;

  // checkAddedToCartList() async {
  //   if (context.read<CartListAPIProvider>().cartListResponseModel != null) {
  //     final cartDetailsList = context
  //         .read<CartListAPIProvider>()
  //         .cartListResponseModel!
  //         .cartDetails;
  //     if (cartDetailsList == null) {
  //       widget.productDetails.isAddedToCart = false;
  //     } else {
  //       for (var element in cartDetailsList) {
  //         if (element.productId == widget.productDetails.id) {
  //           widget.productDetails.selectedQuantityIndex =
  //               int.parse(element.indexValue);
  //           widget.productDetails.isAddedToCart = true;
  //           widget.productDetails.addedCartCount = int.parse(element.quantity);
  //         } else {
  //           widget.productDetails.isAddedToCart = false;
  //         }
  //       }
  //     }
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final addToCartApiProvider = Provider.of<AddToCartAPIProvider>(context);
    final cartListApiProvider =
        Provider.of<CartListAPIProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
                  productDetails: widget.productDetails,
                  fromRecentlySearched: true,
                )));
      },
      child: Card(
        shadowColor: Colors.lightBlue,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: 370,
          width: 200,
          /* decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.circular(16),
          ),*/
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                // shadowColor: Colors.lightBlue,
                elevation: 20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Container(
                  height: 140,
                  width: 200,
                  /* decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),*/
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.productDetails.cartStatus == null
                          ? OfferTag(
                              offerPercentage:
                                  widget.productDetails.discount.first,
                            )
                          : OfferTag(
                              offerPercentage: widget.productDetails.discount[
                                  int.parse(widget
                                      .productDetails.cartStatus!.indexValue)],
                            ),
                      Utils.getSizedBox(height: 5),
                      Center(
                        child: cachedNetworkImage(
                            95,
                            100,
                            widget.baseUrl +
                                widget.productDetails.productImage),
                      ),
                      Utils.getSizedBox(height: 5),
                    ],
                  ),
                ),
              ),
              Utils.getSizedBox(height: 10),
              Expanded(
                child: Container(
                    width: 200,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  widget.productDetails.categoryName,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            SizedBox(
                              height: 40,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  widget.productDetails.productName,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightBlue,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                        DropdownButton(
                          hint: Text(
                            widget.productDetails.qty[
                                widget.productDetails.selectedQuantityIndex],
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          ),
                          isExpanded: true,
                          iconSize: 30.0,
                          underline: Container(),
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w500),
                          items: widget.productDetails.qty.map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                widget.productDetails.selectedQuantityIndex =
                                    widget.productDetails.qty
                                        .indexOf(val.toString());
                              },
                            );
                          },
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    widget.productDetails.cartStatus == null
                                        ? TextSpan(
                                            text:
                                                'Rs ${widget.productDetails.salePrice[widget.productDetails.selectedQuantityIndex]} ',
                                            style: ProductDetailsStyle
                                                .smallTextSize13())
                                        : TextSpan(
                                            text:
                                                'Rs ${widget.productDetails.salePrice[int.parse(widget.productDetails.cartStatus!.indexValue)]} ',
                                            style: ProductDetailsStyle
                                                .smallTextSize13()),
                                    TextSpan(
                                        text: 'MRP : ',
                                        style: ProductDetailsStyle
                                            .smallTextSize12gray()),
                                    widget.productDetails.cartStatus == null
                                        ? TextSpan(
                                            text:
                                                'Rs ${widget.productDetails.salePrice[widget.productDetails.selectedQuantityIndex]} ',
                                            style: ProductDetailsStyle
                                                .smallTextSize12grayLineThrough())
                                        : TextSpan(
                                            text:
                                                ' Rs ${widget.productDetails.mrp[int.parse(widget.productDetails.cartStatus!.indexValue)]}',
                                            style: ProductDetailsStyle
                                                .smallTextSize12grayLineThrough(),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Utils.getSizedBox(height: 3),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(2)),
                          width: 50,
                          child: Center(
                            child: widget.productDetails.cartStatus == null
                                ? Text(
                                    '${widget.productDetails.discount.first}% OFF',
                                    style: ProductDetailsStyle
                                        .textFieldStyleWhite8())
                                : Text(
                                    '${widget.productDetails.discount[int.parse(widget.productDetails.cartStatus!.indexValue)]}% OFF',
                                    style: ProductDetailsStyle
                                        .textFieldStyleWhite8()),
                          ),
                        ),
                        Utils.getSizedBox(height: 5),
                        widget.productDetails.cartStatus != null
                            ? Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    materialButtonCommonWithAdditionSubtracition(
                                        fun: () async {
                                          setState(() {
                                            _updatingValue = true;
                                          });
                                          if (int.parse(widget.productDetails
                                                  .cartStatus!.quantity) >
                                              1) {

                                            if(addToCartApiProvider.addToCartResponse!.status == "0"){
                                               setState(() {

                                                 showAlertDialog(context);
                                               });

                                            }

                                            await addToCartApiProvider.addToCart(
                                                AddToCartRequestModel(
                                                userId: ApiService.userID!,
                                                productId:
                                                    widget.productDetails.id,
                                                qtyPrice: widget.productDetails
                                                        .salePrice[
                                                    widget.productDetails
                                                        .selectedQuantityIndex],
                                                qtyLimit: widget.productDetails.qty[
                                                    widget.productDetails
                                                        .selectedQuantityIndex],
                                                indexValue: widget
                                                    .productDetails
                                                    .selectedQuantityIndex
                                                    .toString(),
                                                quantity: "-1",
                                                status: "1"));
                                          } else {
                                            await addToCartApiProvider.addToCart(AddToCartRequestModel(
                                                userId: ApiService.userID!,
                                                productId:
                                                    widget.productDetails.id,
                                                qtyPrice: widget.productDetails
                                                        .salePrice[
                                                    widget.productDetails
                                                        .selectedQuantityIndex],
                                                qtyLimit: widget.productDetails.qty[
                                                    widget.productDetails
                                                        .selectedQuantityIndex],
                                                indexValue: widget
                                                    .productDetails
                                                    .selectedQuantityIndex
                                                    .toString(),
                                                quantity: "-1",
                                                status: "0"));
                                          }
                                          await context
                                              .read<
                                                  RecentlySearchedAPIProvider>()
                                              .recentlySearchedProducts;
                                          cartListApiProvider.getCartList;
                                          setState(() {
                                            _updatingValue = false;
                                          });
                                        },
                                        iconData: FontAwesomeIcons.minus),
                                    _updatingValue
                                        ? const Center(
                                            child: SizedBox(
                                              height: 18,
                                              width: 18,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 1,
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: SizedBox(
                                              width: 10,
                                              child: Text(
                                                widget.productDetails
                                                    .cartStatus!.quantity
                                                    .toString(),
                                                style: CommonStyles
                                                    .blackText10BoldW500(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                    materialButtonCommonWithAdditionSubtracition(
                                        fun: () async {
                                          setState(() {
                                            _updatingValue = true;
                                          });
                                          await addToCartApiProvider.addToCart(
                                              AddToCartRequestModel(
                                                  userId: ApiService.userID!,
                                                  productId:
                                                      widget.productDetails.id,
                                                  qtyPrice: widget
                                                          .productDetails
                                                          .salePrice[
                                                      widget.productDetails
                                                          .selectedQuantityIndex],
                                                  indexValue: widget
                                                      .productDetails
                                                      .selectedQuantityIndex
                                                      .toString(),
                                                  qtyLimit: widget.productDetails.qty[widget
                                                      .productDetails
                                                      .selectedQuantityIndex],
                                                  quantity: "+1",
                                                  status: "1"));
                                          cartListApiProvider.getCartList;
                                          await context
                                              .read<
                                                  RecentlySearchedAPIProvider>()
                                              .recentlySearchedProducts;
                                          setState(() {
                                            _updatingValue = false;
                                          });
                                        },
                                        iconData: FontAwesomeIcons.plus),
                                  ],
                                ),
                              )
                            : Align(
                                alignment: Alignment.bottomCenter,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        _updatingValue = true;
                                      });
                                      await addToCartApiProvider.addToCart(
                                          AddToCartRequestModel(
                                              userId: ApiService.userID!,
                                              productId:
                                                  widget.productDetails.id,
                                              qtyPrice:
                                                  widget.productDetails.salePrice[
                                                      widget.productDetails
                                                          .selectedQuantityIndex],
                                              indexValue: widget.productDetails
                                                  .selectedQuantityIndex
                                                  .toString(),
                                              qtyLimit: widget
                                                      .productDetails.qty[
                                                  widget.productDetails
                                                      .selectedQuantityIndex],
                                              quantity: "+1",
                                              status: "1"));
                                      cartListApiProvider.getCartList;
                                      await context
                                          .read<RecentlySearchedAPIProvider>()
                                          .recentlySearchedProducts;
                                      setState(() {
                                        _updatingValue = false;
                                      });
                                    },
                                    child: SizedBox(
                                      width: 80,
                                      child: _updatingValue
                                          ? const Center(
                                              child: SizedBox(
                                                height: 18,
                                                width: 18,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 1,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : const Text(
                                              "ADD",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                              textAlign: TextAlign.center,
                                            ),
                                    )),
                              )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }


  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {},
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed:  () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
