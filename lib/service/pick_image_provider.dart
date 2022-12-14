import 'dart:io';
import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/CommonWidgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  //Return a [File] object pointing to the image that was picked.
  Future<PickedFile> pickImage({required ImageSource source}) async {
    final xFileSource =
        await ImagePicker().pickImage(source: source, imageQuality: 70);
    return PickedFile(xFileSource!.path);
  }

  Future<File> chooseImageFile(BuildContext context) async {
    try {
      return await showModalBottomSheet(
          context: context, builder: (builder) => bottomSheet(context));
    } catch (e) {
      print(
          "The error is on line 23 image picker service ......" + e.toString());
    }
    return File('');
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 130,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            "Choose Image File",
            style: CommonStyles.whiteText15BoldW500(),
          ),
          Utils.getSizedBox(height: 20, width: 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.userCircle,
                        size: 22,
                      ),
                      onPressed: () async {
                        final file =
                            await pickImage(source: ImageSource.camera);
                        File selected = File(
                          file.path,
                        );
                        Navigator.pop(context, selected);
                      }),
                  const Text(
                    "Camera",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1),
                  )
                ],
              ),
              Utils.getSizedBox(height: 0, width: 20),
              Column(
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.image,
                        size: 22,
                      ),
                      onPressed: () async {
                        final file =
                            await pickImage(source: ImageSource.gallery);
                        File selected = File(file.path);
                        Navigator.pop(context, selected);
                      }),
                  const Text(
                    "Gallery",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
