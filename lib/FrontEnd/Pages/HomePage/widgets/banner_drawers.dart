import 'package:bigbaang/FrontEnd/CommonWidgets/cached_network_image.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/service/banner_api_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarouselBanner extends StatefulWidget {
  const CarouselBanner({Key? key}) : super(key: key);

  @override
  State<CarouselBanner> createState() => _CarouselBannerState();
}

class _CarouselBannerState extends State<CarouselBanner> {
  @override
  void initState() {
    super.initState();
    initializeBanners();
  }

  final CarouselController _carouselController = CarouselController();

  initializeBanners() async {
    if (context.read<BannerApiProvider>().bannerModel == null) {
      context.read<BannerApiProvider>().getBanners;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bannerApiProvider = Provider.of<BannerApiProvider>(context);
    return bannerApiProvider.isLoading
        ? SizedBox(
            height: 200,
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
          )
        : CarouselSlider.builder(
            carouselController: _carouselController,
            options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                height: 200.0,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                // aspectRatio: 2.0,
                initialPage: 0,
                autoPlay: true,
                reverse: false,
                enableInfiniteScroll: true,
                onPageChanged: (index, reason) {}),
            itemCount: bannerApiProvider.bannerModel!.topBanner!.length,
            itemBuilder: (context, itemIndex, realIndex) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: cachedNetworkImage(
                    300,
                    600,
                    bannerApiProvider.bannerModel!.imageBaseurl! +
                        bannerApiProvider
                            .bannerModel!.topBanner![itemIndex].bannerImage,
                    radius: 10),
              );
            },
          );
  }
}

class OfferBannerList extends StatefulWidget {
  const OfferBannerList({Key? key}) : super(key: key);

  @override
  State<OfferBannerList> createState() => _OfferBannerListState();
}

class _OfferBannerListState extends State<OfferBannerList> {
  @override
  void initState() {
    super.initState();
    initializeBanners();
  }

  final CarouselController _carouselController = CarouselController();

  initializeBanners() async {
    if (context.read<OfferBannerApiProvider>().bannerModel == null) {
      context.read<OfferBannerApiProvider>().getBanners;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bannerApiProvider = Provider.of<OfferBannerApiProvider>(context);
    return bannerApiProvider.isLoading
        ? SizedBox(
            height: 200,
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
          )
        : CarouselSlider.builder(
            carouselController: _carouselController,
            options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                height: 200.0,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                // aspectRatio: 2.0,
                initialPage: 0,
                autoPlay: true,
                reverse: false,
                enableInfiniteScroll: true,
                onPageChanged: (index, reason) {}),
            itemCount: bannerApiProvider.bannerModel!.topBanner!.length,
            itemBuilder: (context, itemIndex, realIndex) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: cachedNetworkImage(
                    300,
                    600,
                    bannerApiProvider.bannerModel!.imageBaseurl! +
                        bannerApiProvider
                            .bannerModel!.topBanner![itemIndex].bannerImage,
                    radius: 10),
              );
            },
          );
  }
}
