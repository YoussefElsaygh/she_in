import 'dart:typed_data';
import 'package:flutter/foundation.dart';

class CaptureImage{
  final Uint8List pngBytes;
  final String bs64;


  const CaptureImage({
    @required this.pngBytes,
    @required this.bs64,
  });
}