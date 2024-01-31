
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: SafeArea(child: Image.file(File(imagePath))),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.back();

         },
        child:  const Icon(Icons.done_all),
      ),
    );
  }
}