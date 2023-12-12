import 'dart:io';

import 'package:bdtok_prac/view/screens/add_caption_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  pickVideo(ImageSource src)async{
    final video = await ImagePicker().pickVideo(source: src);
    if(video != null)
{
  Get.snackbar('Video Selection', 'Successfull');
  Get.to(AddCaptionScreen(video: File(video.path), videoPath: video.path));
}else{
  Get.snackbar('Video Selection', 'Failed');
}
  }

  videoUploadOptions(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: (){
              pickVideo(ImageSource.camera);
            },
            child: const Text('Camera'),
          ), 
           SimpleDialogOption(
            onPressed: (){
              pickVideo(ImageSource.gallery);
            },
            child: const Text('Galary'),
          ),
           SimpleDialogOption(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text('Close'),
          )
        ],
      )
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                videoUploadOptions(context);
              },
              child: const Text('Add Video'),
            ),
          ],
        ),
      ),
    );
  }
}
