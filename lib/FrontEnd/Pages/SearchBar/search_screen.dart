import 'package:avatar_glow/avatar_glow.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/widgets/search_delgate.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0,
        title: Text(
          "Search".toUpperCase(),
          style: CommonStyles.whiteText15BoldW500(),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: SizedBox(
          height: 70,
          child: InkWell(
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              var value =
                  await showSearch(context: context, delegate: DataSearch());
            },
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Search For Product",
                        style: CommonStyles.blueBold12()),
                    Row(
                      children: [
                        AvatarGlow(
                          endRadius: 20,
                          glowColor: Colors.lightBlue,
                          child: Icon(
                            Icons.mic,
                            size: 20,
                            color: Colors.indigo,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.indigo,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
