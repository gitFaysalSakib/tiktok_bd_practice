import 'package:bdtok_prac/controller/video_controller.dart';
import 'package:bdtok_prac/view/widgets/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AddCaptionScreen extends StatefulWidget {
  final File video;
  final String videoPath;

  const AddCaptionScreen({super.key, required this.video, required this.videoPath});

  @override
  State<AddCaptionScreen> createState() => _AddCaptionScreenState();
}

class _AddCaptionScreenState extends State<AddCaptionScreen> {
    VideoController videoController = Get.put(VideoController());

  TextEditingController musicNameController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  late VideoPlayerController vc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      vc = VideoPlayerController.file(widget.video);
      vc.initialize();
      vc.play();
      vc.setLooping(true);
      vc.setVolume(0.5);
    });
  }
      bool uploading = false;


  void startUploading(){

    setState(() {
      uploading = true;
    });
    if (uploading == true){
          return;

    }

    setState(() {
      uploading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [                                                                                                                                                  
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .7,
              child: VideoPlayer(vc),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .3,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextInputWidget(
                      myLabelText: 'Music Title',
                      myIcon: Icons.music_note,
                      controller: musicNameController),
                  TextInputWidget(
                      myLabelText: 'Caption',
                      myIcon: Icons.closed_caption,
                      controller: captionController),
                  ElevatedButton(
                    onPressed: () {
                      startUploading();
                      VideoController.instance.uploadVideo(musicNameController.text, captionController.text, widget.videoPath);
                    },
                    child: const Text('Upload'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
