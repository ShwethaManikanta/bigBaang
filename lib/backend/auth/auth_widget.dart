import 'package:bigbaang/FrontEnd/Pages/LoginPage/phoneVerification/phone_verification.dart';
import 'package:flutter/material.dart';
import '../../FrontEnd/CommonWidgets/common_styles.dart';
import '../../main.dart';
import '../service/firebase_auth_service.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({
    Key? key,
    required this.userSnapshot,
  }) : super(key: key);
  final AsyncSnapshot<LoggedInUser?> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData
          ? const GetLoginUser()
          : const PhoneVerification();
    }
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              strokeWidth: 1,
              color: Colors.blue,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                "Authenticating",
                style: CommonStyles.blueBold12(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class CheckForDatabase extends StatelessWidget {
//   const CheckForDatabase({Key? key}) : super(key: key);

//   // final Widget Function(BuildContext context, AsyncSnapshot<ParlourDetails>)
//   //     builder;
//   // CheckForDatabaseBuilder({Key key, @required this.builder}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final firestoreDatabase =
//         Provider.of<DatabaseService>(context, listen: false);
//     return Scaffold(
//       body: FutureBuilder<ProfileDetails?>(
//         future: firestoreDatabase.getIfDatabaseExistAndShowDetails(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(
//                     strokeWidth: 1,
//                     backgroundColor: Colors.brown[400],
//                   ),
//                 ],
//               ),
//             );
//           }
//           if (snapshot.hasData) {
//             return const HomePage();
//           } else {
//             return DetailInput();
//           }
//         },
//       ),
//     );
//   }
// }
