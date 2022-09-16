import 'package:bigbaang/FrontEnd/CommonWidgets/cached_network_image.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/Pages/ProductDetailsPage/product_details_page.dart';
import 'package:bigbaang/Models/product_detail_model.dart';
import 'package:bigbaang/Models/search_product_model.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

class DataSearch extends SearchDelegate<String> {
  TextEditingController? controller;

  DataSearch({
    this.controller,
  }) {
    initalizeMic();
  }
  initalizeMic() async {
    await Permission.microphone.request();
  }

  SpeechToText _speech = SpeechToText();
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  void _listen() async {
    print("Startd Listening ..........");
    if (!_isListening) {
      query = "";
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      print("Available ------------>>>>" + available.toString());
      if (available) {
        _isListening = true;
        _speech.listen(onResult: (val) {
          _text = val.recognizedWords;
          if (val.hasConfidenceRating && val.confidence > 0) {
            _confidence = val.confidence;
          }
          query = _text;

          print("Text from Speech ------>>>>>>>> " + _text);
        });
      }
    } else {
      _isListening = false;
      query = "";
      _speech.stop();
    }
  }

  // String recentProduct = controller1.text;

  @override
  List<Widget> buildActions(BuildContext context) {
    // Action For the method calling this class.
    return [
      Row(
        children: [
          InkWell(
            onTap: () {
              print("Listen ====");
              _listen();
              print("Listen ==END==");
            },
            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              query = "";
            },
          ),
        ],
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading Icon in the left side of the search text field
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, "");
        });
    // throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // result to be shown that maches according to the key user
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // final suggestionList = query.isEmpty
    //     ? []
    //     : productNameList
    //         .where((element) =>
    //             element.toUpperCase().startsWith(query.toUpperCase()))
    //         .toList();
    return Column(
      children: [
        if (query.length > 1)
          FutureBuilder<SearchProductModel?>(
              future: apiServices.getSearchResults(query),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ),
                  );
                }
                SearchProductModel? searchProductModel = snapshot.data;

                if (searchProductModel == null) {
                  return Center(
                    child: Text(
                      "Error while getting data form internet!!",
                      style: CommonStyles.blackText10BoldW500(),
                    ),
                  );
                } else if (searchProductModel.status == "0") {
                  return Center(
                    child: Text(
                      searchProductModel.message,
                      style: CommonStyles.blackText10BoldW500(),
                    ),
                  );
                }
                List<ProductDetails> _listSearchProductDetails =
                    searchProductModel.productDetails!;

                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                        onTap: () {
                          // int indexItem = 0;
                          // if (_listSearchProductDetails.isNotEmpty) {
                          //   controller.text =
                          //       _listSearchProductDetails[index].productName;
                          // } else {
                          //   controller.text = query;
                          // }
                          apiServices.addRecentlySearchedProducts(
                              productId: _listSearchProductDetails[index].id,
                              productName:
                                  _listSearchProductDetails[index].productName);

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductDetailsPage(
                                  // baseImageUrl:
                                  //     searchProductModel.productImageUrl!,
                                  productDetails:
                                      _listSearchProductDetails[index])));
                          // close(context, indexItem.toString());
                        },
                        leading: _listSearchProductDetails.isEmpty
                            ? const SizedBox(
                                height: 1,
                                width: 1,
                              )
                            : cachedNetworkImage(
                                50,
                                50,
                                searchProductModel.productImageUrl! +
                                    _listSearchProductDetails[index]
                                        .productImage),
                        // title: Text(suggestionList[index]),
                        title: _listSearchProductDetails.isEmpty
                            ? Text(query,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))
                            : RichText(
                                text: TextSpan(
                                    text: _listSearchProductDetails[index]
                                        .productName
                                        .substring(0, query.length),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                    TextSpan(
                                        text: _listSearchProductDetails[index]
                                            .productName
                                            .substring(query.length),
                                        style:
                                            const TextStyle(color: Colors.grey))
                                  ]))),
                    itemCount: _listSearchProductDetails.length,
                  ),
                );
              }),

        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Container(

        //   ),
        // )
        // }

        // else {
        //   return Center(
        //     child: Text(
        //       "Minimum 3 words required!!",
        //       style: CommonStyles.blackText10BoldW500(),
        //     ),
        //   );
        // }
      ],
    );

    // Show when user presses some search key.
  }
}
