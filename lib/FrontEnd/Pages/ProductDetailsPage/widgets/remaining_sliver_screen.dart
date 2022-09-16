import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/horizontal_list_top_offers.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/ProductDetailsPage/provider/carousel_controller_provider.dart';
import 'package:bigbaang/FrontEnd/Pages/ProductDetailsPage/styles/product_details_style.dart';
import 'package:bigbaang/Models/product_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class RemainingSliverScreen extends StatefulWidget {
  final ProductDetails productModel;
  const RemainingSliverScreen({Key? key, required this.productModel})
      : super(key: key);

  @override
  State<RemainingSliverScreen> createState() => _RemainingSliverScreenState();
}

class _RemainingSliverScreenState extends State<RemainingSliverScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.delivery_dining_outlined,
                color: Colors.brown[800],
              ),
              Utils.getSizedBox(width: 8),
              Text(
                "Delivers in 4 hrs",
                style: ProductDetailsStyle.textWhiteDelivery(),
              )
            ],
          ),
          pageDivider(),
          aboutProduct(context),
          pageDivider(),
          Utils.getSizedBox(height: 20),

          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Top Offers",
              style: CommonStyles.blackText14BoldW500(),
            ),
          ),
          Utils.getSizedBox(height: 20),
          const HorizontalListTopOffers(),
          // const FrequentlyBoughtTogether(),
          Utils.getSizedBox(height: 30),

          Text(
            "End Of Page",
            style: CommonStyles.blackText14BoldW500Color(),
          ),
          Utils.getSizedBox(height: 20),

          // pageDivider(),

          // SuggestionScreen(),
          // pageDivider(),
          // Column(
          //   children: List.generate(2, (index) {
          //     return Column(
          //       children: [
          //         Container(
          //           // height: 80,
          //           padding:
          //               EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          //           child: Row(
          //             children: [
          //               Expanded(
          //                   flex: 2,
          //                   child: Image.asset("assets/images/tomato.jpg")),
          //               Expanded(
          //                 flex: 6,
          //                 child: Text(
          //                   "VIEW MORE PRODUCTS FROM POTATO ONION & TOMATO",
          //                   style: TextStyle(fontSize: 16),
          //                 ),
          //               ),
          //               Container(
          //                 height: 75,
          //                 width: 2,
          //                 color: Colors.black,
          //               ),
          //               Expanded(
          //                 flex: 1,
          //                 child: Icon(Icons.chevron_right_sharp),
          //               )
          //             ],
          //           ),
          //         ),
          //         pageDivider()
          //       ],
          //     );
          //   }),
          // ),
        ],
      ),
    );
  }

  pageDivider() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Divider(
        // color: Colors.brown[400],
        color: Colors.brown[50],
        thickness: 16,
      ),
    );
  }

  thinPageDivider() {
    return Divider(
      // color: Colors.brown[400],
      color: Colors.brown[50],
      thickness: 1,
    );
  }

  Widget aboutProduct(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 10),
          child: Text(
            "About this Product",
            style: ProductDetailsStyle.aboutProductPageStyle(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              getTextMetaData(
                  "Description", widget.productModel.description, context),
              // getTextMetaData("Description", widget.productModel.description,
              //     context, genearlProvider),
              // getTextMetaData(
              //     "Storage and Uses",
              //     "asdfasdalkjsdfjlsdjfjasdfjlasjdfljas a quick brown fux jumps over the lazy dog a quick brown fox jumps over the lazy dog",
              //     context,
              //     genearlProvider),
              // getTextMetaData(
              //     "Other Product Info",
              //     "asdfasdalkjsdfjlsdjfjasdfjlasjdfljas a quick brown fux jumps over the lazy dog a quick brown fox jumps over the lazy dog asdfasdalkjsdfjlsdjfjasdfjlasjdfljas a quick brown fux jumps over the lazy dog a quick brown fox jumps over the lazy dog",
              //     context,
              //     genearlProvider)
            ],
          ),
        )
      ],
    );
  }

  getTextMetaData(
      String textMetaData, String expandableText, BuildContext context) {
    return Stack(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // thinPageDivider(),
        SizedBox(
          width: deviceWidth(context) * 0.95,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textMetaData,
                  style: ProductDetailsStyle.aboutProductPageStyleSmallSilver(),
                ),
                Utils.getSizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: ExpandableText(expandableText),
                ),
                thinPageDivider(),
              ],
            ),
          ),
        ),
        /*   Align(
          alignment: Alignment.topRight,
          child: Column(
            children: [
              SizedBox(
                height: 25,
                width: 25,
                child: !genearlProvider.isExpanded
                    ? IconButton(
                        icon: const Icon(FontAwesomeIcons.plus, size: 18),
                        onPressed: () {
                          // setState(() => widget.isExpanded = true);
                          genearlProvider.isExpanded = true;
                        },
                      )
                    : IconButton(
                        icon: const Icon(FontAwesomeIcons.minus, size: 18),
                        onPressed: () {
                          genearlProvider.isExpanded = false;
                          // setState(() => widget.isExpanded = false);
                        },
                      ),
              ),
              */ /* Utils.getSizedBox(height: 14, width: 0),
              genearlProvider.isExpanded
                  ? ConstrainedBox(constraints: const BoxConstraints())
                  : MaterialButton(
                      child: Text(
                        'View More',
                        style: ProductDetailsStyle.normalTextBlueColor(),
                      ),
                      onPressed: () => genearlProvider.isExpanded = true),*/ /*
            ],
          ),
        ),*/

        // Align(
        //   alignment: Alignment.topRight,
        //   child: !genearlProvider.isExpanded
        //       ? IconButton(
        //           icon: const Icon(FontAwesomeIcons.plus, size: 18),
        //           onPressed: () {
        //             // setState(() => widget.isExpanded = true);
        //             genearlProvider.isExpanded = true;
        //           },
        //         )
        //       : IconButton(
        //           icon: const Icon(FontAwesomeIcons.minus, size: 18),
        //           onPressed: () {
        //             genearlProvider.isExpanded = false;
        //             // setState(() => widget.isExpanded = false);
        //           },
        //         ),
        // ),
        // Container(
        //   height: 100,
        //   child: Align(
        //     alignment: Alignment.bottomRight,
        //     child: genearlProvider.isExpanded
        //         ? ConstrainedBox(constraints: const BoxConstraints())
        //         : MaterialButton(
        //             child: Text(
        //               'View More',
        //               style: ProductDetailsStyle.normalTextBlueColor(),
        //             ),
        //             onPressed: () => genearlProvider.isExpanded = true),
        //   ),
        // )
      ],
    );
  }
}

class Bullet extends Text {
  const Bullet(
    String data, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
  }) : super(
          '• ${data}',
          key: key,
          style: style,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
        );
}

// ignore: must_be_immutable
class ExpandableText extends StatefulWidget {
  ExpandableText(this.text, {Key? key}) : super(key: key);

  final String text;
  bool isExpanded = false;

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ReadMoreText(
        "• ${widget.text}",
        trimLines: 2,
        style: CommonStyles.blackText12BoldW400(),
        trimMode: TrimMode.Line,
        trimCollapsedText: 'View More',
        trimExpandedText: 'View Less',
      ),
    ]);
  }
}
