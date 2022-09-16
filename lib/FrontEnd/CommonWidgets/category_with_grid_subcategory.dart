import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/category_list_api_provider.dart';
import '../Pages/HomePage/home_page.dart';
import '../Pages/HomePage/widgets/grid_view_recent_added.dart';

class CategoryListWithSubCategoryGrid extends StatefulWidget {

  final String retailerID;

  const CategoryListWithSubCategoryGrid({Key? key,required this.retailerID}) : super(key: key);

  @override
  _CategoryListWithSubCategoryGridState createState() =>
      _CategoryListWithSubCategoryGridState();
}

class _CategoryListWithSubCategoryGridState
    extends State<CategoryListWithSubCategoryGrid> {
  @override
  Widget build(BuildContext context) {
    final categoryListApiProvider =
        Provider.of<CategoryListApiProvider>(context);
    if (categoryListApiProvider.isLoading) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        primary: false,
        itemCount:
            categoryListApiProvider.categoryListData!.categoryList!.length,
        itemBuilder: (context, categoryIndex) =>
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Utils.getSizedBox(height: 20),
              Container(
                height: 50,
                color: Colors.black12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextWidget(
                      txt: categoryListApiProvider.categoryListData!
                          .categoryList![categoryIndex].categoryName,
                    ),
                    const Icon(
                      Icons.apps_outlined,
                      color: Colors.grey,
                      size: 40,
                    )
                  ],
                ),
              ),
              GridViewRecent(
                retailerID: widget.retailerID,
                categoryId: categoryListApiProvider
                    .categoryListData!.categoryList![categoryIndex].id,
              ),
            ]));
  }
}
