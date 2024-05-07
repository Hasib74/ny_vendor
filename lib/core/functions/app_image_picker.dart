import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:single_vendor_admin/presentation/utils/AppColors.dart';

Future<XFile?> openGalleryOrCameraAndPickImage(BuildContext context) async {
  return await showDialog<XFile?>(
    context: context,
    //   barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text('Select Product Image ')),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[],
          ),
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              child: Icon(Icons.photo_album), // Text('Open Gallery'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: AppColors.orange,
                onSurface: Colors.grey,
                shadowColor: Colors.red,
                elevation: 5,
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontStyle: FontStyle.italic),
              ),
              onPressed: () async {
                XFile? _img = await _openPhoneCameraOrGallery(false);

                Navigator.pop(context, _img);
              },
            ),
          ),
          SizedBox(height: 7),
          Center(
            child: TextButton(
              child: Icon(Icons.camera_alt), // Text('Open Camera'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: AppColors.orange,
                onSurface: Colors.grey,
                shadowColor: Colors.red,
                elevation: 5,
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontStyle: FontStyle.italic),
              ),
              onPressed: () async {
                XFile? _img = await _openPhoneCameraOrGallery(true);

                Navigator.pop(context, _img);
              },
            ),
          ),
        ],
      );
    },
  );
}

Future<XFile?> _openPhoneCameraOrGallery(bool isCamera) async {
  // final pickedFile = await imagePicker.getImage(source: ImageSource.camera);

  final imagePicker = ImagePicker();

  XFile? pickedFile;
  if (isCamera) {
    pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
  } else {
    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
  }
  if (pickedFile != null) {
    return pickedFile;
    print('photo ok');
  } else {
    print('No image selected.');
  }
}
