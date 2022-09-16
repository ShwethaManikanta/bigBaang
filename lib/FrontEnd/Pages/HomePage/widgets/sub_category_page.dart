import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/widgets/banner_drawers.dart';
import 'package:bigbaang/Models/category_model.dart';
import 'package:bigbaang/widgets/appbar.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/widgets/gird_view_subCategories.dart';
import 'package:flutter/material.dart';

class SubCategoryGridViewPage extends StatefulWidget {
  const SubCategoryGridViewPage({Key? key, required this.categoryList,required this.retailerID})
      : super(key: key);

  final CategoryList categoryList;
  final String retailerID;

  @override
  _SubCategoryGridViewPageState createState() =>
      _SubCategoryGridViewPageState();
}

class _SubCategoryGridViewPageState extends State<SubCategoryGridViewPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: FlexibleSpaceBar(
          background: AppBarProductPage(
            scaffoldKey: scaffoldKey,
            appBartext: widget.categoryList.categoryName,
            onlySearch: false,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Utils.getSizedBox(height: 5),
            const CarouselBanner(),
            Utils.getSizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                            image: ExactAssetImage(
                              "assets/images/shop.jpg",
                            ),
                            fit: BoxFit.fitWidth)),
                  ),
                  Utils.getSizedBox(height: 10),
                  Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: GridViewDelegate(
                        categoryID: widget.categoryList.id,
                        retailerId: widget.retailerID.toString(),
                      )),
                  Utils.getSizedBox(height: 50),
                  Container(
                    height: 120,
                    width: 1000,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage(
                            "assets/images/vegbanner.jpg",
                          ),
                          fit: BoxFit.fitWidth),
                    ),
                    child: Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 4),
                          child: Text(
                            "Your Daily Needs",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Text(
                          "VEGETABLES",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.grey,
                              letterSpacing: 3),
                        ),
                      ],
                    ),
                  ),
                  //  ProductPrice(widget: widget,),

                  /* Container(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => AllProductViewPage(subCategoryId: ,)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "View More",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.deepPurple),
                            ),
                            Icon(
                              Icons.chevron_right_sharp,
                              color: Colors.deepPurple,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),*/
                  Utils.getSizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
