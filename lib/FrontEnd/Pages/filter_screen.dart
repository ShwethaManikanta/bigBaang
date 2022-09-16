import 'package:bigbaang/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  bool checkBox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: false,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        flexibleSpace: AppBarProductPage(
          scaffoldKey: scaffoldKey,
          appBartext: "Filter",
          // onlySearch: true,
          noIcon: true,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DefaultTabController(
                length: 2,
                initialIndex: 1,
                child: Column(
                  children: [
                    TabBar(
                        indicatorColor: Colors.black,
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.deepPurple,
                        controller: _tabController,
                        isScrollable: true,
                        tabs: const [
                          Tab(
                            text: 'Refine by',
                          ),
                          Tab(
                            text: 'Sort by',
                          ),
                        ]),
                    Container(
                      height: 1000,
                      child: TabBarView(controller: _tabController, children: [
                        Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                            _filterRefine.length,
                            (index) => ExpansionTile(
                              title: Text(_filterRefine[index].title),
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: List.generate(
                                      _filterRefine[index].refineBy.length,
                                      (index) {
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 13.0),
                                        child: ListTile(
                                          title: Text(
                                              "${_filterRefine[index].refineBy[index].title}"),
                                          trailing: Checkbox(
                                            onChanged: (v) {
                                              setState(() {
                                                checkBox = !checkBox;
                                              });
                                            },
                                            value: checkBox,
                                          ),
                                        ));
                                  }),
                                )
                              ],
                            ),
                          ),
                        )),
                        Container(
                          child: Column(
                            children: _group
                                .map((t) => ListTile(
                                      title: Text("${t.text}"),
                                      trailing: Radio(
                                        groupValue: _currVal,
                                        value: t.index,
                                        onChanged: (val) {
                                          setState(() {
                                            _currVal = t.index;
                                            _currText = t.text;
                                          });
                                        },
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  int _currVal = 1;
  String _currText = '';

  List<GroupModel> _group = [
    GroupModel(
      text: "Popularity",
      index: 1,
    ),
    GroupModel(
      text: "Price - Low to High",
      index: 2,
    ),
    GroupModel(
      text: "Price - High to Low",
      index: 3,
    ),
    GroupModel(
      text: "Alphabetical",
      index: 4,
    ),
    GroupModel(
      text: "Rupee Saving - High to Low",
      index: 5,
    ),
    GroupModel(
      text: "Rupee Saving - Low to High",
      index: 6,
    ),
    GroupModel(
      text: "% Off - High to Low",
      index: 7,
    ),
  ];

  int refineVal = 1;

  List<FilterRefine> _filterRefine = [
    FilterRefine(
        title: "Brand",
        index: 1,
        refineBy: [RefineBy(title: "Fresho", index: 1)]),
    FilterRefine(
      title: "Price",
      index: 2,
      refineBy: [
        RefineBy(title: "Rs 21 to Rs 50", index: 2),
        RefineBy(title: "More than Rs 501", index: 3)
      ],
    ),
    FilterRefine(title: "Discount", index: 3, refineBy: [
      RefineBy(title: "15% - 25%", index: 4),
      RefineBy(title: "More than 25%", index: 5)
    ]),
    FilterRefine(title: "Pack Size", index: 4, refineBy: [
      RefineBy(title: "250 g", index: 6),
      RefineBy(title: "500 g", index: 7)
    ]),
    FilterRefine(
        title: "Country of Origin",
        index: 5,
        refineBy: [RefineBy(title: "India", index: 8)]),
    FilterRefine(
        title: "Food Preference",
        index: 6,
        refineBy: [RefineBy(title: "Vegetarian", index: 9)])
  ];
}

class GroupModel {
  String text;
  int index;
  GroupModel({required this.text, required this.index});
}

class FilterRefine {
  String title;
  int index;
  List<RefineBy> refineBy = [];
  FilterRefine(
      {required this.title, required this.index, required this.refineBy});
}

class RefineBy {
  String title;
  int index;
  RefineBy({required this.title, required this.index});
}
