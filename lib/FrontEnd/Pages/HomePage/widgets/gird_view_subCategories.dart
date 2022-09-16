import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/Models/sub_category_model.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:flutter/material.dart';

import '../../../CommonWidgets/cached_network_image.dart';
import '../../all_product_view.dart';

class GridViewDelegate extends StatefulWidget {
  const GridViewDelegate({Key? key,
    required this.categoryID,
    required this.retailerId,
 //   required this.type

  })
      : super(key: key);

  final String categoryID;
  final String retailerId;
 // final String type;

  @override
  State<GridViewDelegate> createState() => _GridViewDelegateState();
}

class _GridViewDelegateState extends State<GridViewDelegate> {
  bool _isLoading = true;
  SubCategoryModel? _subCategoryModel;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    await apiServices.getSubCategory(widget.categoryID,widget.retailerId).then((value) {
      setState(() {
        _subCategoryModel = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        height: 300,
        width: deviceWidth(context),
        child: Center(
          child: SizedBox(
              height: 80,
              width: 80,
              child: Image.asset("assets/images/bblogo.png")),
        ),
      );
    } else if (_subCategoryModel!.status == "0") {
      return SizedBox(
        height: 300,
        width: deviceWidth(context),
        child: Center(
          child: Text(
            "Oops!! Something went wrong :( !! Please Try again",
            style: CommonStyles.blackText10BoldW500(),
          ),
        ),
      );
    } else {
      return GridView.builder(
        clipBehavior: Clip.none,
        itemCount: _subCategoryModel!.subcategoryList!.length,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        primary: false,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _subCategoryModel!.subcategoryList!.length == 1
                ? 1
                : _subCategoryModel!.subcategoryList!.length == 2
                    ? 2
                    : 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 20,
            mainAxisExtent: 135),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => (AllProductViewPage(
                    retailerID: widget.retailerId,
                      subCategoryList: _subCategoryModel!.subcategoryList!,
                      subCategoryId:
                          _subCategoryModel!.subcategoryList![index].id,
                      subCategoryName: _subCategoryModel!
                          .subcategoryList![index].subcategoryName))));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 10,
              shadowColor: Colors.lightBlueAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: cachedNetworkImage(
                      100,
                      100,
                      _subCategoryModel!.subcategoryBaseurl! +
                          _subCategoryModel!
                              .subcategoryList![index].subcategoryImage,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 10),
                    child: SizedBox(
                      width: 115,
                      child: Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            _subCategoryModel!
                                .subcategoryList![index].subcategoryName,
                            style: CommonStyles.textw300BlackS10(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
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
