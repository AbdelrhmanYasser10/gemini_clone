import 'package:chat_iq/index.dart';

class ChatModel {
  late String? id;
  late Timestamp? timestamp;
  late String? lastMessage;

  ChatModel(
      { this.id,  this.timestamp,  this.lastMessage});
}
