import 'package:bigbaang/FrontEnd/CommonWidgets/cached_network_image.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/all_product_view.dart';
import 'package:bigbaang/Models/category_model.dart';
import 'package:bigbaang/Models/sub_category_model.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:bigbaang/service/category_list_api_provider.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expandable/expandable.dart';

class VerticalCategoryList extends StatefulWidget {
  const VerticalCategoryList({Key? key}) : super(key: key);

  @override
  State<VerticalCategoryList> createState() => _VerticalCategoryListState();
}

class _VerticalCategoryListState extends State<VerticalCategoryList> {
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();

  ApiService apiService = ApiService();
  bool isLoading = true;

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  Future getCategoryList() async {
    if (context.read<CategoryListApiProvider>().categoryListData == null) {
      await context.read<CategoryListApiProvider>().getCategoryListData;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryListProvider = Provider.of<CategoryListApiProvider>(context);

    // final List<GlobalKey<ExpansionTileCardState>> _list = List.generate(
    //     _categories1.length, (index) => GlobalKey<ExpansionTileCardState>());

    // final List<bool> _expansionTile =
    //     List.generate(categoryListProvider.length, (index) => false);

    return categoryListProvider.isLoading
        ? loadingWidget()
        : ListView.builder(
            padding: const EdgeInsets.all(0),
            scrollDirection: Axis.vertical,
            itemCount:
                categoryListProvider.categoryListData!.categoryList!.length - 1,
            shrinkWrap: true,
            primary: false,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemBuilder: (context, index) {
              return CategoryWidget(
                retailerID: "",
                categoryList:
                    categoryListProvider.categoryListData!.categoryList![index],
                imageBaseUrl:
                    categoryListProvider.categoryListData!.categoryBaseurl,
              );
            });
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

class CategoryWidget extends StatefulWidget {
  const CategoryWidget(
      {Key? key, required this.categoryList, required this.imageBaseUrl,
      required this.retailerID
      })
      : super(key: key);
  final CategoryList categoryList;
  final String imageBaseUrl;
  final String retailerID;
  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget>
    with TickerProviderStateMixin {
  bool value = false;

  late ExpandableController _controller;

  bool _isLoading = true;
  SubCategoryModel? _subCategoryModel;

  @override
  void initState() {
    super.initState();

    _controller = ExpandableController();

    getData();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future getData() async {
    await apiServices.getSubCategory(widget.categoryList.id,widget.retailerID).then((value) {
      setState(() {
        _subCategoryModel = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Category Widget Call");
    return ExpandablePanel(
        controller: _controller,
        header: Row(
          children: [
            Utils.getSizedBox(width: 3),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                shadowColor: Colors.lightBlue,
                child: cachedNetworkImage(50, 70,
                    widget.imageBaseUrl + widget.categoryList.categoryImg),
              ),
            ),
            Utils.getSizedBox(width: 15),
            Text(
              widget.categoryList.categoryName,
              style: CommonStyles.blueBold(),
            ),
          ],
        ),

        // ListTile(

        //   title: Text(
        //     widget.categoryList.categoryName,
        //     style: CommonStyles.blackText12BoldW400(),
        //   ),
        //   leading: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: cachedNetworkImage(
        //         50, 50, widget.imageBaseUrl + widget.categoryList.categoryImg),
        //   ),
        // ),
        collapsed: Container(), // ListTile(
        expanded: _isLoading
            ? Utils.loadingWidget()
            : ListView.builder(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: _subCategoryModel!.subcategoryList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return getList(
                    retailerID: widget.retailerID,
                      subCategoryList: _subCategoryModel!.subcategoryList!,
                      index: index,
                      imageUrl: _subCategoryModel!.subcategoryBaseurl!,
                      context: context);
                },
              ));
  }
}

Widget getList(
    {required List<SubcategoryList> subCategoryList,
    required int index,
    required String imageUrl,
    required BuildContext context,
    required retailerID
    }) {
  return SizedBox(
    height: 80,
    child: Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AllProductViewPage(
                      subCategoryId: subCategoryList[index].id,
                      subCategoryName: subCategoryList[index].subcategoryName,
                      subCategoryList: subCategoryList,
                    retailerID: retailerID,


                  )));
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => SubCategoryGridViewPage(
              //         categoryList: categoryListAPIProvider
              //             .categoryListData!.categoryList![index])));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Utils.getSizedBox(width: 20),
                Card(
                  elevation: 10,
                  child: cachedNetworkImage(50, 80,
                      imageUrl + subCategoryList[index].subcategoryImage),
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 15, top: 12),
                    child: Center(
                      child: Text(
                        subCategoryList[index].subcategoryName,
                        style: CommonStyles.blueBold14(),
                      ),
                    )),
              ],
            ),
          ),
          subCategoryList.length - 1 != index
              ? const Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Divider(
                    indent: 20,
                    color: Colors.black54,
                  ),
                )
              : const SizedBox()
        ],
      ),
    ),
  );
}
