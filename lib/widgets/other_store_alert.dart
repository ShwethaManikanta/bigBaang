import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/Models/add_to_cart_model.dart';
import 'package:bigbaang/service/addtocart_api_provider.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:bigbaang/service/clear_cart_api_provider.dart';
import 'package:bigbaang/service/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtherStoreALert {
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
        Navigator.of(context).pop();
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
            status: "1"));
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
