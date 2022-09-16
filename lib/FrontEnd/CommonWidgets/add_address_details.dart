import 'package:bigbaang/FrontEnd/CommonWidgets/loading_widget.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/service/api_service.dart';
import 'package:bigbaang/service/profile_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class AddressDetails extends StatefulWidget {
  final String address;
  final String lat;
  final String lng;
  const AddressDetails(
      {Key? key, required this.address, required this.lat, required this.lng})
      : super(key: key);

  @override
  State<AddressDetails> createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {


  final _formKey = GlobalKey<FormState>();

  final _landMarkKey = GlobalKey<FormState>();
  final landMarkController = TextEditingController();

  final _doorNoKey = GlobalKey<FormState>();
  final doorNoController = TextEditingController();

  String? typeId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 5),
              child: Text(
                'Enter address details',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 17.0),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your location".toUpperCase(),
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    Utils.getSizedBox(height: 10),
                    Utils.getSizedBox(height: 10),
                    SizedBox(height: 5,),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          widget.address,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        )),
                    Utils.getSizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Form(
                        key: _landMarkKey,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please insert correct value";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(
                                5), //  <- you can it to 0.0 for no space
                            isDense: true,
                            enabledBorder: const UnderlineInputBorder(
                                borderSide:  BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red[400]!)),
                            labelText: "Nearby landmark (Optional)",
                          ),
                          controller: landMarkController,
                        ),
                      ),
                    ),
                    Utils.getSizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Form(
                        key: _doorNoKey,
                        child: TextFormField(
// validator:
//     (value) {
//   if (value!
//       .isEmpty) {
//     return "Please insert correct value";
//   }
//   return null;
// },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(
                                5), //  <- you can it to 0.0 for no space
                            isDense: true,
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red[400]!)),
                            labelText: "Door No (Optional)",
                          ),
                          controller: doorNoController,
                        ),
                      ),
                    ),
                    Utils.getSizedBox(height: 10),
                    // FormBuilderChoiceChip(
                    //   selectedColor: Colors.greenAccent,
                    //   spacing: 10,
                    //   onChanged: (dynamic val) {
                    //     typeId = val;
                    //   },
                    //   validator: (val) {},
                    //   name: 'type',
                    //   decoration: const InputDecoration(
                    //     labelText: 'Tag this location for later (Mandatory)',
                    //   ),
                    //   options: [
                    //      ListFormBuilderFieldOption(
                    //         value: '1',
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(5.0),
                    //           child: const Text('Home'),
                    //         )),
                    //      FormBuilderFieldOption(
                    //         value: '2',
                    //         child: Padding(
                    //           padding: EdgeInsets.all(5.0),
                    //           child: Text('Work'),
                    //         )),
                    //     FormBuilderFieldOption(
                    //         value: '3',
                    //         child: const Padding(
                    //           padding: EdgeInsets.all(5.0),
                    //           child: Text('Other'),
                    //         )),
                    //   ],
                    // ),
                    GestureDetector(
                      onTap: () async {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate() &&
                            typeId != null) {
                          showLoading(context);
                          var result = await apiServices.addEditAddress(
                              userId: "${ApiService.userID}",
                              type: typeId.toString(),
                              address: widget.address,
                              land_mark: landMarkController.text,
                              lat: widget.lat,
                              long: widget.lng);
                          if (result == "1") {
                            context.read<ProfileApiProvder>().fetchProfileDetails();

                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop("success");
                          } else {
                            context.read<ProfileApiProvder>().fetchProfileDetails();

                            Utils.getFloatingSnackBar(
                                context: context,
                                snackBarText: "Opps!! Something went wrong");
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.yellow[900]),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                              child: const Text(
                            "Save Address",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
