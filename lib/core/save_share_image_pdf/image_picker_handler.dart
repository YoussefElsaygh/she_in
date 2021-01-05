import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';


class ImagePickerHandler {
 // ImagePickerDialog imagePicker;
  AnimationController _controller;
  ImagePickerListener _listener;

  ImagePickerHandler(this._listener, this._controller);





  Future cropImage(File image) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      maxWidth: 512,
      maxHeight: 512,
    );
    _listener.userImage(croppedFile);
  }


}

abstract class ImagePickerListener {
  userImage(File _image);
}
