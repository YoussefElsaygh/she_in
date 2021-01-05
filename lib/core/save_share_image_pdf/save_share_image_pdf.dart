import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';

//get path to save
import 'package:path_provider/path_provider.dart';
//convert widget to image
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
//convert widget to image

//share
import 'package:esys_flutter_share/esys_flutter_share.dart';
//create pdf and save
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
//save image
import 'package:save_in_gallery/save_in_gallery.dart';

import 'captureImage.dart';
enum CaptureImageType { pdf, image }
enum CaptureImageAction { download, share }
class SaveShareImagePDF{

  static Future<CaptureImage> capturePng({@required CaptureImageAction action,
    @required CaptureImageType type,@required String name,
    @required GlobalKey globalKey ,@required BuildContext context}) async {

    RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 2.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();  // to show image use widget Image.memory(pngBytes)
    String bs64 = base64Encode(pngBytes);
    print(pngBytes);


    if(type==CaptureImageType.pdf) {
      //create pdf from image as Uint8List
      final pdf = pw.Document();

      final image = PdfImage.file(
        pdf.document,
        bytes: pngBytes,
      );

      pdf.addPage(pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(image),
            ); // Center
          })); // Page

      //save in cache of app
      final outputCache = await getTemporaryDirectory();
      final pdfFileCache = File("${outputCache.path}/${name}.pdf");
      await pdfFileCache.writeAsBytes(pdf.save());
      Uint8List pdfBytes =pdfFileCache.readAsBytesSync();

      if(action==CaptureImageAction.download) {
        try{
          //save in External directory of app
          var output;
          if(Platform.isIOS ){
            output=await getApplicationDocumentsDirectory();
          }
          else{
            output = await getExternalStorageDirectory();

          }
          final pdfFile = File("${output.path}/${name}.pdf");
          await pdfFile.writeAsBytes(pdf.save());
          await OpenFile.open("${output.path}/${name}.pdf");


          //view pdf
//          Navigator.of(context).push(
//            MaterialPageRoute(
//                  builder: (_)=>
//                      Scaffold(
//                        body:
//                          Container(
//                            child: Column(
//                              children: <Widget>[
//                                Container(
//                                  margin: EdgeInsets.only(top:25),
//                                  width: double.infinity,
//                                  child: IconButton(
//                                    alignment: Alignment.centerLeft,
//                                    icon: Icon(Icons.arrow_back, color: Colors.black),
//                                    onPressed: () => Navigator.of(context).pop(),
//                                  ),
//                                ),
//                                Container(
//                                  padding: EdgeInsets.all(15),
//                                  child:Image.memory(pngBytes),
//                                ),
//                              ],
//                            ),
//                          ),
////                          PDFViewerScaffold(
////                            path: "${output.path}/${name}.pdf",
////                          )
//                      ),
//            )
//          );

        }
        catch(e){
          print(e);
        }
      }

      else if(action == CaptureImageAction.share) {
        SaveShareImagePDF.sharePdf(pdfName: name,pdfBytes: pdfBytes);
      }
    }

    //image
    else if(type == CaptureImageType.image) {

      if(action ==CaptureImageAction.download) {
        SaveShareImagePDF.saveImageInAppFile(imageName: name,pngBytes: pngBytes);
      }
      else if (action == CaptureImageAction.share) {
        SaveShareImagePDF.shareImage(imageName: name,pngBytes:pngBytes);
      }

    }

    return(CaptureImage(pngBytes:pngBytes,bs64:bs64));
  }


  //  share Pdf
  static void sharePdf({@required String pdfName, @required Uint8List pdfBytes}) async{

    try {
      await Share.file(
          '${pdfName}', '${pdfName}.pdf', pdfBytes, 'text/pdf');
    } catch (e) {
      print('error: $e');
    }
  }


  // saveImageInAppFile
  static void saveImageInAppFile({@required String imageName, @required Uint8List pngBytes}) async{

    String dir = (await getExternalStorageDirectory()).path;
    String fullPath = '$dir/${imageName}.png';
    File file = File(fullPath);
    await file.writeAsBytes(pngBytes);

  }

  // saveImageInGallery
  static void saveImageInGallery({@required String imageName, @required Uint8List pngBytes}) async{

    final _imageSaver = ImageSaver();
    final bool res = await _imageSaver.saveImage(imageBytes: pngBytes,imageName:'${imageName}.png',directoryName: '${imageName}');
    //res is bool if (res == true) success else faild
    print(res);
  }

  //  shareImage
  static void shareImage({@required String imageName, @required Uint8List pngBytes}) async{

    try {
      await Share.file(
          '${imageName}', '${imageName}.png', pngBytes, 'image/png');
    } catch (e) {
      print('error: $e');
    }
  }

}