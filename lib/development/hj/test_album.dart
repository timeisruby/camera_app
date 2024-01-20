import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class AlbumCreationExample extends StatelessWidget {
  final String albumName = "123";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Album Creation Example"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await createAlbum(albumName);
            await saveImageToAlbum(albumName);
          },
          child: Text("Create Album and Save Image"),
        ),
      ),
    );
  }

  Future<void> createAlbum(String albumName) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      print("Album '$albumName' created successfully.");
    } else {
      print("Permission denied. Can't create the album.");
    }
  }

  Future<void> saveImageToAlbum(String albumName) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      // Implement image saving logic here
      // ...

      // Example: Save a sample image to the specified album
      ByteData data = await rootBundle
          .load('/Users/kimheejae/Desktop/2023-05-25_5_36_05.png');
      List<int> bytes = data.buffer.asUint8List();
      await ImageGallerySaver.saveImage(Uint8List.fromList(bytes),
          name: 'sample_image', quality: 100);

      print("Image saved to album '$albumName' successfully.");
    } else {
      print("Permission denied. Can't save the image.");
    }
  }
}
