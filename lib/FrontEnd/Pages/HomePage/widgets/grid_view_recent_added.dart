import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/styles/home_page_styles.dart';
import 'package:bigbaang/FrontEnd/Pages/all_product_view.dart';
import 'package:bigbaang/Models/sub_category_model.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:flutter/material.dart';

import '../../../CommonWidgets/cached_network_image.dart';

class GridViewRecent extends StatefulWidget {
  final String categoryId;
  final String retailerID;
  const GridViewRecent({Key? key, required this.categoryId,required this.retailerID}) : super(key: key);

  @override
  State<GridViewRecent> createState() => _GridViewRecentState();
}

class _GridViewRecentState extends State<GridViewRecent> {
  bool isLoading = true;
  SubCategoryModel? _subCategoryModel;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    await apiServices.getSubCategory(widget.categoryId,widget.retailerID).then((value) {
      setState(() {
        _subCategoryModel = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: 150,
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
    } else {
      return GridView.builder(
        itemCount: _subCategoryModel!.subcategoryList!.length,
        padding: EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        addAutomaticKeepAlives: false,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
          childAspectRatio: 1,
        ),
        itemBuilder: (
          context,
          index,
        ) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AllProductViewPage(
                      subCategoryList: _subCategoryModel!.subcategoryList!,
                      subCategoryId:
                          _subCategoryModel!.subcategoryList![index].id,
                      subCategoryName: _subCategoryModel!
                          .subcategoryList![index].subcategoryName,
                  retailerID: widget.retailerID,
                  )));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: Colors.orange,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CachedNetworkImageSubCategoryViewHomePage(
                    height: 70,
                    width: 70,
                    imageUrl: _subCategoryModel!.subcategoryBaseurl! +
                        _subCategoryModel!
                            .subcategoryList![index].subcategoryImage,
                  ),
                  // cachedNetworkImage(
                  //   70, 70,
                  //   _subCategoryModel!.subcategoryBaseurl! +
                  //       _subCategoryModel!
                  //           .subcategoryList![index].subcategoryName,
                  //   //  fit: BoxFit.contain,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 2),
                    child: Text(
                        _subCategoryModel!
                            .subcategoryList![index].subcategoryName,
                        style: HomePageStyles.normalText(),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
