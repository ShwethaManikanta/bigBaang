import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/Pages/all_product_view.dart';
import 'package:bigbaang/Models/sub_category_model.dart';
import 'package:flutter/material.dart';

class ScrollableCategoryNames extends StatelessWidget {
  const ScrollableCategoryNames({Key? key, required this.subCategoryList})
      : super(key: key);

  final List<SubcategoryList> subCategoryList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
      height: 55,
      width: deviceWidth(context),
      color: Colors.black26,
      child: Center(
        child: ListView.builder(
            itemCount: subCategoryList.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Center(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => AllProductViewPage(
                              subCategoryList: subCategoryList,
                              subCategoryId: subCategoryList[index].id,
                              subCategoryName:
                                  subCategoryList[index].subcategoryName,
retailerID: "",

                            )));
                  },
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    child: Center(
                      child: Text(
                        "  ${subCategoryList[index].subcategoryName}  ",
                        style: CommonStyles.blackText10BoldW500(),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
