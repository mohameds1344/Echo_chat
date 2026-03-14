import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String id;
  final Timestamp? createdAT;
  final String idDoc;
  Message(this.message, this.id, this.createdAT,this.idDoc);

  factory Message.fromJson(jsonData) {
    return Message(jsonData['message'], jsonData['id']??'', jsonData['createdAt'],jsonData.id);
  }
}
