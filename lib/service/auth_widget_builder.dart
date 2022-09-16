// import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
// import 'package:bigbaang/service/login_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:loading_animations/loading_animations.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// class AuthWidgetBuilder extends StatelessWidget {
//   const AuthWidgetBuilder({Key? key, required this.builder}) : super(key: key);
//   final Widget Function(BuildContext context, bool isLoggedIn) builder;

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<SharedPreferencesProvider>(context);
//     if (provider.status == SharedPreferencesInitializationStatus.initialized) {
//       return builder(context, provider.isUserLoggedIn);
//     }
//     // return builder(context, provider.isUserLoggedIn, provider.viewedSplashPage);

//     return Container(
//       color: Colors.white,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(
//             strokeWidth: 1,
//             color: Colors.black,
//             backgroundColor: Colors.brown[200],
//           ),
//           Utils.getSizedBox(height: 15),
//           Text(
//             "Initializing",
//             textDirection: TextDirection.ltr,
//             style: GoogleFonts.montserrat(
//                 textStyle: TextStyle(
//               color: Colors.yellow[900],
//               backgroundColor: Colors.transparent,
//               fontSize: 14,
//               letterSpacing: 0.3,
//               fontWeight: FontWeight.w400,
//             )),
//           )
//         ],
//       ),
//     );
//   }

//   initializeSharedPreference() async {
//     await SharedPreferences.getInstance();
//   }
// }
