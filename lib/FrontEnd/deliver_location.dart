import 'dart:async';
import 'package:bigbaang/FrontEnd/CommonWidgets/add_address_details.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/screen_width_and_height.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/widgets/maps_widget_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {


  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];

  final _autocompleteLocationController = TextEditingController();

  @override
  void initState() {
    googlePlace = GooglePlace('AIzaSyDmAKO_2HdB8I4hVpTIN3DKYZO5xCXQ2ow');
    super.initState();
  }

  bool isvisible = true;

  void showToast() {
    setState(() {
      isvisible = isvisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  elevation: 0,
title: Text("Select Your Delivery Address",
style: CommonStyles.textDataWhite14(),
),),
     body: buildBody(),


    );
  }

  buildBody() {
    return Column(
      children: [
    //    buildWelcome(),
        // placesAutoCompleteTextField(context),
        buildSearch(),
        buildListOfLocality(),
        // buildRecentdrop(),
        // buildRecentdropList()
      ],
    );
  }

  bool _fetchingAutoComplete = false;

  void autoCompleteSearch(String value) async {
    setState(() {
      _fetchingAutoComplete = true;
    });
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      predictions = result.predictions!;
      _fetchingAutoComplete = false;
    }
    setState(() {});
  }

  buildWelcome() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
          Text('Enter Drop Location', style: CommonStyles.black15()),
        ],
      ),
    );
  }

  buildSearch() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      width: double.infinity,
      child: Card(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        elevation: 10,
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                Icons.search_rounded,
                color: Colors.black54,
              ),
            ),
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  }
                },
                cursorColor: Colors.black,
                readOnly: false,
                controller: _autocompleteLocationController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: CommonStyles.black15(),
                decoration: const InputDecoration(
                    hintText: 'Search your area,street name.. ',
                    isDense: false,
                    contentPadding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildListOfLocality() {
    return Expanded(
      child: _autocompleteLocationController.text.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Search your locaiton on search box",
              style: CommonStyles.blueBold14(),
            )
          ],
        ),
      )
          : _fetchingAutoComplete
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 1,
              backgroundColor: Colors.black12,
              color: Colors.green[900],
            ),
            Utils.getSizedBox(height: 15),
            Text(
              "Loading...",
              style: CommonStyles.blueBold14(),
            )
          ],
        ),
      )
          : predictions.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Oops! We could not find locaiton your searching.",
              style: CommonStyles.textw200RedS16(),
            )
          ],
        ),
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Search Results",
              style: CommonStyles.black15(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: predictions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: deviceWidth(context) * 0.9,
                    child: InkWell(
                      onTap: () async {
                        // Utils.showLoaderDialog(context);
                        DetailsResponse? result =
                        await googlePlace.details
                            .get(predictions[index].placeId!);
                        Navigator.of(context).pop();
                        if (result != null) {
                          Location locaiton =
                          result.result!.geometry!.location!;

                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PlacePickGoogleMapsTrue(

                                        latitude: locaiton.lat!,
                                        longitude: locaiton.lng!,
                                      )));
                        } else {
                          Utils.showSnackBar(
                              context: context,
                              text:
                              "Oops! Something went wrong!!");
                        }

                        // if (result != null &&
                        //     result.predictions != null &&
                        //     mounted) {
                        //   predictions = result.predictions!;
                        //   _fetchingAutoComplete = false;
                        // }
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.location_on_rounded),
                          Utils.getSizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  predictions[index].description!,
                                  maxLines: 2,
                                  style: CommonStyles.black15(),
                                ),
                                Utils.getSizedBox(
                                  height: 5,
                                ),
                                Text(
                                  predictions[index]
                                      .structuredFormatting!
                                      .mainText!,
                                  style: CommonStyles
                                      .black12(),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );

                // return ListTile(
                //   contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                //   dense: true,
                //   leading: const Icon(
                //     Icons.location_on,
                //     color: Colors.black,
                //   ),
                //   title: Text(
                //     predictions[index].description!,
                //     style: CommonStyles.black13(),
                //   ),
                //   subtitle:  Text(
                //     predictions[index].description!,
                //     style: CommonStyles.black13(),
                //   )
                //   onTap: () {
                //     debugPrint(predictions[index].placeId);
                //     Navigator.pushNamed(context, "ConfirmLocation",
                //         arguments: predictions[index].description);
                //   },
                // );
              },
            ),
          ),
        ],
      ),
    );
  }


}





class PlacePickGoogleMapsTrue extends StatefulWidget {

  double? latitude;
  double? longitude;
  PlacePickGoogleMapsTrue({Key? key,this.latitude,this.longitude}) : super(key: key);

  @override
  _PlacePickGoogleMapsTrueState createState() => _PlacePickGoogleMapsTrueState();
}

class _PlacePickGoogleMapsTrueState extends State<PlacePickGoogleMapsTrue> {
  Location location = Location();

  TextEditingController controllerAddress = TextEditingController();

  late LatLng latLngCamera;

  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;

  @override
  void initState() {
    print("Init state pronted");

    super.initState();
    if (widget.latitude == null || widget.longitude == null) {
      latLngCamera =
          LatLng(widget.latitude!, widget.longitude!);
    } else {
      latLngCamera = LatLng(widget.latitude!, widget.longitude!);
    }

    print(latLngCamera.latitude.toString() +
        "Lat long camera" +
        latLngCamera.longitude.toString());
    // context.read<ProfileApiProvder>().profileModel!.userDetails!.latitude;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  bool _isWidgetLoading = false;
  bool initialScreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
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
                    target: LatLng(latLngCamera.latitude, latLngCamera.longitude),
                    zoom: 15),
                onMapCreated: (GoogleMapController controller) {
                  getJsonFile("images/mapStyle.json")
                      .then((value) => controller.setMapStyle(value));
                  _controller.complete(controller);
                  mapController = controller;
                },
                onCameraIdle: () {
                  setState(() {
                    _isWidgetLoading = false;
                  });
                },
                onCameraMove: (value) {
                  latLngCamera = value.target;
                },
                onCameraMoveStarted: () {
                  setState(() {
                    _isWidgetLoading = true;
                  });
                },
              ),
            ),
            Positioned(
              top: (deviceHeight(context) - 70) / 2,
              right: (deviceWidth(context) - 35) / 2,
              child: const Align(
                alignment: Alignment.center,
                child: Icon(
                  FontAwesomeIcons.mapPin,
                  color: Colors.blue,
                  size: 35,
                ),
              ),
            ),
            Positioned(
                top: 50.0,
                right: 15.0,
                left: 15.0,
                child: _isWidgetLoading
                    ? Container(
                  height: 100,
                  width: deviceWidth(context) * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: Colors.amber),
                      color: Colors.blue),
                  child: const Center(
                    child: SizedBox(
                      height: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color: Colors.white,
                      ),
                      width: 25,
                    ),
                  ),
                )
                    : ReverseGeoCodingTextFormField(
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
          style: CommonStyles.textDataWhite15(),
        ),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

/*
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

  bool currentLocation = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          //  height: 100,
          padding: EdgeInsets.only(
              right: 10
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: Colors.amber),
              color: Colors.blue),
          width: deviceWidth(context) * 0.9,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Card(
                      elevation: 10,
                      child: TextFormField(

                        style: CommonStyles.textDataWhite12(),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 5
                            ),
                            border: InputBorder.none,
                            hintText: "Search Your Address"
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          currentLocation = !currentLocation;
                        });
                      },

                      child: Text("My Location",
                        style: CommonStyles.textDataWhite12(),
                        textAlign: TextAlign.center,

                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        if(currentLocation == true) Container(
          //   height: 100,
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
                  style: CommonStyles.textDataWhite15(),
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
                              style: CommonStyles.textDataWhite12(),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ],
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
}*/
