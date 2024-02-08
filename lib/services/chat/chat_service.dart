import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  // get instance of chat service
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // get user Stream()

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('users').snapshots().map((event) {
      return event.docs.map((doc) {
        // go through  each document and return the data
        final user = doc.data();
        //return the user data
        return user;
      }).toList();
    });
  }

  // send message()
  Future<void> sendMessage(String recieverId, String message) async {
    // get user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    //create new Message(),
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      recieverId: recieverId,
      message: message,
      timestamp: timestamp,
    );
    print("recieverId   $recieverId");
    print("sender id   $currentUserId");
    print("message  $message");
    print("sender email  $currentUserEmail");
    print("message  $message");
    print("timestamp  $timestamp");

    //construct chat room id forthe two users (sorted to ensure uniqueness of chat room)
    List<String> userIds = [currentUserId, recieverId];
    userIds
        .sort(); // sort the user ids to ensure chatroom is the same for both users
    String chatRoomId = userIds.join('_');
    // add new message to Database(),
    await _firestore
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // get messages(),
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    //construct a chat room id for the two users (sorted to ensure uniqueness of chat room)
    List<String> userIds = [userID, otherUserID];

    userIds.sort();
    // sort the user ids to ensure chatroom is the same for both users
    print("CURRENT USER ID >>>>>>>>>$userIds");
    print("OTHER USER ID >>>>>>>>>$otherUserID");
    String chatRoomId = userIds.join('_');
    return _firestore
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
