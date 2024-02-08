import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String recieverId;
  final String message;
  final Timestamp timestamp;
  Message(
      {required this.senderId,
      required this.recieverId,
      required this.message,
      required this.senderEmail,
      required this.timestamp});

  // convert to map
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'recieverId': recieverId,
      'message': message,
      'timestamp': timestamp
    };
  }
//   factory Message.fromMap(Map<String, dynamic> map){
//     return Message(
//       senderId: map['senderId'],
//       recieverId: map['recieverId'],
//       message: map['message'],
//       senderEmail: map['senderEmail'],
//       recieverEmail: map['recieverEmail'],
//       timestamp: map['timestamp'].toDate()
//     );
//   }
// }
}
