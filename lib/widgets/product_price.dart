import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/LoginPage/styles/phone_verification_styles.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/widgets/sub_category_page.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:bigbaang/widgets/offer_tag.dart';
import 'package:bigbaang/widgets/price_tag.dart';
import 'package:flutter/material.dart';

class ProductPrice extends StatefulWidget {
  final String categoryId;
  ProductPrice({Key? key, required this.widget, required this.categoryId})
      : super(key: key);

  final SubCategoryGridViewPage widget;
  @override
  State<ProductPrice> createState() => _ProductPriceState();
}

class _ProductPriceState extends State<ProductPrice> {
  ApiService apiService = ApiService();

  Future<void> getSubCategory() async {
    await apiService.getSubCategory(widget.categoryId,"").whenComplete(() {
      setState(() {
        print(apiService.getSubCategory(widget.categoryId,""));
      });
    });
  }

  @override
  void initState() {
    getSubCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.white,
      child: Column(
        children: [
          Column(
            children: List.generate(5, (index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => ProductDetailsPage(
                            //           productId: ApiService.subCategoryModel!
                            //               .subcategoryProductDetails![index].id,
                            //         )));
                          },
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              children: [
                                const OfferTag(offerPercentage: "59"),
                                Utils.getSizedBox(height: 5),
                                Image.asset(
                                  "assets/images/tomato.jpg",
                                  height: 120,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Utils.getSizedBox(width: 20),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 160,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Fresho".toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                  Container(
                                    height: 26,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black12,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.car_repair,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                        Utils.getSizedBox(width: 5),
                                        Text(
                                          "1 Day",
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Utils.getSizedBox(height: 5),
                              Text(
                                "Tomato",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Utils.getSizedBox(height: 5),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20, bottom: 2, top: 2),
                                height: 25,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(3)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "2",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                        children: [
                                          TextSpan(
                                            text: " ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: "Kg",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    dropDown()
                                  ],
                                ),
                              ),
                              Utils.getSizedBox(height: 5),
                              const PriceTag(
                                mrp: "20",
                                salePrice: "10",
                              ),
                              Utils.getSizedBox(height: 4),
                              MaterialButton(
                                elevation: 5,
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.35,
                                height: 35,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                onPressed: () {},
                                child: Text(
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
                  ),
                  Utils.getSizedBox(height: 10),
                  Divider(),
                  // Utils.getSizedBox(height: 10),
                ],
              );
            }),
          ),
          // Utils.getSizedBox(height: 5),
        ],
      ),
    );
  }

  Widget dropDown() {
    return DropdownButton<String>(
      items: <String>['1 Kg', '2 Kg', '5 Kg'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (_) {},
    );
  }

  bool onPressedAdd = false;
}
