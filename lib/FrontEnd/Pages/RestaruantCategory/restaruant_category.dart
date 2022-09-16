import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/Pages/CategoryPage/widgets/vertical_category_list_builder.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/styles/home_page_styles.dart';
import 'package:bigbaang/Models/category_model.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:bigbaang/service/category_list_api_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaruantCategory extends StatefulWidget {
  final String retailerID;
  final String retailerName;
  final String retailerAddress;
  final String baseURL;
  final String imgURL;
  const RestaruantCategory(
      {Key? key,
      required this.retailerID,
      required this.retailerName,
      required this.retailerAddress,
      required this.baseURL,
      required this.imgURL})
      : super(key: key);

  @override
  _RestaruantCategoryState createState() => _RestaruantCategoryState();
}

class _RestaruantCategoryState extends State<RestaruantCategory> {
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();

  ApiService apiService = ApiService();
  bool _isLoading = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  CategoryListData? _categoryListData;

  Future getData() async {
    await apiServices.getRetailerCategory(widget.retailerID).then((value) {
      setState(() {
        _categoryListData = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    print("----------- Restaruant -------");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          widget.retailerName.toUpperCase(),
          style: HomePageStyles.loginTextStyle(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 20,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  height: 180,
                  fit: BoxFit.cover,
                  imageUrl: widget.baseURL + widget.imgURL,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "${widget.retailerName}".toUpperCase(),
              style: CommonStyles.blueBold(),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_history,
                    size: 18,
                    color: Colors.indigo,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      widget.retailerAddress,
                      style: CommonStyles.blackBold12(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
                child: _isLoading
                    ? loadingWidget()
                    : ListView.builder(
                        padding: const EdgeInsets.all(0),
                        scrollDirection: Axis.vertical,
                        itemCount: _categoryListData!.categoryList!.length,
                        shrinkWrap: true,
                        primary: false,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemBuilder: (context, index) {
                          return CategoryWidget(
retailerID: widget.retailerID,
                            categoryList:
                                _categoryListData!.categoryList![index],
                            imageBaseUrl: _categoryListData!.categoryBaseurl,
                          );
                        }))
          ],
        ),
      ),
    );
  }

  Widget loadingWidget() {
    return const Center(
      child: SizedBox(
        height: 25,
        width: 25,
        child: CircularProgressIndicator(
          strokeWidth: 1,
        ),
      ),
    );
  }
}
