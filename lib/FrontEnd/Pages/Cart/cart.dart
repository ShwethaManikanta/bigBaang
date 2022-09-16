import 'package:bigbaang/FrontEnd/CommonWidgets/cached_network_image.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/Cart/widget/app_bar.dart';
import 'package:bigbaang/FrontEnd/Pages/CheckoutPage/check_out_page.dart';
import 'package:bigbaang/Models/cart_product_model.dart';
import 'package:bigbaang/service/addtocart_api_provider.dart';
import 'package:bigbaang/service/recently_searched_api_provider.dart';
import 'package:bigbaang/service/top_offers_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../Models/add_to_cart_model.dart';
import '../../../service/api_service.dart';
import '../../CommonWidgets/common_buttons.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    initializeCartList();
    super.initState();
  }

  initializeCartList() async {
    if (context.read<CartListAPIProvider>().cartListResponseModel == null) {
      await context.read<CartListAPIProvider>().getCartList;
    }
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final cartListApiProvider = Provider.of<CartListAPIProvider>(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            background: CustomAppBar(
              back: true,
              scaffoldKey: scaffoldKey,
            ),
          ),
        ),
        key: scaffoldKey,
        backgroundColor: Colors.grey.shade100,
        // drawer: drawer(context),
        body: cartListApiProvider.ifLoading
            ? loadingWidget()
            : cartListApiProvider.error
                ? errorWidget()
                : cartListApiProvider.cartListResponseModel!.cartDetails == null
                    ? cartEmptySection()
                    : Column(
                        // padding: EdgeInsets.zero,
                        children: <Widget>[
                          // createHeader(),
                          createSubTitle(),
                          Expanded(child: createCartList()),
                          footer(context)
                        ],
                      ));
  }

  Widget loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 1,
        color: Colors.blue,
      ),
    );
  }

  Widget errorWidget() {
    final cartListApiProvider = Provider.of<CartListAPIProvider>(context);
    return Center(
      child: Text(
        cartListApiProvider.errorMessage,
        style: CommonStyles.textw400BlueS14(),
      ),
    );
  }

  Widget cartEmptySection() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "You'r Shopping Cart is Empty!",
            style: CommonStyles.textw400BlueS14(),
          ),
          Text(
            "Enjoy Shopping!!",
            style: CommonStyles.textw200BlueS14(),
          ),
        ],
      ),
    );
  }

  Widget footer(BuildContext context) {
    final cartListAPIProvider = Provider.of<CartListAPIProvider>(context);
    return Container(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Text(
                  "Total",
                  style: CommonStyles.blueBold12(),
                ),
              ),
              Utils.getSizedBox(width: 10),
              Container(
                margin: const EdgeInsets.only(right: 30),
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.rupeeSign,
                      size: 18,
                      color: Colors.green,
                    ),
                    Text(
                      cartListAPIProvider.cartListResponseModel!.total
                          .toString(),
                      style: CommonStyles.greenBold(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Utils.getSizedBox(height: 8),
          MaterialButton(
            minWidth: deviceWidth(context) * 0.9,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CheckOutPage()));
            },
            color: Colors.green,
            padding:
                const EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Text("Checkout", style: CommonStyles.whiteText15BoldW500()),
          ),
          Utils.getSizedBox(height: 8),
        ],
      ),
      margin: const EdgeInsets.only(top: 16),
    );
  }

  // Widget createHeader() {
  //   return Container(
  //     alignment: Alignment.topLeft,
  //     padding: const EdgeInsets.only(top: 15, left: 8),
  //     child: Text(
  //       "SHOPPING CART",
  //       style: CommonStyles.submitTextStyle(),
  //     ),
  //     // margin: const EdgeInsets.only(left: 12, top: 15),
  //   );
  // }

  Widget createSubTitle() {
    final cartListAPIProvider = Provider.of<CartListAPIProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.topLeft,
        child: Text(
          "Total (${cartListAPIProvider.cartListResponseModel!.countProduct}) Items",
          style: CommonStyles.textw400BlueS14(),
        ),
        margin: const EdgeInsets.only(left: 8, top: 4),
      ),
    );
  }

  Widget createCartList() {
    final cartListApiProvider = Provider.of<CartListAPIProvider>(context);
    final addToCartProvider = Provider.of<AddToCartAPIProvider>(context);
    final topOfferApiProvider =
        Provider.of<TopOffersApiProvider>(context, listen: false);
    final recentlySearchedApiProvider =
        Provider.of<RecentlySearchedAPIProvider>(context, listen: false);
    // List<ProductsInCart> _list = List.generate(
    //     5,
    //     (index) => ProductsInCart('assets/images/tomato.jpg',
    //         productName: "Tomato",
    //         urlImage:
    //             "https://cdn.shopify.com/s/files/1/0047/9730/0847/products/nurserylive-seeds-tomato-round-desi-vegetable-seeds-16969384296588_300x@2x.jpg?v=1601351553",
    //         unit: 'Kg',
    //         totalQuantity: 10,
    //         actualAmount: 500,
    //         amountAfterDiscount: 390,
    //         cartQuantity: 2));
    return ListView.builder(
      key: UniqueKey(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.,
      primary: false,
      itemBuilder: (context, index) {
        return Dismissible(

            // confirmDismiss: Container(child: ,),
            onDismissed: (dismissedDirection) async {
              print(cartListApiProvider
                      .cartListResponseModel!.cartDetails![index].id +
                  "------" +
                  index.toString());
              await addToCartProvider.addToCart(AddToCartRequestModel(
                  userId: ApiService.userID!,
                  productId: cartListApiProvider
                      .cartListResponseModel!.cartDetails![index].productId,
                  qtyPrice: cartListApiProvider
                      .cartListResponseModel!.cartDetails![index].qtyPrice,
                  qtyLimit: cartListApiProvider
                      .cartListResponseModel!.cartDetails![index].quantityLimit,
                  indexValue: cartListApiProvider
                      .cartListResponseModel!.cartDetails![index].indexValue,
                  quantity: "-1",
                  status: "0"));
              await cartListApiProvider.getCartList;

              if (addToCartProvider.addToCartResponse!.status == "1") {
                ScaffoldMessenger.of(scaffoldKey.currentContext!)
                    .showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          addToCartProvider.addToCartResponse!.message,
                          style: CommonStyles.textDataWhite12Bold(),
                        )));

                // Utils.getFloatingSnackBar(
                //     context: context,
                //     snackBarText: addToCartProvider.addToCartResponse!.message);
              }

              topOfferApiProvider.topOffersModel;
              recentlySearchedApiProvider.recentlySearchedProducts;
              // setState(() {
              //   _updatingValue = false;
              // });
            },
            key: UniqueKey(),
            child: ListViewCartWidget(
              cartDetails: cartListApiProvider
                  .cartListResponseModel!.cartDetails![index],
              baseImageUrl:
                  cartListApiProvider.cartListResponseModel!.productImageUrl!,
              scaffoldState: scaffoldKey,
            )

            // createCartListItem(
            //     cartListApiProvider
            //         .cartListResponseModel!.cartDetails![index],
            //     index)

            );
      },
      itemCount: cartListApiProvider.cartListResponseModel!.cartDetails!.length,
    );
  }

// Widget createCartListItem(CartDetails cartDetails, int index) {

//   return
// }
}

class ListViewCartWidget extends StatefulWidget {
  const ListViewCartWidget({
    Key? key,
    required this.cartDetails,
    required this.scaffoldState,
    required this.baseImageUrl,
  }) : super(key: key);

  final CartDetails cartDetails;
  final String baseImageUrl;

  final GlobalKey<ScaffoldState> scaffoldState;

  @override
  _ListViewCartWidgetState createState() => _ListViewCartWidgetState();
}

class _ListViewCartWidgetState extends State<ListViewCartWidget> {
  bool _updatingValue = false;

  @override
  Widget build(BuildContext context) {
    final addToCartApiProvider = Provider.of<AddToCartAPIProvider>(context);
    final cartListApiProvider = Provider.of<CartListAPIProvider>(context);
    final topOfferApiProvider =
        Provider.of<TopOffersApiProvider>(context, listen: false);
    final recentlySearchedApiProvider =
        Provider.of<RecentlySearchedAPIProvider>(context, listen: false);

    return Stack(
      children: <Widget>[
        Column(
          children: [
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: <Widget>[
                  Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    shadowColor: Colors.white,
                    margin: const EdgeInsets.only(
                        right: 8, left: 8, top: 8, bottom: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: cachedNetworkImage(
                          80,
                          80,
                          widget.baseImageUrl +
                              widget.cartDetails.productImage),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(right: 8, top: 4),
                            child: Text(
                              widget.cartDetails.productName.toUpperCase(),
                              maxLines: 2,
                              softWrap: true,
                              style: CommonStyles.blueBold12(),
                            ),
                          ),
                          Utils.getSizedBox(height: 6),
                          Row(
                            children: [
                              Text(
                                "Price  :  ${widget.cartDetails.qtyPrice}"
                                    .toString(),
                                style: CommonStyles.blackBold12(),
                              ),
                              /* Text(
                                widget.cartDetails.quantityLimit.toString(),
                                style: CommonStyles.blackText14BoldW500(),
                              ),*/
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Product Total  : ₹ ${widget.cartDetails.product_total}"
                                    .toString(),
                                style: CommonStyles.blueBold12(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                          if (int.parse(
                                                  widget.cartDetails.quantity) >
                                              1) {
                                            await addToCartApiProvider
                                                .addToCart(
                                                    AddToCartRequestModel(
                                                        userId:
                                                            ApiService.userID!,
                                                        productId: widget
                                                            .cartDetails
                                                            .productId,
                                                        qtyPrice: widget
                                                            .cartDetails
                                                            .qtyPrice,
                                                        qtyLimit: widget
                                                            .cartDetails
                                                            .quantityLimit,
                                                        indexValue: widget
                                                            .cartDetails
                                                            .indexValue,
                                                        quantity: "-1",
                                                        status: "1"));
                                          } else {
                                            await addToCartApiProvider
                                                .addToCart(
                                                    AddToCartRequestModel(
                                                        userId:
                                                            ApiService.userID!,
                                                        productId: widget
                                                            .cartDetails
                                                            .productId,
                                                        qtyPrice: widget
                                                            .cartDetails
                                                            .qtyPrice,
                                                        qtyLimit: widget
                                                            .cartDetails
                                                            .quantityLimit,
                                                        indexValue: widget
                                                            .cartDetails
                                                            .indexValue,
                                                        quantity: "-1",
                                                        status: "0"));
                                          }
                                          await cartListApiProvider.getCartList;
                                          recentlySearchedApiProvider
                                              .recentlySearchedProducts;
                                          topOfferApiProvider.topOffersModel;

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
                                                widget.cartDetails.quantity
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
                                                  productId: widget
                                                      .cartDetails.productId,
                                                  qtyPrice: widget
                                                      .cartDetails.qtyPrice,
                                                  qtyLimit: widget.cartDetails
                                                      .quantityLimit,
                                                  indexValue: widget
                                                      .cartDetails.indexValue,
                                                  quantity: "+1",
                                                  status: "1"));
                                          await cartListApiProvider.getCartList;
                                          topOfferApiProvider.topOffersModel;

                                          recentlySearchedApiProvider
                                              .recentlySearchedProducts;
                                          setState(() {
                                            _updatingValue = false;
                                          });
                                        },
                                        iconData: FontAwesomeIcons.plus),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    flex: 100,
                  )
                ],
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () async {
              await addToCartApiProvider.addToCart(AddToCartRequestModel(
                  userId: ApiService.userID!,
                  productId: widget.cartDetails.productId,
                  qtyPrice: widget.cartDetails.qtyPrice,
                  qtyLimit: widget.cartDetails.quantityLimit,
                  indexValue: widget.cartDetails.indexValue,
                  quantity: "-1",
                  status: "0"));
              topOfferApiProvider.topOffersModel;
              recentlySearchedApiProvider.recentlySearchedProducts;
              await cartListApiProvider.getCartList;
              ScaffoldMessenger.of(widget.scaffoldState.currentContext!)
                  .showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                          addToCartApiProvider.addToCartResponse!.message)));
            },
            child: Container(
              width: 17,
              height: 17,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 8, top: 8),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 15,
              ),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: Colors.red),
            ),
          ),
        )
      ],
    );
  }
}
