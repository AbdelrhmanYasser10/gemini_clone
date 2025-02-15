import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  late String content;
  late bool is_sender;
  late Timestamp time;
  late String? media;

  MessageModel(
      {required this.content,
      required this.time,
      required this.is_sender,
      required this.media});

  MessageModel.fromJson(Map<String, dynamic> json) {
    content = json["content"];
    is_sender = json["is_sender"];
    time = json["time"];
    media = json["media"];
  }

  Map<String, dynamic> toMap() => {
        "is_sender": is_sender,
        "content": content,
        "time": time,
        "media": media,
      };
}
