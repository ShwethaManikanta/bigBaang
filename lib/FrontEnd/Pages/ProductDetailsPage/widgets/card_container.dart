import 'package:bigbaang/FrontEnd/CommonWidgets/cached_network_image.dart';
import 'package:bigbaang/FrontEnd/Pages/ProductDetailsPage/provider/carousel_controller_provider.dart';
import 'package:flutter/material.dart';

Widget cardContainer(String item, BuildContext context,
    CarouselControllerProvider carouselControllerProvider) {
  return Transform.scale(
    scale: carouselControllerProvider.scale.isNaN
        ? 1
        : carouselControllerProvider.scale,
    child: Container(
      margin: const EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: cachedNetworkImage(
            250,
            MediaQuery.of(context).size.width * 0.75,
            item,
            opacity: (1 - carouselControllerProvider.shrinkOffset),
          )),
    ),
  );
}
