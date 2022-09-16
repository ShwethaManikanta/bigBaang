import 'package:bigbaang/FrontEnd/CommonWidgets/cached_network_image.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/ProductDetailsPage/styles/product_details_style.dart';
import 'package:bigbaang/FrontEnd/Pages/ProductDetailsPage/widgets/remaining_sliver_screen.dart';
import 'package:bigbaang/FrontEnd/Pages/ProductDetailsPage/widgets/sliver_bar.dart';
import 'package:bigbaang/Models/place_order_model.dart';
import 'package:bigbaang/Models/product_detail_model.dart';
import 'package:bigbaang/Models/save_product_models.dart';
import 'package:bigbaang/service/addtocart_api_provider.dart';
import 'package:bigbaang/service/clear_cart_api_provider.dart';
import 'package:bigbaang/service/product_details.dart';
import 'package:bigbaang/service/recently_searched_api_provider.dart';
import 'package:bigbaang/service/top_offers_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../Models/add_to_cart_model.dart';
import '../../../service/api_service.dart';
import '../../../service/subcategory_api_provider.dart';
import '../../CommonWidgets/common_buttons.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductDetails productDetails;
  final String? subCategoryId;
  final bool fromRecentlySearched, fromTopOffers;
  const ProductDetailsPage(
      {Key? key,
      required this.productDetails,
      this.subCategoryId,
      this.fromRecentlySearched = false,
      this.fromTopOffers = false})
      : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  PlaceOrderModel _placeOrderModel = PlaceOrderModel();

  bool _loadingSFL = false;
  bool _loadingATB = false;

  @override
  void initState() {
    super.initState();
    getProductDetails();
  }

  Future getProductDetails() async {
    context.read<ProductDetailsAPIProvider>().reinitialize();
    await context
        .read<ProductDetailsAPIProvider>()
        .getProductDetails(widget.productDetails.id);
  }

  // final addToCartResponse = AddToCartResponseModel(message: "", status: "");

  @override
  Widget build(BuildContext context) {
    print("---------------------------------");

    final productDetailsAPIProvider =
        Provider.of<ProductDetailsAPIProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const FlexibleSpaceBar(
          background: AppBarProductDetailsPage(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Builder(builder: (context) {
        return productDetailsAPIProvider.ifLoading
            ? const Center(
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              )
            : productDetailsAPIProvider.productDetailsModel != null &&
                    productDetailsAPIProvider.productDetailsModel!.status == "0"
                ? Center(
                    child: SizedBox(
                      child: Text(
                        productDetailsAPIProvider.productDetailsModel!.messege,
                        style: CommonStyles.blackText14BoldW500(),
                      ),
                    ),
                  )
                : CustomScrollView(
                    slivers: [
                      SliverPersistentHeader(
                          pinned: true,
                          delegate: MySliverAppBar(
                              maxExtentHeight: 140,
                              minExtentHeight: 140,
                              builder: (_, shrinkOffset, overlapseContent) =>
                                  parlourSliverProfileInformation())),
                      SliverPersistentHeader(
                          pinned: false,
                          delegate: MySliverAppBar(
                              maxExtentHeight: 150,
                              minExtentHeight: 150,
                              builder: (_, shrinkOffset, overlapseContent) =>
                                  parlourSliverProductImage())),
                      SliverPersistentHeader(
                          pinned: true,
                          floating: false,
                          delegate: MySliverAppBar(
                              maxExtentHeight: 50,
                              minExtentHeight: 50,
                              builder: (_, shrinkOffset, overlapseContent) =>
                                  saveAndAddToBasketButtonsWidget())),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) {
                        return productQuantityListWidgets(
                            index,
                            productDetailsAPIProvider.productDetailsModel!
                                .productDetails!.qty[index]);
                      },
                              childCount: productDetailsAPIProvider
                                  .productDetailsModel!
                                  .productDetails!
                                  .qty
                                  .length)),
                      SliverToBoxAdapter(
                        child: RemainingSliverScreen(
                            productModel: widget.productDetails),
                      ),
                    ],
                  );
      }),
    );
  }

  parlourSliverProductImage() {
    final productDetailsAPIProvider =
        Provider.of<ProductDetailsAPIProvider>(context);
    return SizedBox(
      height: 150,
      child: Align(
        alignment: Alignment.center,
        child: cachedNetworkImage(
            150,
            150,
            productDetailsAPIProvider.productDetailsModel!.productUrl +
                productDetailsAPIProvider
                    .productDetailsModel!.productDetails!.productImage),
      ),
    );
  }

  Widget saveAndAddToBasketButtonsWidget() {
    final productDetailsAPIProvider =
        Provider.of<ProductDetailsAPIProvider>(context);
    final addToCartApiProvider = Provider.of<AddToCartAPIProvider>(context);
    final cartListApiProvider =
        Provider.of<CartListAPIProvider>(context, listen: false);

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            width: deviceWidth(context) / 2,
            height: 50,
            color: Colors.brown[800],
            child: productDetailsAPIProvider
                        .productDetailsModel!.productDetails!.saveStatus ==
                    "1"
                ? GestureDetector(
                    onTap: () async {
                      _loadingSFL = true;
                      setState(() {
                        productDetailsAPIProvider.productDetailsModel!
                            .productDetails!.saveProductForLater = true;
                      });
                      final result = await apiServices.saveProduct(
                          saveProductRequestModel: SaveProductRequestModel(
                              productId: productDetailsAPIProvider
                                  .productDetailsModel!.productDetails!.id,
                              status: "0",
                              userId: ApiService.userID!));

                      if (result == null) {
                        Utils.getFloatingSnackBar(
                            context: context,
                            snackBarText: "Oops! Something Went Wrong!");
                      } else {
                        await context
                            .read<ProductDetailsAPIProvider>()
                            .getProductDetails(widget.productDetails.id);
                        Utils.getFloatingSnackBar(
                            context: context, snackBarText: result.message);
                      }
                      setState(() {
                        _loadingSFL = false;
                      });
                    },
                    child: _loadingSFL
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(
                                strokeWidth: 1,
                                color: Colors.white,
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                const Icon(
                                  Icons.bookmark_added,
                                  color: Colors.white,
                                ),
                                Utils.getSizedBox(width: 5),
                                Text(
                                  'SAVED',
                                  style:
                                      ProductDetailsStyle.whiteText13BoldW500(),
                                ),
                              ]),
                  )
                : GestureDetector(
                    onTap: () async {
                      setState(() {
                        _loadingSFL = true;
                      });
                      final result = await apiServices.saveProduct(
                          saveProductRequestModel: SaveProductRequestModel(
                              productId: productDetailsAPIProvider
                                  .productDetailsModel!.productDetails!.id,
                              status: "1",
                              userId: ApiService.userID!));

                      if (result == null) {
                        Utils.getFloatingSnackBar(
                            context: context,
                            snackBarText: "Oops! Something Went Wrong!");
                      } else {
                        await context
                            .read<ProductDetailsAPIProvider>()
                            .getProductDetails(widget.productDetails.id);
                        Utils.getFloatingSnackBar(
                            context: context, snackBarText: result.message);
                      }
                      setState(() {
                        _loadingSFL = false;
                      });
                    },
                    child: _loadingSFL
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(
                                strokeWidth: 1,
                                color: Colors.white,
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                const Icon(
                                  Icons.bookmark_add_outlined,
                                  color: Colors.white,
                                ),
                                Utils.getSizedBox(width: 5),
                                Text(
                                  'SAVE FOR LATER',
                                  style:
                                      ProductDetailsStyle.whiteText13BoldW500(),
                                )
                              ]),
                  ),
          ),
          Container(
            color: Colors.red,
            width: deviceWidth(context) / 2,
            height: 50,
            child: productDetailsAPIProvider
                        .productDetailsModel!.productDetails!.cartStatus !=
                    null
                ? incrementDecrementAddedProduct(productDetailsAPIProvider
                    .productDetailsModel!.productDetails!)
                : GestureDetector(
                    onTap: () async {
                      _loadingATB = true;
                      setState(() {
                        productDetailsAPIProvider.productDetailsModel!
                            .productDetails!.isAddedToCart = true;
                        productDetailsAPIProvider
                            .productDetailsModel!.productDetails!
                            .incrementAddedCount();
                      });

                      //  print("Response Message ----------" + addToCartApiProvider.addToCartResponse!.message);

                      await addToCartApiProvider
                          .addToCart(AddToCartRequestModel(
                              userId: ApiService.userID!,
                              productId: productDetailsAPIProvider.productDetailsModel!.productDetails!.id,
                              qtyPrice: productDetailsAPIProvider
                                      .productDetailsModel!
                                      .productDetails!
                                      .salePrice[
                                  productDetailsAPIProvider.productDetailsModel!
                                      .productDetails!.selectedQuantityIndex],
                              qtyLimit: productDetailsAPIProvider
                                      .productDetailsModel!.productDetails!.qty[
                                  productDetailsAPIProvider.productDetailsModel!
                                      .productDetails!.selectedQuantityIndex],
                              indexValue: productDetailsAPIProvider
                                  .productDetailsModel!
                                  .productDetails!
                                  .selectedQuantityIndex
                                  .toString(),
                              quantity: "+1",
                              status: "1"))
                          .then((value) {
                        print("addToCartResponse Product page---------" +
                            addToCartApiProvider.addToCartResponse!.status
                                .toString());

                        if (addToCartApiProvider.addToCartResponse!.status ==
                            "0") {
                          showAlertDialog(context, addToCartApiProvider,
                              productDetailsAPIProvider);
                        }
                      });
                      await context
                          .read<ProductDetailsAPIProvider>()
                          .getProductDetails(widget.productDetails.id);
                      if (widget.subCategoryId != null) {
                        context
                            .read<SubCategoryBasedProductAPIPorvider>()
                            .getSubCategoryProducts(widget.subCategoryId!,widget.productDetails.retailerId);
                      }
                      if (widget.fromRecentlySearched) {
                        context
                            .read<RecentlySearchedAPIProvider>()
                            .recentlySearchedProducts;
                      }
                      if (widget.fromTopOffers) {
                        context.read<TopOffersApiProvider>().getTopOffersModel;
                      }
                      cartListApiProvider.getCartList;
                      setState(() {
                        _loadingATB = false;
                      });
                    },
                    child: _loadingATB
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                    color: Colors.white,
                                  ))
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.shopping_bag_outlined,
                                  color: Colors.white),
                              Utils.getSizedBox(width: 5),
                              Text(
                                'ADD TO BASKET',
                                style:
                                    ProductDetailsStyle.whiteText13BoldW500(),
                              )
                            ],
                          ),
                  ),
          )
        ],
      ),
    );
  }

  Widget incrementDecrementAddedProduct(ProductDetails productDetails) {
    final addToCartApiProvider = Provider.of<AddToCartAPIProvider>(context);
    final productDetailsProvider =
        Provider.of<ProductDetailsAPIProvider>(context, listen: false);
    final cartListAPiProvider =
        Provider.of<CartListAPIProvider>(context, listen: false);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          materialButtonCommonWithAdditionSubtracitionPlainText(
              fun: () async {
                setState(() {
                  _loadingATB = true;
                });
                if (int.parse(productDetails.cartStatus!.quantity) > 1) {
                  await addToCartApiProvider.addToCart(AddToCartRequestModel(
                      userId: ApiService.userID!,
                      productId: productDetails.id,
                      qtyPrice: productDetails
                          .salePrice[productDetails.selectedQuantityIndex],
                      qtyLimit: productDetails
                          .qty[productDetails.selectedQuantityIndex],
                      indexValue:
                          productDetails.selectedQuantityIndex.toString(),
                      quantity: "-1",
                      status: "1"));
                } else {
                  await addToCartApiProvider.addToCart(AddToCartRequestModel(
                      userId: ApiService.userID!,
                      productId: productDetails.id,
                      qtyPrice: productDetails
                          .salePrice[productDetails.selectedQuantityIndex],
                      indexValue:
                          productDetails.selectedQuantityIndex.toString(),
                      qtyLimit: productDetails
                          .qty[productDetails.selectedQuantityIndex],
                      quantity: "0",
                      status: "0"));
                }
                await productDetailsProvider
                    .getProductDetails(widget.productDetails.id);
                cartListAPiProvider.getCartList;
                if (widget.subCategoryId != null) {
                  context
                      .read<SubCategoryBasedProductAPIPorvider>()
                      .getSubCategoryProducts(widget.subCategoryId!,widget.productDetails.retailerId);
                }
                if (widget.fromRecentlySearched) {
                  context
                      .read<RecentlySearchedAPIProvider>()
                      .recentlySearchedProducts;
                }
                if (widget.fromTopOffers) {
                  context.read<TopOffersApiProvider>().getTopOffersModel;
                }
                setState(() {
                  _loadingATB = false;
                });
              },
              iconData: FontAwesomeIcons.minus),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: SizedBox(
              child: _loadingATB
                  ? const SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      productDetails.cartStatus!.quantity.toString(),
                      style: CommonStyles.whiteText15BoldW500(),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
          materialButtonCommonWithAdditionSubtracitionPlainText(
              fun: () async {
                setState(() {
                  _loadingATB = true;
                  productDetails.incrementAddedCount();
                });
                await addToCartApiProvider.addToCart(AddToCartRequestModel(
                    userId: ApiService.userID!,
                    qtyPrice: productDetails
                        .salePrice[productDetails.selectedQuantityIndex],
                    indexValue: productDetails.selectedQuantityIndex.toString(),
                    qtyLimit: productDetails
                        .qty[productDetails.selectedQuantityIndex],
                    productId: productDetails.id,
                    quantity: "+1",
                    status: "1"));
                await productDetailsProvider
                    .getProductDetails(widget.productDetails.id);
                if (widget.subCategoryId != null) {
                  context
                      .read<SubCategoryBasedProductAPIPorvider>()
                      .getSubCategoryProducts(widget.subCategoryId!,widget.productDetails.retailerId);
                }
                if (widget.fromRecentlySearched) {
                  context
                      .read<RecentlySearchedAPIProvider>()
                      .recentlySearchedProducts;
                }
                if (widget.fromTopOffers) {
                  context.read<TopOffersApiProvider>().getTopOffersModel;
                }
                cartListAPiProvider.getCartList;
                setState(() {
                  _loadingATB = false;
                });
              },
              iconData: FontAwesomeIcons.plus),
        ],
      ),
    );
  }

  Widget productQuantityListWidgets(int index, String quantity) {
    final productDetailsAPIProvider =
        Provider.of<ProductDetailsAPIProvider>(context);

    final selectedProductProperty = productDetailsAPIProvider
        .productDetailsModel!.productDetails!.selectedQuantityIndex;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        height: index == selectedProductProperty ? 80 : 70,
        width: deviceWidth(context),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            boxShadow: [
              index == selectedProductProperty
                  ? const BoxShadow(
                      blurRadius: 2,
                      color: Color.fromARGB(31, 34, 150, 125),
                      offset: Offset(2, 1))
                  : const BoxShadow(color: Colors.transparent)
            ],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: index == selectedProductProperty
                    ? Colors.black
                    : Colors.black54,
                width: index == selectedProductProperty ? 2 : 1)),
        duration: const Duration(milliseconds: 300),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(2)),
                  height: 35,
                  width: 70,
                  child: Center(
                    child: Text(
                        '${productDetailsAPIProvider.productDetailsModel!.productDetails!.discount[selectedProductProperty]}% OFF',
                        style: ProductDetailsStyle.textFieldStyleWhite10()),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    productDetailsAPIProvider
                        .productDetailsModel!.productDetails!.qty[index],
                    style: CommonStyles.blackText14BoldW500(),
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Rs " +
                      productDetailsAPIProvider.productDetailsModel!
                          .productDetails!.salePrice[index],
                  style: CommonStyles.blackText14BoldW500(),
                ),
                Row(
                  children: [
                    Text(
                      "MRP : Rs ",
                      style:
                          ProductDetailsStyle.smallTextSize14grayLineThrough(),
                    ),
                    Text(
                      productDetailsAPIProvider
                          .productDetailsModel!.productDetails!.mrp[index],
                      style:
                          ProductDetailsStyle.smallTextSize14grayLineThrough(),
                    ),
                  ],
                )
              ],
            ),
            Radio(
                value: index,
                groupValue: selectedProductProperty,
                onChanged: (value) {
                  setState(() {
                    productDetailsAPIProvider
                        .productDetailsModel!
                        .productDetails!
                        .selectedQuantityIndex = int.parse(value.toString());
                  });
                })
          ],
        ),
      ),
    );
  }

  Widget parlourSliverProfileInformation() {
    final productDetailsAPIProvider =
        Provider.of<ProductDetailsAPIProvider>(context);
    final selectedProductProperty = productDetailsAPIProvider
        .productDetailsModel!.productDetails!.selectedQuantityIndex;

    return Container(
        height: 140,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(width: 0.8, color: Colors.green),
            //       color: Colors.green[100],
            //       borderRadius: const BorderRadius.all(Radius.circular(2))),
            //   child: Padding(
            //     padding: const EdgeInsets.all(4.0),
            //     child: Text('See more Fresh products',
            //         style: ProductDetailsStyle.smallTextStyle()),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 6.0),
              child: Text(
                productDetailsAPIProvider
                    .productDetailsModel!.productDetails!.productName,
                style: ProductDetailsStyle.productHeaderTextSyle(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0, left: 6.0),
              child: Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text:
                                'Rs ${productDetailsAPIProvider.productDetailsModel!.productDetails!.salePrice[selectedProductProperty]} ',
                            style: ProductDetailsStyle.smallTextSize13()),
                        TextSpan(
                            text: 'MRP : ',
                            style: ProductDetailsStyle.smallTextSize12gray()),
                        TextSpan(
                          text:
                              ' Rs ${productDetailsAPIProvider.productDetailsModel!.productDetails!.mrp[selectedProductProperty]}',
                          style: ProductDetailsStyle
                              .smallTextSize12grayLineThrough(),
                        ),
                      ],
                    ),
                  ),
                  Utils.getSizedBox(width: 25),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(2)),
                    width: 50,
                    child: Center(
                      child: Text(
                          '${productDetailsAPIProvider.productDetailsModel!.productDetails!.discount[selectedProductProperty]}% OFF',
                          style: ProductDetailsStyle.textFieldStyleWhite8()),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Text(
                productDetailsAPIProvider.productDetailsModel!.productDetails!
                    .qty[selectedProductProperty],
                style: ProductDetailsStyle.smallTextSize13(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, top: 4, bottom: 4),
              child: Text(
                "(Inclusive of all taxes)",
                style: ProductDetailsStyle
                    .aboutProductPageStyleS10mallSilverLight(),
              ),
            )
            // Align(
            //   alignment: Alignment.center,
            //   child: cachedNetworkImage(150, 150,
            //       "https://domf5oio6qrcr.cloudfront.net/medialibrary/5299/h1018g16207257715328.jpg"),
            // ),
            // Container(
            //   height: 160,
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Expanded(
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.only(left: 17.0),
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 children: [
            //                   Align(
            //                     alignment: Alignment.topLeft,
            //                     child: Text(
            //                       "address ",
            //                       style: ProductDetailsStyle.normalText(),
            //                       overflow: TextOverflow.fade,
            //                     ),
            //                   ),
            //                   Utils.getSizedBox(height: 10),
            //                   Align(
            //                     alignment: Alignment.topLeft,
            //                     child: Text(
            //                       " ",
            //                       style: ProductDetailsStyle.normalText(),
            //                       textAlign: TextAlign.left,
            //                       overflow: TextOverflow.ellipsis,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             // Row(
            //             //   mainAxisSize: MainAxisSize.min,
            //             //   children: [
            //             //     Padding(
            //             //       padding: const EdgeInsets.only(left: 17.0),
            //             //       child: Row(
            //             //         mainAxisSize: MainAxisSize.min,
            //             //         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             //         children: [
            //             //           Icon(
            //             //             Icons.local_phone,
            //             //             size: 25,
            //             //             color: Colors.brown[200],
            //             //           ),
            //             //           SizedBox(
            //             //             width: 12,
            //             //           ),
            //             //           Text(
            //             //             " ",
            //             //             style: ProductDetailsStyle.normalText(),
            //             //           ),
            //             //         ],
            //             //       ),
            //             //     ),
            //             //     // Row(
            //             //     //   children: [
            //             //     //     //     IconButton(
            //             //     //     //       icon: Icon(
            //             //     //     //         AntDesign.heart,
            //             //     //     //         size: 24,
            //             //     //     //         color: homePageProvider
            //             //     //     //                 .locationDetailsList[widget.index]
            //             //     //     //                 .isLiked
            //             //     //     //             ? Colors.red
            //             //     //     //             : Colors.brown[200],
            //             //     //     //       ),
            //             //     //     //       onPressed: () async {
            //             //     //     //         final databaseService =
            //             //     //     //             Provider.of<DatabaseService>(context,
            //             //     //     //                 listen: false);
            //             //     //     //         if (homePageProvider
            //             //     //     //             .locationDetailsList[widget.index]
            //             //     //     //             .isLiked) {
            //             //     //     //           homePageProvider
            //             //     //     //               .setLikeOnFalsefinalLocationDetails(
            //             //     //     //                   widget.index, false);
            //             //     //     //           await databaseService
            //             //     //     //               .decrementLikeInParlour(
            //             //     //     //                   widget.parlourID,
            //             //     //     //                   homePageProvider
            //             //     //     //                       .locationDetailsList[
            //             //     //     //                           widget.index]
            //             //     //     //                       .likes,
            //             //     //     //                   widget.locationId);
            //             //     //     //         } else {
            //             //     //     //           homePageProvider
            //             //     //     //               .setLikeOnfinalLocationDetails(
            //             //     //     //                   widget.index, true);
            //             //     //     //           await databaseService
            //             //     //     //               .incrementLikeInParlour(
            //             //     //     //                   widget.parlourID,
            //             //     //     //                   homePageProvider
            //             //     //     //                       .locationDetailsList[
            //             //     //     //                           widget.index]
            //             //     //     //                       .likes,
            //             //     //     //                   widget.locationId);
            //             //     //     //         }
            //             //     //     //       },
            //             //     //     //     ),
            //             //     //     //     Text(
            //             //     //     //       homePageProvider
            //             //     //     //               .locationDetailsList[widget.index].likes
            //             //     //     //               .toString() ??
            //             //     //     //           "",
            //             //     //     //       style: HomePageTextStyles()
            //             //     //     //           .controllerCardGeneralFonts(),
            //             //     //     //       overflow: TextOverflow.fade,
            //             //     //     //     ),
            //             //     //     //   ],
            //             //     //     // ),
            //             //     //     // SizedBox(
            //             //     //     //   width: 17,
            //             //     //     // ),
            //             //     //     // Image.asset(
            //             //     //     //   'assets/distance.png',
            //             //     //     //   height: 25,
            //             //     //     //   width: 25,
            //             //     //     // ),
            //             //     //     // SizedBox(
            //             //     //     //   width: 12,
            //             //     //     // ),
            //             //     //     // Text(
            //             //     //     //   "${widget.getTotalDistance.toStringAsPrecision(2)} KM",
            //             //     //     //   style: ViewParlourDetailsTextStyles
            //             //     //     //       .parlourDetailsGeneralFont(),
            //             //     //     // ),
            //             //     //   ],
            //             //     // ),
            //             //   ],
            //             // ),
            //           ],
            //         ),
            //       ),
            //       // CarouselSlider(
            //       //   options: CarouselOptions(
            //       //     autoPlay: true,
            //       //     aspectRatio: 2.0,
            //       //     enlargeCenterPage: true,
            //       //   ),
            //       //   items: _imagesLinkList
            //       //       .map((item) => cardContainer(
            //       //           item, context, carouselControllerProvider))
            //       //       .toList(),
            //       // ),
            //     ],
            //   ),
            // )
          ],
        ));
  }

  //
  showAlertDialog(
      BuildContext context,
      AddToCartAPIProvider addToCartAPIProvider,
      ProductDetailsAPIProvider productDetailsAPIProvider) {
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
            productId: productDetailsAPIProvider
                .productDetailsModel!.productDetails!.id,
            qtyPrice: productDetailsAPIProvider
                    .productDetailsModel!.productDetails!.salePrice[
                productDetailsAPIProvider.productDetailsModel!.productDetails!
                    .selectedQuantityIndex],
            qtyLimit: productDetailsAPIProvider.productDetailsModel!.productDetails!.qty[
                productDetailsAPIProvider.productDetailsModel!.productDetails!
                    .selectedQuantityIndex],
            indexValue: productDetailsAPIProvider.productDetailsModel!.productDetails!.selectedQuantityIndex.toString(),
            quantity: "+1",
            status: "1")
        ).then((value) {
          context.read<ProductDetailsAPIProvider>().getProductDetails(productDetailsAPIProvider
              .productDetailsModel!.productDetails!.id);
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
}

class AppBarProductDetailsPage extends StatefulWidget {
  const AppBarProductDetailsPage({Key? key}) : super(key: key);

  @override
  _AppBarProductDetailsPageState createState() =>
      _AppBarProductDetailsPageState();
}

class _AppBarProductDetailsPageState extends State<AppBarProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: //AppBar for the app
            Container(
          width: deviceWidth(context),
          decoration: const BoxDecoration(
            // borderRadius: BorderRadius.only(
            //     bottomLeft: Radius.circular(12),
            //     bottomRight: Radius.circular(12)),
            gradient: LinearGradient(
              begin: Alignment(-1, 1),
              end: Alignment(1, -1),
              colors: <Color>[
                Color(0xff4158D0),
                Color(0xffc850c0),
                Color(0xffffcc70)
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            // back != true
                            //     ? IconButton(
                            //         icon: const Icon(
                            //           FontAwesomeIcons.bars,
                            //           size: 25,
                            //           color: Colors.white,
                            //         ),
                            //         onPressed: () async {
                            //           scaffoldKey.currentState
                            //               ?.openDrawer();
                            //         },
                            //       )
                            //     : IconButton(
                            //         icon: const Icon(
                            //           FontAwesomeIcons
                            //               .arrowLeft,
                            //           size: 25,
                            //           color: Colors.white,
                            //         ),
                            //         onPressed: () async {
                            //           back != true
                            //               ? scaffoldKey
                            //                   .currentState
                            //                   ?.openDrawer()
                            //               : Navigator.of(
                            //                       context)
                            //                   .pop();
                            //         },
                            //       ),
                            // Text(
                            //   "Review Cart",
                            //   style: HomePageStyles.loginTextStyle(),
                            // ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  // await showSearch(
                                  //     context: context,
                                  //     delegate: DataSearch(
                                  //       controller:
                                  //           textEditingController,
                                  //     ));
                                },
                                icon: const Icon(
                                  Icons.search,
                                  size: 25,
                                  color: Colors.white,
                                )),
                            // if (!onlySearch)
                            //   IconButton(
                            //     onPressed: () {},
                            //     icon: const Icon(Icons.share,
                            //         size: 27,
                            //         color: Colors.white),
                            //   ),
                            // if (!onlySearch)
                            //   IconButton(
                            //     onPressed: () {},
                            //     icon: const Icon(
                            //         Icons.shopping_cart,
                            //         size: 27,
                            //         color: Colors.white),
                            //   ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   width: deviceWidth(context),
                  //   padding: const EdgeInsets.only(
                  //       top: 10, bottom: 10, right: 15, left: 15),
                  //   child: Form(
                  //     key: searchKey,
                  //     child: searchTextField(searchTextEditingController, "Item Name",
                  //         "Item Name", "Item Name", "", "", context, list1, list2),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
