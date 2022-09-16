import 'package:bigbaang/FrontEnd/CommonWidgets/cached_network_image.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/styles/home_page_styles.dart';

import 'package:bigbaang/service/recently_searched_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HorizontalListRecentSearches extends StatelessWidget {
  const HorizontalListRecentSearches({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recentlySearchedAPIProvider =
        Provider.of<RecentlySearchedAPIProvider>(context);
    if (recentlySearchedAPIProvider.isLoading) {
      return SizedBox(
        height: 100,
        width: deviceWidth(context),
        child: const Center(
          child: SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                strokeWidth: 1,
              )),
        ),
      );
    }
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recentlySearchedAPIProvider
                    .recentlySearchedModel!.productDetails!.length >
                7
            ? 7
            : recentlySearchedAPIProvider
                .recentlySearchedModel!.productDetails!.length,
        itemBuilder: (context, index) {
          return CategoryWidget(
              imageUrl: recentlySearchedAPIProvider
                      .recentlySearchedModel!.productImageUrl! +
                  recentlySearchedAPIProvider.recentlySearchedModel!
                      .productDetails![index].productImage,
              labelText: recentlySearchedAPIProvider
                  .recentlySearchedModel!.productDetails![index].categoryName);
        });
  }
}

class CategoryWidget extends StatelessWidget {
  final String imageUrl;
  final String labelText;
  const CategoryWidget(
      {Key? key, required this.imageUrl, required this.labelText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Column(
        children: [
          cachedNetworkImage(60, 60, imageUrl, radius: 10),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Text(
              labelText,
              style: HomePageStyles.normalText(),
            ),
          )
        ],
      ),
    );
  }
}
