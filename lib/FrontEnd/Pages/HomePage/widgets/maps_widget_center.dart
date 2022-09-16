import 'dart:async';
import 'package:bigbaang/FrontEnd/CommonWidgets/add_address_details.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/service/profile_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../Models/cart_address.dart';
import '../../../../service/api_service.dart';

class PlacePickGoogleMaps extends StatefulWidget {
  const PlacePickGoogleMaps({Key? key}) : super(key: key);

  @override
  _PlacePickGoogleMapsState createState() => _PlacePickGoogleMapsState();
}

class _PlacePickGoogleMapsState extends State<PlacePickGoogleMaps> {
  Location location = Location();

  TextEditingController controllerAddress = TextEditingController();

  late LatLng latLngCamera;

  final Completer<GoogleMapController> _controller = Completer();

  late GoogleMapController mapController;

  bool _latLongCameraInitialized = true;

  @override
  void initState() {
    print("Init state pronted");
    print(
        " -------lat----- ${(context.read<ProfileApiProvder>().profileModel!.userDetails!.latitude)}");
    print(
        " -----long------- ${(context.read<ProfileApiProvder>().profileModel!.userDetails!.longitude)}");
    super.initState();
    if (context.read<ProfileApiProvder>().profileModel!.userDetails!.latitude !=
            "" ||
        context
                .read<ProfileApiProvder>()
                .profileModel!
                .userDetails!
                .longitude !=
            "") {
      latLngCamera = LatLng(
          double.parse(context
              .read<ProfileApiProvder>()
              .profileModel!
              .userDetails!
              .latitude),
          double.parse(context
              .read<ProfileApiProvder>()
              .profileModel!
              .userDetails!
              .longitude));
      print(latLngCamera.latitude.toString() +
          "Lat long camera" +
          latLngCamera.longitude.toString());
      context.read<ProfileApiProvder>().profileModel!.userDetails!.latitude;
    } else {
      //get current location
      // show loading while location is being fetched
      // once fetched show google maps with initila login as current location latitide and logitude
      getLocation();
      initializeInitialLocation();
      initializeMaps();
    }
  }

  Future<void> initializeMaps() async {
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
      }
    }
  }

  initializeInitialLocation() async {
    if (context.read<ProfileApiProvder>().profileModel == null) {
      await context.read<ProfileApiProvder>().fetchProfileDetails();
    }
  }

  bool locationProvided = false;
  late PermissionStatus _permissionGranted;
  late bool _serviceEnabled;

  getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData _locationData = await location.getLocation();
    print(_locationData.latitude!.toString() +
        "-----------------" +
        _locationData.longitude!.toString());
    latLngCamera = LatLng(_locationData.latitude!, _locationData.longitude!);
    print("${latLngCamera.toString()} ------------------- LAT LNG");
    setState(() {
      _latLongCameraInitialized = false;
    });
    print(latLngCamera);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _latLongCameraInitialized
          ? Utils.loadingWidget()
          : Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                SizedBox(
                  height: deviceHeight(context),
                  width: deviceWidth(context),
                  child: GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    // padding: const EdgeInsets.only(top: 180),
                    rotateGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                            latLngCamera.latitude, latLngCamera.longitude),
                        zoom: 19),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      mapController = controller;
                    },
                    onCameraMove: (value) {
                      setState(() {
                        latLngCamera = value.target;
                      });
                    },
                  ),
                ),
                Positioned(
                  top: (deviceHeight(context) - 25) / 2,
                  right: (deviceWidth(context) - 25) / 2,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      FontAwesomeIcons.mapPin,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ),
                Positioned(
                    top: 50.0,
                    right: 15.0,
                    left: 15.0,
                    child: ReverseGeoCodingTextFormField(
                      latitude: latLngCamera.latitude,
                      longitude: latLngCamera.longitude,
                      controllerAddress: controllerAddress,
                    ))
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: /*_latLongCameraInitialized
          ? Utils.loadingWidget()
          :*/
          FloatingActionButton.extended(
        isExtended: true,
        onPressed: () async {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return AddressDetails(
                  lat: latLngCamera.latitude.toString(),
                  lng: latLngCamera.longitude.toString(),
                  address: controllerAddress.text,
                );
              });
          // Navigator.of(context).pop(EditCartAddressRequestModel(
          //
          //     userId: ApiService.userID!,
          //     door_no: ,
          //
          //     address: controllerAddress.text,
          //     lat:  latLngCamera.latitude.toString(),
          //     long:  latLngCamera.longitude.toString()));
          // setState(() {
          //   _goToTheLake(latLngCamera.latitude, latLngCamera.longitude);
          // });
        },
        tooltip: 'Increment',
        label: Text(
          "Select Location",
          style: CommonStyles.whiteText15BoldW500(),
        ),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class ReverseGeoCodingTextFormField extends StatefulWidget {
  const ReverseGeoCodingTextFormField(
      {Key? key,
      required this.latitude,
      required this.longitude,
      required this.controllerAddress})
      : super(key: key);
  final double latitude, longitude;
  final TextEditingController controllerAddress;
  @override
  _ReverseGeoCodingTextFormFieldState createState() =>
      _ReverseGeoCodingTextFormFieldState();
}

class _ReverseGeoCodingTextFormFieldState
    extends State<ReverseGeoCodingTextFormField> {
  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    await geocoding.GeocodingPlatform.instance
        .placemarkFromCoordinates(widget.latitude, widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: deviceWidth(context) * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: Colors.amber),
          color: Colors.blue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Current Location",
              style: CommonStyles.whiteText15BoldW500(),
            ),
          ),
          FutureBuilder<List<geocoding.Placemark>>(
              future: geocoding.GeocodingPlatform.instance
                  .placemarkFromCoordinates(widget.latitude, widget.longitude),
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
                if (snapshot.data != null) {
                  widget.controllerAddress.text = snapshot.data!.first.street! +
                      ", " +
                      snapshot.data!.first.subLocality! +
                      ", " +
                      snapshot.data!.first.locality! +
                      ", " +
                      snapshot.data!.first.postalCode! +
                      ", " +
                      snapshot.data!.first.administrativeArea!;
                  final url = "https://www.google.co.in/maps/@" +
                      widget.latitude.toString() +
                      "," +
                      widget.longitude.toString() +
                      ",19z";
                  print(url);
                } else {
                  widget.controllerAddress.text = "No Address Found";
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Text(
                          widget.controllerAddress.text,
                          style: CommonStyles.textDataWhite12Bold(),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}

class ChangeMapsStateProvider with ChangeNotifier {
  double _latitude = 0.00;
  double _longitude = 0.00;

  void setLatitudeLongitude(double latitude, double longitude) {
    _latitude = latitude;
    _longitude = longitude;
    notifyListeners();
  }

  double get latitude => _latitude;

  double get longitude => _longitude;
}
