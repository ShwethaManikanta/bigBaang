class EditCartAddressRequestModel {
  late String userId,
      type,
      address,
      land_mark,
      door_no,
      street,
      state,
      pincode,
      lat,
      long;

  EditCartAddressRequestModel(
      {required this.userId,
      required this.type,
      required this.address,
      required this.land_mark,
      required this.door_no,
      required this.street,
      required this.state,
      required this.pincode,
      required this.lat,
      required this.long});

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'type': type,
      'address': address,
      'land_mark': land_mark,
      'door_no': door_no,
      'street': street,
      'state': state,
      'pincode': pincode,
      'lat': lat,
      'long': long
    };
  }
}
