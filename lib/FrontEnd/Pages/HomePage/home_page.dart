import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/drawer_widget.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/horizontal_list_recently_searched.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/styles/home_page_styles.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/widgets/app_bar_and_search.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/widgets/banner_drawers.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/widgets/grid_view_recent_added.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/horizontal_list_top_offers.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/widgets/horizontal_category.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/widgets/horizontal_restaruant.dart';
import 'package:bigbaang/service/category_list_api_provider.dart';
import 'package:bigbaang/service/recently_searched_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() async {
    if (context.read<RecentlySearchedAPIProvider>().recentlySearchedModel ==
        null) {
      await context
          .read<RecentlySearchedAPIProvider>()
          .recentlySearchedProducts;
    }
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 124,
        flexibleSpace: FlexibleSpaceBar(
          background: CustomAppBarWithSearch(scaffoldKey: scaffoldKey),
        ),
      ),
      drawer: drawer(context, scaffoldKey),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomAppBarWithSearch(scaffoldKey: scaffoldKey),

          const CarouselBanner(),

          //  const OfferBannerList(),
          const SizedBox(
            height: 10,
          ),

          // Gerocery

          Neumorphic(
            style: NeumorphicStyle(
                color: Colors.indigo,
                shadowLightColorEmboss: Colors.red,
                intensity: 10,
                surfaceIntensity: 0),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Grocery Stores".toUpperCase(),
                  style: CommonStyles.whiteText15BoldW500(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          const RestaruantHorizontalHomePage(),
          SizedBox(
            height: 15,
          ),
          // Meat Shop

          Neumorphic(
            style: NeumorphicStyle(
                color: Colors.indigo,
                shadowLightColorEmboss: Colors.red,
                intensity: 10,
                surfaceIntensity: 0),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Meat Stores".toUpperCase(),
                  style: CommonStyles.whiteText15BoldW500(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          const MeatShopHomePage(),
          SizedBox(
            height: 15,
          ),

          // Veg Shop

          Neumorphic(
            style: NeumorphicStyle(
                color: Colors.indigo,
                shadowLightColorEmboss: Colors.red,
                intensity: 10,
                surfaceIntensity: 0),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Veg Stores".toUpperCase(),
                  style: CommonStyles.whiteText15BoldW500(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          const VegShopHomePage(),
          SizedBox(
            height: 15,
          ),

          // Other Shop

          Neumorphic(
            style: NeumorphicStyle(
                color: Colors.indigo,
                shadowLightColorEmboss: Colors.red,
                intensity: 10,
                surfaceIntensity: 0),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Other Stores".toUpperCase(),
                  style: CommonStyles.whiteText15BoldW500(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          const OtherShopHomePage(),

          // const CategoryHorizontalHomePage(),

          const SizedBox(
            height: 30,
          ),

          headerTextAndTextButton(
              typeText: "Top Offers",
              widget: const HorizontalListTopOffers(),
              screenHeight: 380,
              top: 4,
              context: context,
              right: 0,
              bottom: 20,
              left: 0),
          const SizedBox(
            height: 35,
          ),

          headerTextAndTextButton(
              typeText: "Popular Porducts",
              widget: const HorizontalListRecentlySearched(),
              screenHeight: 380,
              top: 4,
              context: context,
              right: 0,
              bottom: 20,
              left: 0),

          const SizedBox(
            height: 15,
          ),
          // listViewCategoryWithSubGrid(categoryListAPIProvider)
          // const CategoryListWithSubCategoryGrid()
        ],
      ),
    );
  }

  Widget listViewCategoryWithSubGrid() {
    final categoryListAPIProvider =
        Provider.of<CategoryListApiProvider>(context);
    return categoryListAPIProvider.isLoading
        ? const SizedBox(
            height: 200,
            child: Center(
              child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            primary: false,
            itemCount:
                categoryListAPIProvider.categoryListData!.categoryList!.length,
            itemBuilder: (context, categoryIndex) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Utils.getSizedBox(height: 20),
                Container(
                  height: 50,
                  color: Colors.black12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        txt: categoryListAPIProvider.categoryListData!
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
                categoryListAPIProvider.isLoading
                    ? const SizedBox(
                        height: 200,
                        child: Center(
                          child: SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    : GridViewRecent(
                  retailerID: "",
                        categoryId: categoryListAPIProvider
                            .categoryListData!.categoryList![categoryIndex].id,
                      ),
                Utils.getSizedBox(height: 20),
              ],
            ),
          );
  }

  Widget headerTextAndTextButton(
      {required String typeText,
      required Widget widget,
      required double screenHeight,
      required double top,
      required double bottom,
      required double left,
      required double right,
      required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: left, right: right, top: top, bottom: bottom),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Neumorphic(
                  style: NeumorphicStyle(
                      color: Colors.indigo,
                      shadowLightColorEmboss: Colors.red,
                      intensity: 10,
                      surfaceIntensity: 0),
                  child: Center(
                    child: Text(
                      typeText.toUpperCase(),
                      style: CommonStyles.whiteText15BoldW500(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight, child: widget)
      ],
    );
  }

  Widget headerTextWithWidget(
      {required String typeText,
      required Widget widget,
      required double screenHeight,
      required double top,
      required double bottom,
      required double left,
      required double right,
      required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: left, right: right, top: top, bottom: bottom),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 8),
            child: Row(
              children: [
                Text(
                  typeText,
                  style: HomePageStyles.normalTextMetaData(),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: screenHeight, child: widget)
      ],
    );
  }
}

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({Key? key, required this.txt}) : super(key: key);

  final String txt;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        txt,
        style: CommonStyles.submitTextStyle(),
      ),
    );
  }
}

class AllCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
