import 'package:bigbaang/FrontEnd/Pages/RestaruantCategory/restaruant_category.dart';
import 'package:bigbaang/service/shop_list_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../service/category_list_api_provider.dart';
import '../../../CommonWidgets/cached_network_image.dart';
import '../../../CommonWidgets/common_styles.dart';
import '../../../CommonWidgets/utils.dart';

class RestaruantHorizontalHomePage extends StatefulWidget {
  const RestaruantHorizontalHomePage({Key? key}) : super(key: key);

  @override
  _RestaruantHorizontalHomePageState createState() =>
      _RestaruantHorizontalHomePageState();
}

class _RestaruantHorizontalHomePageState
    extends State<RestaruantHorizontalHomePage> {
  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    if (context.read<ShopListApiProvider>().shopListModel == null) {
      await context.read<ShopListApiProvider>().getShopListData;
    }
  }

  @override
  Widget build(BuildContext context) {
    final shopListAPIProvider = Provider.of<ShopListApiProvider>(context);
    return shopListAPIProvider.isLoading
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
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: shopListAPIProvider
                          .shopListModel!.retailerList!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 8.0),
                          child: Card(
                            shadowColor: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            //   color: Colors.lightBlue,
                            child: InkWell(
                              onTap: () {
                                print(
                                    "REtailer ID ============---------------${shopListAPIProvider.shopListModel!.retailerList![index].id}");
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => RestaruantCategory(
                                          baseURL:
                                              "${shopListAPIProvider.shopListModel!.vendorBaseurl}",
                                          imgURL:
                                              "${shopListAPIProvider.shopListModel!.retailerList![index].retailerImage}",
                                          retailerAddress:
                                              "${shopListAPIProvider.shopListModel!.retailerList![index].address}",
                                          retailerName:
                                              "${shopListAPIProvider.shopListModel!.retailerList![index].retailerName}",
                                          retailerID:
                                              "${shopListAPIProvider.shopListModel!.retailerList![index].id}",
                                        )));
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: cachedNetworkImage(
                                        100,
                                        150,
                                        "${shopListAPIProvider.shopListModel!.vendorBaseurl}"
                                        "${shopListAPIProvider.shopListModel!.retailerList![index].retailerImage}",
                                      ),
                                    ),
                                    Utils.getSizedBox(height: 10),
                                    Expanded(
                                      child: SizedBox(
                                        width: 150,
                                        child: Text(
                                          "${shopListAPIProvider.shopListModel!.retailerList![index].retailerName}"
                                              .toUpperCase(),
                                          style: CommonStyles.blueBold12(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }))
            ],
          );
  }
}

// Meat Shop

class MeatShopHomePage extends StatefulWidget {
  const MeatShopHomePage({Key? key}) : super(key: key);

  @override
  _MeatShopHomePageState createState() => _MeatShopHomePageState();
}

class _MeatShopHomePageState extends State<MeatShopHomePage> {
  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    if (context.read<MeatShopListApiProvider>().shopListModel == null) {
      await context.read<MeatShopListApiProvider>().getShopListData;
    }
  }

  @override
  Widget build(BuildContext context) {
    final shopListAPIProvider = Provider.of<MeatShopListApiProvider>(context);
    return shopListAPIProvider.isLoading
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
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: shopListAPIProvider
                          .shopListModel!.retailerList!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 8.0),
                          child: Card(
                            shadowColor: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            //   color: Colors.lightBlue,
                            child: InkWell(
                              onTap: () {
                                print(
                                    "REtailer ID ============---------------${shopListAPIProvider.shopListModel!.retailerList![index].id}");
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => RestaruantCategory(
                                          baseURL:
                                              "${shopListAPIProvider.shopListModel!.vendorBaseurl}",
                                          imgURL:
                                              "${shopListAPIProvider.shopListModel!.retailerList![index].retailerImage}",
                                          retailerAddress:
                                              "${shopListAPIProvider.shopListModel!.retailerList![index].address}",
                                          retailerName:
                                              "${shopListAPIProvider.shopListModel!.retailerList![index].retailerName}",
                                          retailerID:
                                              "${shopListAPIProvider.shopListModel!.retailerList![index].id}",
                                        )));
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: cachedNetworkImage(
                                        100,
                                        150,
                                        "${shopListAPIProvider.shopListModel!.vendorBaseurl}"
                                        "${shopListAPIProvider.shopListModel!.retailerList![index].retailerImage}",
                                      ),
                                    ),
                                    Utils.getSizedBox(height: 10),
                                    Expanded(
                                      child: SizedBox(
                                        width: 150,
                                        child: Text(
                                          "${shopListAPIProvider.shopListModel!.retailerList![index].retailerName}"
                                              .toUpperCase(),
                                          style: CommonStyles.blueBold12(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }))
            ],
          );
  }
}

// Veg Shop

class VegShopHomePage extends StatefulWidget {
  const VegShopHomePage({Key? key}) : super(key: key);

  @override
  _VegShopHomePageState createState() => _VegShopHomePageState();
}

class _VegShopHomePageState extends State<VegShopHomePage> {
  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    if (context.read<VegShopListApiProvider>().shopListModel == null) {
      await context.read<VegShopListApiProvider>().getShopListData;
    }
  }

  @override
  Widget build(BuildContext context) {
    final shopListAPIProvider = Provider.of<VegShopListApiProvider>(context);
    return shopListAPIProvider.isLoading
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
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: shopListAPIProvider
                          .shopListModel!.retailerList!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 8.0),
                          child: Card(
                            shadowColor: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            //   color: Colors.lightBlue,
                            child: InkWell(
                              onTap: () {
                                print(
                                    "REtailer ID ============---------------${shopListAPIProvider.shopListModel!.retailerList![index].id}");
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => RestaruantCategory(
                                          baseURL:
                                              "${shopListAPIProvider.shopListModel!.vendorBaseurl}",
                                          imgURL:
                                              "${shopListAPIProvider.shopListModel!.retailerList![index].retailerImage}",
                                          retailerAddress:
                                              "${shopListAPIProvider.shopListModel!.retailerList![index].address}",
                                          retailerName:
                                              "${shopListAPIProvider.shopListModel!.retailerList![index].retailerName}",
                                          retailerID:
                                              "${shopListAPIProvider.shopListModel!.retailerList![index].id}",
                                        )));
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: cachedNetworkImage(
                                        100,
                                        150,
                                        "${shopListAPIProvider.shopListModel!.vendorBaseurl}"
                                        "${shopListAPIProvider.shopListModel!.retailerList![index].retailerImage}",
                                      ),
                                    ),
                                    Utils.getSizedBox(height: 10),
                                    Expanded(
                                      child: SizedBox(
                                        width: 150,
                                        child: Text(
                                          "${shopListAPIProvider.shopListModel!.retailerList![index].retailerName}"
                                              .toUpperCase(),
                                          style: CommonStyles.blueBold12(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }))
            ],
          );
  }
}

// Others Shop

class OtherShopHomePage extends StatefulWidget {
  const OtherShopHomePage({Key? key}) : super(key: key);

  @override
  _OtherShopHomePageState createState() => _OtherShopHomePageState();
}

class _OtherShopHomePageState extends State<OtherShopHomePage> {
  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    if (context.read<OthersShopListApiProvider>().shopListModel == null) {
      await context.read<OthersShopListApiProvider>().getShopListData;
    }
  }

  @override
  Widget build(BuildContext context) {
    final shopListAPIProvider = Provider.of<OthersShopListApiProvider>(context);
    return shopListAPIProvider.isLoading
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
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: shopListAPIProvider
                          .shopListModel!.retailerList!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 8.0),
                          child: Card(
                            shadowColor: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            //   color: Colors.lightBlue,
                            child: InkWell(
                              onTap: () {
                                print(
                                    "REtailer ID ============---------------${shopListAPIProvider.shopListModel!.retailerList![index].id}");
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => RestaruantCategory(
                                          baseURL:
                                              "${shopListAPIProvider.shopListModel!.vendorBaseurl}",
                                          imgURL:
                                              "${shopListAPIProvider.shopListModel!.retailerList![index].retailerImage}",
                                          retailerAddress:
                                              "${shopListAPIProvider.shopListModel!.retailerList![index].address}",
                                          retailerName:
                                              "${shopListAPIProvider.shopListModel!.retailerList![index].retailerName}",
                                          retailerID:
                                              "${shopListAPIProvider.shopListModel!.retailerList![index].id}",
                                        )));
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: cachedNetworkImage(
                                        100,
                                        150,
                                        "${shopListAPIProvider.shopListModel!.vendorBaseurl}"
                                        "${shopListAPIProvider.shopListModel!.retailerList![index].retailerImage}",
                                      ),
                                    ),
                                    Utils.getSizedBox(height: 10),
                                    Expanded(
                                      child: SizedBox(
                                        width: 150,
                                        child: Text(
                                          "${shopListAPIProvider.shopListModel!.retailerList![index].retailerName}"
                                              .toUpperCase(),
                                          style: CommonStyles.blueBold12(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }))
            ],
          );
  }
}
