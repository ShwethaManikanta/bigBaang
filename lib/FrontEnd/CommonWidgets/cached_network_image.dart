import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Pages/profile_screen.dart';

class CachedNetworkImageSubCategoryViewHomePage extends StatelessWidget {
  const CachedNetworkImageSubCategoryViewHomePage(
      {Key? key,
      required this.height,
      required this.width,
      required this.imageUrl,
      this.radius = 0,
      this.opacity = 0})
      : super(key: key);
  final double height, opacity, width, radius;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        height: height,
        width: width,
        fit: BoxFit.cover,
        imageUrl: (imageUrl),
        placeholder: (context, string) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          );
        },
        imageBuilder: (context, imageProvider) => Container(
              // height: 100,
              // width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
                border: Border.all(color: Colors.white),
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(opacity), BlendMode.srcOver),
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ));
  }
}

class CachedNetworkImageProfilePicture extends StatelessWidget {
  const CachedNetworkImageProfilePicture(
      {Key? key,
      required this.height,
      required this.width,
      required this.imageUrl,
      this.opacity = 0})
      : super(key: key);
  final double height, opacity, width;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      fit: BoxFit.cover,
      imageUrl: (imageUrl),
      placeholder: (context, string) {
        return const SizedBox(
          height: 35,
          width: 35,
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(right: 3.0),
                child: Icon(
                  Icons.account_circle,
                  size: 27,
                  color: Colors.white,
                ),
              )),
        );
      },
      imageBuilder: (context, imageProvider) => Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProfileScreen()));
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white54),
              shape: BoxShape.circle,
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(opacity), BlendMode.srcOver),
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) {
        return Center(
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfileScreen()));
              },
              child: const SizedBox(
                height: 35,
                width: 35,
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(right: 3.0),
                      child: Icon(
                        Icons.account_circle,
                        size: 27,
                        color: Colors.white,
                      ),
                    )),
              )),
        );
      },
    );
  }
}

Widget cachedNetworkImage(double height, double width, String imageUrl,
    {double opacity = 0, double radius = 8}) {
  return CachedNetworkImage(
      height: height,
      width: width,
      fit: BoxFit.cover,
      imageUrl: (imageUrl),
      placeholder: (context, string) {
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 1,
          ),
        );
      },
      imageBuilder: (context, imageProvider) => Container(
            // height: 100,
            // width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              border: Border.all(color: Colors.white),
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(opacity), BlendMode.srcOver),
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ));
}

Widget circularCachedNetworkImage(
    {required double height,
    required double width,
    required String imageUrl,
    double opacity = 0}) {
  return CachedNetworkImage(
      height: height,
      width: width,
      fit: BoxFit.fill,
      imageUrl: (imageUrl),
      placeholder: (context, string) {
        return SizedBox(
          height: height,
          width: width,
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          ),
        );
      },
      imageBuilder: (context, imageProvider) => Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(opacity), BlendMode.srcOver),
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ));
}
