import 'package:bdtok_prac/model/video.dart';
import 'package:bdtok_prac/view/screens/add_video_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';
import 'dart:io';

class VideoController extends GetxController {
  static VideoController instance = Get.find();
  var uuid = const Uuid();

  uploadVideo(String musicName, String caption, String videoPath) async {
    try {
      String id = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection('users').doc(id).get();

      String videoId = uuid.v1();

      String downloadUrl = await uploadVideoToFireStorage(videoId, videoPath);
      String thumbnail = await uploadThumb(videoId, videoPath);

      Video video = Video(
        caption: caption,
        commentCount: 0,
        likes: [0, ],
        musicTitle: musicName,
        profilePic: (snap.data() as Map<String, dynamic>)['profilePhoto'],
        shareCount: 0,
        thumbnail: thumbnail,
        uid: id,
        username: (snap.data() as Map<String, dynamic>)['username'],
        videoId: videoId,
        videoUrl: downloadUrl,
      );
      await FirebaseFirestore.instance
          .collection('uploadedVideos')
          .doc(videoId)
          .set(video.toJson());

      Get.snackbar("Video Upload", "Your video has been successfully uploaded");
      Get.to(const AddVideoScreen());
      Get.snackbar('Video Upload:', "Successfully uploaded");
    } catch (e) {
      Get.snackbar("Error", e.toString());
      print(e);
    }
  }

  Future<String> uploadVideoToFireStorage(String id, String videoPath) async {
    Reference ref = FirebaseStorage.instance.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile(await compressedOriVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
compressedOriVideo(String videoPath) async {
    final comressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return comressedVideo!.file;
  }

  Future<File>getThumb(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String>uploadThumb(String id, String videoPath) async {
    Reference ref = FirebaseStorage.instance.ref().child('thumb').child(id);
    UploadTask uploadTask = ref.putFile(await getThumb(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
