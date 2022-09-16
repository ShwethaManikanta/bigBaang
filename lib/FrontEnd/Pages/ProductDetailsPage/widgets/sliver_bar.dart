import 'package:flutter/material.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double maxExtentHeight;
  final double minExtentHeight;

  final Widget Function(BuildContext, double, bool) builder;

  MySliverAppBar(
      {required this.maxExtentHeight,
      required this.minExtentHeight,
      required this.builder});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // final viewParlourProvider =
    //     Provider.of<ViewParlourDetailsProvider>(context, listen: false);
    // viewParlourProvider.imageOpacity(shrinkOffset, maxExtent);
    // viewParlourProvider.imageScale(shrinkOffset, maxExtent);

    return builder(context, shrinkOffset, overlapsContent);
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => maxExtentHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => minExtentHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}

// class ParlourServiceSliverPersistent extends SliverPersistentHeaderDelegate {
//   final double maxExtentHeight;
//   final double minExtentHeight;

//   final Widget widget;

//   ParlourServiceSliverPersistent(
//       {@required this.maxExtentHeight,
//       @required this.minExtentHeight,
//       @required this.widget});

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return widget;
//   }

//   @override
//   // TODO: implement maxExtent
//   double get maxExtent => maxExtentHeight;

//   @override
//   // TODO: implement minExtent
//   double get minExtent => maxExtentHeight;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     // TODO: implement shouldRebuild
//     return true;
//   }
// }
