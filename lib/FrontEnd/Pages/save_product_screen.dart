import 'package:bigbaang/FrontEnd/Pages/Cart/widget/app_bar.dart';
import 'package:flutter/material.dart';

class SavedProductScreen extends StatefulWidget {
  const SavedProductScreen({Key? key}) : super(key: key);

  @override
  _SavedProductScreenState createState() => _SavedProductScreenState();
}

class _SavedProductScreenState extends State<SavedProductScreen> {
  @override
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: FlexibleSpaceBar(
          background: CustomAppBar(
            back: true,
            scaffoldKey: scaffoldKey,
          ),
        ),
      ),
      key: scaffoldKey,
      backgroundColor: Colors.grey.shade100,
      body: Container(
        height: 400,
        color: Colors.blue,
      ),
    );
  }
}
