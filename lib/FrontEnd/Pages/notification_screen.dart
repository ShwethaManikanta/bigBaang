import 'package:bigbaang/FrontEnd/CommonWidgets/cached_network_image.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/Models/notifications_model.dart';
import 'package:bigbaang/service/notification_api_providers.dart';
import 'package:bigbaang/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    initializeNotification();
    _tabController = new TabController(vsync: this, length: 2);
  }

  initializeNotification() async {
    if (context.read<NotificationListAPIProvider>().notificationLists == null) {
      await context.read<NotificationListAPIProvider>().notificationList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: FlexibleSpaceBar(
          background: AppBarProductPage(
            scaffoldKey: scaffoldKey,
            appBartext: "Notification",
            noIcon: true,
          ),
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    final notificationListProvider =
        Provider.of<NotificationListAPIProvider>(context);
    return notificationListProvider.isLoading ||
            notificationListProvider.notificationLists == null
        ? Utils.loadingWidget()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return notificationCard(
                        notificationListProvider
                            .notificationLists!.notificationList![index],
                        notificationListProvider
                            .notificationLists!.notificationListUrl);
                  },
                  itemCount: notificationListProvider
                      .notificationLists!.notificationList!.length,
                ),
              ),
              // DefaultTabController(
              //     length: 2,
              //     initialIndex: 1,
              //     child: Column(
              //       children: [
              //         TabBar(
              //             indicatorColor: Colors.black,
              //             unselectedLabelColor: Colors.black,
              //             labelColor: Colors.deepPurple,
              //             controller: _tabController,
              //             isScrollable: true,
              //             tabs: [
              //               Tab(
              //                 text: 'Alert',
              //               ),
              //               Tab(
              //                 text: 'Notification',
              //               ),
              //             ]),
              //         Container(
              //           height: 500,
              //           child: TabBarView(
              //             controller: _tabController,
              //             children: [
              //               Container(
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     Image.asset("assets/images/alert.png"),
              //                     Utils.getSizedBox(height: 30),
              //                     Text("No Alerts to Show",
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold,
              //                             fontSize: 18)),
              //                     Utils.getSizedBox(height: 20),
              //                     Text("You don't hae any existing alerts !",
              //                         style: TextStyle(fontSize: 14)),
              //                   ],
              //                 ),
              //               ),
              //               Column(
              //                 children: [
              //                   Container(
              //                     padding: EdgeInsets.symmetric(
              //                         horizontal: 10, vertical: 20),
              //                     child: Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         Text("Buy 1 Get 1 Free store activated",
              //                             style: TextStyle(
              //                                 fontWeight: FontWeight.bold,
              //                                 fontSize: 16)),
              //                         Utils.getSizedBox(height: 10),
              //                         Text(
              //                             "* The tables below list all of our active offers. The first table lists our offers which are currently available for purchase. The second table lists those offers.",
              //                             style: TextStyle(fontSize: 14)),
              //                       ],
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     height: 180,
              //                     child: Image.asset(
              //                       "assets/images/offer2.png",
              //                       width: 1000,
              //                       fit: BoxFit.fitWidth,
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ],
              //           ),
              //         )
              //       ],
              //     ))
            ],
          );
  }

  notificationCard(NotificationList notificationList, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                notificationList.title,
                style: CommonStyles.blackText14BoldW500Color(),
              ),
            ),
            const Divider(
              height: 2,
              color: Colors.black45,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  notificationList.notifImage != null &&
                          notificationList.notifImage.isNotEmpty
                      ? cachedNetworkImage(
                          100, 100, imageUrl + notificationList.notifImage)
                      : Image.asset(
                          "assets/images/completed.jpg",
                          height: 80,
                          width: 80,
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      notificationList.body,
                      style: CommonStyles.blackText14BoldW500(),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
