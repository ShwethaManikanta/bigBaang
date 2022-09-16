import 'package:bigbaang/FrontEnd/CommonWidgets/cached_network_image.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/ProductDetailsPage/product_details_page.dart';
import 'package:bigbaang/FrontEnd/Pages/ProductDetailsPage/styles/product_details_style.dart';
import 'package:bigbaang/FrontEnd/Pages/ProductDetailsPage/widgets/remaining_sliver_screen.dart';
import 'package:bigbaang/FrontEnd/Pages/ProductDetailsPage/widgets/sliver_bar.dart';
import 'package:bigbaang/Models/product_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../Models/add_to_cart_model.dart';
import '../../../Models/save_product_models.dart';
import '../../../service/addtocart_api_provider.dart';
import '../../../service/api_service.dart';
import '../../CommonWidgets/common_buttons.dart';

class ProductDetailsWithModelProductPage extends StatefulWidget {
  final ProductDetails productDetails;
  final String baseImageUrl;
  const ProductDetailsWithModelProductPage(
      {Key? key, required this.productDetails, required this.baseImageUrl})
      : super(key: key);

  @override
  _ProductDetailsProductIdPageState createState() =>
      _ProductDetailsProductIdPageState();
}

class _ProductDetailsProductIdPageState
    extends State<ProductDetailsWithModelProductPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const FlexibleSpaceBar(
          background: AppBarProductDetailsPage(),
        ),
      ),
      body: Builder(builder: (context) {
        return CustomScrollView(
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
                delegate: SliverChildBuilderDelegate((context, index) {
              return productQuantityListWidgets(
                  index, widget.productDetails.qty[index]);
            }, childCount: widget.productDetails.qty.length)),
            SliverToBoxAdapter(
              child: RemainingSliverScreen(productModel: widget.productDetails),
            ),
          ],
        );
      }),
    );
  }

  parlourSliverProductImage() {
    return SizedBox(
      height: 150,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: cachedNetworkImage(150, 150,
              widget.baseImageUrl + widget.productDetails.productImage),
        ),
      ),
    );
  }

  Widget saveAndAddToBasketButtonsWidget() {
    final addToCartApiProvider = Provider.of<AddToCartAPIProvider>(context);

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
            child: widget.productDetails.saveProductForLater
                ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Icon(
                      Icons.bookmark_added,
                      color: Colors.white,
                    ),
                    Utils.getSizedBox(width: 5),
                    Text(
                      'SAVED',
                      style: ProductDetailsStyle.whiteText13BoldW500(),
                    )
                  ])
                : GestureDetector(
                    onTap: () async {
                      setState(() {
                        widget.productDetails.saveProductForLater = true;
                      });
                      final result = await apiServices.saveProduct(
                          saveProductRequestModel: SaveProductRequestModel(
                              productId: widget.productDetails.id,
                              status: "1",
                              userId: ApiService.userID!));
                      if (result == null) {
                        Utils.getFloatingSnackBar(
                            context: context,
                            snackBarText: "Oops! Something Went Wrong!");
                      } else {
                        Utils.getFloatingSnackBar(
                            context: context, snackBarText: result.message);
                      }
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.bookmark_add_outlined,
                            color: Colors.white,
                          ),
                          Utils.getSizedBox(width: 5),
                          Text(
                            'SAVE FOR LATER',
                            style: ProductDetailsStyle.whiteText13BoldW500(),
                          )
                        ]),
                  ),
          ),
          Container(
            color: Colors.red,
            width: deviceWidth(context) / 2,
            height: 50,
            child: widget.productDetails.getIsAddedToCart()
                ? incrementDecrementAddedProduct(widget.productDetails)
                : GestureDetector(
                    onTap: () async {
                      setState(() {
                        widget.productDetails.isAddedToCart = true;
                        widget.productDetails.incrementAddedCount();
                      });
                      await addToCartApiProvider.addToCart(
                          AddToCartRequestModel(
                              userId: ApiService.userID!,
                              productId: widget.productDetails.id,
                              qtyPrice: widget.productDetails.salePrice[
                                  widget.productDetails.selectedQuantityIndex],
                              qtyLimit: widget.productDetails.qty[
                                  widget.productDetails.selectedQuantityIndex],
                              indexValue: widget
                                  .productDetails.selectedQuantityIndex
                                  .toString(),
                              quantity: "+1",
                              status: "1"));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.shopping_bag_outlined,
                            color: Colors.white),
                        Utils.getSizedBox(width: 5),
                        Text(
                          'ADD TO BASKET',
                          style: ProductDetailsStyle.whiteText13BoldW500(),
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
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          materialButtonCommonWithAdditionSubtracitionPlainText(
              fun: () async {
                if (productDetails.getAddedCartCount() > 1) {
                  productDetails.decrementAddedCount();
                  await addToCartApiProvider.addToCart(AddToCartRequestModel(
                      userId: ApiService.userID!,
                      productId: productDetails.id,
                      indexValue:
                          productDetails.selectedQuantityIndex.toString(),
                      qtyPrice: productDetails
                          .salePrice[productDetails.selectedQuantityIndex],
                      qtyLimit: productDetails
                          .qty[productDetails.selectedQuantityIndex],
                      quantity: "-1",
                      status: "1"));
                } else {
                  productDetails.isAddedToCart = false;
                  productDetails.decrementAddedCount();
                  await addToCartApiProvider.addToCart(AddToCartRequestModel(
                      userId: ApiService.userID!,
                      productId: productDetails.id,
                      indexValue:
                          productDetails.selectedQuantityIndex.toString(),
                      qtyPrice: productDetails
                          .salePrice[productDetails.selectedQuantityIndex],
                      qtyLimit: productDetails
                          .qty[productDetails.selectedQuantityIndex],
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
                style: CommonStyles.whiteText15BoldW500(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          materialButtonCommonWithAdditionSubtracitionPlainText(
              fun: () async {
                setState(() {
                  productDetails.incrementAddedCount();
                });
                await addToCartApiProvider.addToCart(AddToCartRequestModel(
                    userId: ApiService.userID!,
                    indexValue: productDetails.selectedQuantityIndex.toString(),
                    qtyPrice: productDetails
                        .salePrice[productDetails.selectedQuantityIndex],
                    qtyLimit: productDetails
                        .qty[productDetails.selectedQuantityIndex],
                    productId: productDetails.id,
                    quantity: "+1",
                    status: "1"));
              },
              iconData: FontAwesomeIcons.plus),
        ],
      ),
    );
  }

  Widget productQuantityListWidgets(int index, String quantity) {
    final selectedProductProperty = widget.productDetails.selectedQuantityIndex;

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
                        '${widget.productDetails.discount[selectedProductProperty]}% OFF',
                        style: ProductDetailsStyle.textFieldStyleWhite10()),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.productDetails.qty[index],
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
                  "Rs " + widget.productDetails.salePrice[index],
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
                      widget.productDetails.mrp[index],
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
                    widget.productDetails.selectedQuantityIndex =
                        int.parse(value.toString());
                  });
                })
          ],
        ),
      ),
    );
  }

  parlourSliverHeader() {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            width: deviceWidth(context) / 2,
            height: 50,
            color: Colors.brown[800],
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(
                Icons.bookmark_border,
                color: Colors.white,
              ),
              Utils.getSizedBox(width: 5),
              Text(
                'SAVE FOR LATER',
                style: ProductDetailsStyle.whiteText13BoldW500(),
              )
            ]),
          ),
          Container(
            color: Colors.red,
            width: deviceWidth(context) / 2,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                Utils.getSizedBox(width: 5),
                Text(
                  'ADD TO BASKET',
                  style: ProductDetailsStyle.whiteText13BoldW500(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget parlourSliverProfileInformation() {
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
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.8, color: Colors.green),
                  color: Colors.green[100],
                  borderRadius: const BorderRadius.all(Radius.circular(2))),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('See more Fresh products',
                    style: ProductDetailsStyle.smallTextStyle()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 6.0),
              child: Text(
                widget.productDetails.productName,
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
                                'Rs ${widget.productDetails.salePrice[widget.productDetails.selectedQuantityIndex]} ',
                            style: ProductDetailsStyle.smallTextSize13()),
                        TextSpan(
                            text: 'MRP : ',
                            style: ProductDetailsStyle.smallTextSize12gray()),
                        TextSpan(
                          text:
                              ' Rs ${widget.productDetails.mrp[widget.productDetails.selectedQuantityIndex]}',
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
                    height: 15,
                    width: 50,
                    child: Center(
                      child: Text(
                          '${widget.productDetails.discount[widget.productDetails.selectedQuantityIndex]}% OFF',
                          style: ProductDetailsStyle.textFieldStyleWhite8()),
                    ),
                  )
                ],
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
          ],
        ));
  }
}
