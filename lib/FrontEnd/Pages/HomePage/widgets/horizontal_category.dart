import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../../../../service/category_list_api_provider.dart';
import '../../../CommonWidgets/cached_network_image.dart';
import '../../../CommonWidgets/common_styles.dart';
import '../../../CommonWidgets/utils.dart';
import '../../CategoryPage/category_page.dart';
import 'sub_category_page.dart';
import '../styles/home_page_styles.dart';

class CategoryHorizontalHomePage extends StatefulWidget {
  final String retailerID;

  const CategoryHorizontalHomePage({Key? key,required this.retailerID}) : super(key: key);

  @override
  _CategoryHorizontalHomePageState createState() =>
      _CategoryHorizontalHomePageState();
}

class _CategoryHorizontalHomePageState
    extends State<CategoryHorizontalHomePage> {
  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    if (context.read<CategoryListApiProvider>().categoryListData == null) {
      await context.read<CategoryListApiProvider>().getCategoryListData;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryListAPIProvider =
        Provider.of<CategoryListApiProvider>(context);
    return categoryListAPIProvider.isLoading
        ? const SizedBox(
            height: 120,
            child: Center(
              child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              ),
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 15,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 8),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        color: Colors.indigo,
                        shadowLightColorEmboss: Colors.red,
                        intensity: 10,
                        surfaceIntensity: 0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Category".toUpperCase(),
                            style: CommonStyles.whiteText15BoldW500(),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CategoryPage()));
                            },
                            child: Row(
                              children: [
                                Text(
                                  "See All",
                                  style: HomePageStyles.whiteText15BoldW500(),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 160),
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: categoryListAPIProvider
                      .categoryListData!.categoryList!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 10,
                      shadowColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SubCategoryGridViewPage(
                                retailerID: widget.retailerID.toString(),
                                  categoryList: categoryListAPIProvider
                                      .categoryListData!
                                      .categoryList![index])));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: cachedNetworkImage(
                                  100,
                                  130,
                                  categoryListAPIProvider
                                          .categoryListData!.categoryBaseurl +
                                      categoryListAPIProvider.categoryListData!
                                          .categoryList![index].categoryImg,
                                ),
                              ),
                              Utils.getSizedBox(height: 10),
                              Expanded(
                                child: Text(
                                  categoryListAPIProvider.categoryListData!
                                      .categoryList![index].categoryName,
                                  textAlign: TextAlign.center,
                                  style: CommonStyles.blueBold12(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          );
  }
}
