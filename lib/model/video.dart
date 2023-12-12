import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String uid;
  String videoUrl;
  String thumbnail;
  String musicTitle;
  String caption;
  String username;
  int commentCount;
  List likes;
  int shareCount;
  String videoId;
  String profilePic;

  Video({
    required this.caption,
    required this.commentCount,
    required this.likes,
    required this.musicTitle,
    required this.profilePic,
    required this.shareCount,
    required this.thumbnail,
    required this.uid,
    required this.username,
    required this.videoId,
    required this.videoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'caption': caption,
      'commentCount': commentCount,
      'likes': likes,
      'musicTitle': musicTitle,
      'profilePic': profilePic,
      'shareCount': shareCount,
      'thumbnail': thumbnail,
      'uid': uid,
      'username': username,
      'videoId': videoId,
      'videoUrl': videoUrl,
    };
  }

  static Video fromSnap(DocumentSnapshot snap) {
    final snapshot = snap.data() as Map<String, dynamic>;
    return Video(
      caption: snapshot["caption"],
      commentCount: snapshot["commentCount"],
      likes: snapshot["likes"],
      musicTitle: snapshot["musicTitle"],
      profilePic: snapshot["profilePic"],
      shareCount: snapshot["shareCount"],
      thumbnail: snapshot["thumbnail"],
      uid: snapshot["uid"],
      username: snapshot["username"],
      videoId: snapshot["videoId"],
      videoUrl: snapshot["videoUrl"],
    );
  }
}
