import 'package:bigbaang/FrontEnd/CommonWidgets/cached_network_image.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_buttons.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/Models/add_to_cart_model.dart';
import 'package:bigbaang/Models/product_detail_model.dart';
import 'package:bigbaang/Models/top_offers_model.dart';
import 'package:bigbaang/service/addtocart_api_provider.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:bigbaang/service/top_offers_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../widgets/offer_tag.dart';
import '../Pages/ProductDetailsPage/product_details_page.dart';
import '../Pages/ProductDetailsPage/product_details_product_model.dart';
import '../Pages/ProductDetailsPage/styles/product_details_style.dart';
import '../Pages/ProductListPage/product_list_page.dart';

class HorizontalListTopOffers extends StatefulWidget {
  const HorizontalListTopOffers({Key? key}) : super(key: key);

  @override
  State<HorizontalListTopOffers> createState() =>
      _HorizontalListTopOffersState();
}

class _HorizontalListTopOffersState extends State<HorizontalListTopOffers> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() async {
    if (context.read<TopOffersApiProvider>().topOffersModel == null) {
      await context.read<TopOffersApiProvider>().getTopOffersModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    final topOffersApiProvider = Provider.of<TopOffersApiProvider>(context);
    if (topOffersApiProvider.isLoading) {
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
    } else if (topOffersApiProvider.topOffersModel!.status == "0") {
      return Center(
        child: Text(
          topOffersApiProvider.topOffersModel!.message,
          strutStyle: CommonStyles.blackText14BoldW500(),
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
          itemCount:
              topOffersApiProvider.topOffersModel!.productDetails!.length > 6
                  ? 7
                  : topOffersApiProvider.topOffersModel!.productDetails!.length,
          itemBuilder: (context, index) {
            if (index == 6) {
              return viewMoreCard();
            }
            return CategoryWidget(
                productDetails:
                    topOffersApiProvider.topOffersModel!.productDetails![index],
                baseImageUrl:
                    topOffersApiProvider.topOffersModel!.productImageUrl!);
          }),
    );
  }

  viewMoreCard() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductListPage(
                productDetails: context
                    .read<TopOffersApiProvider>()
                    .topOffersModel!
                    .productDetails!,
                imageBaseUrl: context
                    .read<TopOffersApiProvider>()
                    .topOffersModel!
                    .productImageUrl!,
                headerName: "Top Offers")));
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
              //   alignment: Alignment.centerRight,
              //   child: ClipPath(
              //     clipper: CustomShapeClipperHorizontalCropping(),
              //     child: Container(
              //       height: 370,
              //       width: 120,
              //       decoration: const BoxDecoration(color: Colors.black54),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [],
              //       ),
              //     ),
              //   ),
              // ),
              Card(
                shadowColor: Colors.lightBlueAccent,
                elevation: 20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                margin: EdgeInsets.symmetric(horizontal: 18, vertical: 100),
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
                        "Top Offers",
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

class CategoryWidget extends StatefulWidget {
  final ProductDetails productDetails;
  final String baseImageUrl;
  const CategoryWidget(
      {Key? key, required this.productDetails, required this.baseImageUrl})
      : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  void initState() {
    super.initState();
  }

  bool _loadingAPC = false;

  @override
  Widget build(BuildContext context) {
    final addToCartApiProvider = Provider.of<AddToCartAPIProvider>(context);
    final cartListResponseModel =
        Provider.of<CartListAPIProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => ProductDetailsWithModelProductPage(
        //           productDetails:
        //               widget.topOffersModel.productDetails![widget.index],
        //           baseImageUrl: widget.topOffersModel.productImageUrl!,
        //         )));
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
                  productDetails: widget.productDetails,
                  fromTopOffers: true,
                )));
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.lightBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          //  color: Colors.deepPurpleAccent,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: 370,
          width: 200,
          /*  decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(16),
          ),*/
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 20,
                shadowColor: Colors.white,
                child: Container(
                  height: 140,
                  width: 200,
                  /* decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.lightBlueAccent,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),*/
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OfferTag(
                        offerPercentage: widget.productDetails.discount[
                            widget.productDetails.selectedQuantityIndex],
                      ),
                      Utils.getSizedBox(height: 5),
                      Center(
                        child: cachedNetworkImage(
                            90,
                            100,
                            widget.baseImageUrl +
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
                                      color: Colors.lightBlue,
                                      fontWeight: FontWeight.bold,
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
                                // _dropDownValue = val.toString();
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
                                    TextSpan(
                                        text:
                                            'Rs ${widget.productDetails.salePrice[widget.productDetails.selectedQuantityIndex]} ',
                                        style: ProductDetailsStyle
                                            .smallTextSize13()),
                                    TextSpan(
                                        text: 'MRP : ',
                                        style: ProductDetailsStyle
                                            .smallTextSize12gray()),
                                    TextSpan(
                                      text:
                                          ' Rs ${widget.productDetails.mrp[widget.productDetails.selectedQuantityIndex]}',
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
                            child: Text(
                                '${widget.productDetails.discount[widget.productDetails.selectedQuantityIndex]}% OFF',
                                style:
                                    ProductDetailsStyle.textFieldStyleWhite8()),
                          ),
                        ),
                        Utils.getSizedBox(height: 5),

                        // PriceTag(
                        //   mrp: productDetails!
                        //       .mrp[productDetails!.selectedQuantityIndex],
                        //   salePrice: "MRP " +
                        //       productDetails!.salePrice[
                        //           productDetails!.selectedQuantityIndex],
                        // ),
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
                                          print("User NAME ---------------" +
                                              ApiService.userID!);
                                          setState(() {
                                            _loadingAPC = true;
                                          });
                                          if (int.parse(widget.productDetails
                                                  .cartStatus!.quantity) >
                                              1) {
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
                                          cartListResponseModel.getCartList;
                                          await context
                                              .read<TopOffersApiProvider>()
                                              .getTopOffersModel;

                                          setState(() {
                                            _loadingAPC = false;
                                          });
                                        },
                                        iconData: FontAwesomeIcons.minus),

                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: SizedBox(
                                        child: _loadingAPC
                                            ? const Center(
                                                child: SizedBox(
                                                  width: 15,
                                                  height: 15,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 1,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              )
                                            : Text(
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
                                            _loadingAPC = true;
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
                                          cartListResponseModel.getCartList;
                                          await context
                                              .read<TopOffersApiProvider>()
                                              .getTopOffersModel;

                                          setState(() {
                                            _loadingAPC = false;
                                          });
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
                                ),
                              )
                            : Align(
                                alignment: Alignment.bottomCenter,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        _loadingAPC = true;
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
                                      cartListResponseModel.getCartList;
                                      await context
                                          .read<TopOffersApiProvider>()
                                          .getTopOffersModel;

                                      setState(() {
                                        _loadingAPC = false;
                                      });
                                    },
                                    child: SizedBox(
                                      width: 80,
                                      child: _loadingAPC
                                          ? const Center(
                                              child: SizedBox(
                                                height: 15,
                                                width: 15,
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
    // return SizedBox(
    //   height: 100,
    //   width: 100,
    //   child: Column(
    //     children: [
    //       cachedNetworkImage(60, 60, imageUrl),
    //       const SizedBox(
    //         height: 5,
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
    //         child: Text(
    //           labelText,
    //           style: HomePageStyles.normalText(),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
