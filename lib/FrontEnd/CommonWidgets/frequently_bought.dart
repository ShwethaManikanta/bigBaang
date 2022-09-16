import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/all_product_view.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:bigbaang/widgets/offer_tag.dart';
import 'package:bigbaang/widgets/price_tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FrequentlyBoughtTogether extends StatefulWidget {
  const FrequentlyBoughtTogether({Key? key}) : super(key: key);

  @override
  _FrequentlyBoughtTogetherState createState() =>
      _FrequentlyBoughtTogetherState();
}

class _FrequentlyBoughtTogetherState extends State<FrequentlyBoughtTogether> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: SizedBox(
        height: 400,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return listViewItemWidget(index);
          },
        ),
      ),
    );
  }

  listViewItemWidget(int index) {
    if (index < 3) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 370,
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OfferTag(
                    offerPercentage: "59",
                  ),
                  Utils.getSizedBox(height: 10),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/images/corn.jpg",
                        width: 100,
                      ),
                    ),
                  ),
                  Utils.getSizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.lightGreen, width: 2)),
                      child: const Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Utils.getSizedBox(height: 15),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Fresho",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "-",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Sweet Corn",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Utils.getSizedBox(height: 5),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      height: 25,
                      width: 160,
                      color: Colors.black12,
                      child: RichText(
                        text: TextSpan(
                          text: "2",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          children: [
                            TextSpan(
                              text: " ",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            TextSpan(
                              text: "Pcs",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    PriceTag(
                      mrp: "10",
                      salePrice: "1",
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "ADD",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )))
                  ],
                ))
          ],
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 370,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.orangeAccent,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => AllProductViewPage(
          //       subCategoryList: ,
          //         subCategoryId: ApiService
          //             .categoriesList!.categoryList![index].categoryName,
          //         subCategoryName:
          //             ApiService.categoriesList!.categoryList![index].id)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "VIEW ALL",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "Frequently Bought Together",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.orangeAccent,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
