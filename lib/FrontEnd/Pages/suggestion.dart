import 'package:flutter/material.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({Key? key}) : super(key: key);

  @override
  _SuggestionScreenState createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      height: 355,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "You may like to view more in",
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 10,
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Recipes",
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Have a look at what you can make with this item",
              style: TextStyle(fontSize: 14),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return listViewSuggestionItem(index);
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            height: 1,
            thickness: 2,
            color: Colors.black12,
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "VIEW ALL RECIPES",
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.chevron_right_sharp,
                  size: 25,
                  color: Colors.red,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  listViewSuggestionItem(int index) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              height: 100,
              width: 160,
              child: Image.asset("assets/images/litti.jpg"),
            ),
            Text(
              "Litti Chokha",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        Positioned(
            left: 140,
            top: 0,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.orangeAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "40",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Mins",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ))
      ],
    );
  }
}
