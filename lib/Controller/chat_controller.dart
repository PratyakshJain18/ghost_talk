import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../utils/bad_word_filter.dart';
import '../utils/user_identity.dart';

class ChatController extends GetxController {
  final String topicId;

  ChatController(this.topicId);
  final ScrollController scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();

  CollectionReference get _messageRef =>
      FirebaseFirestore.instance
          .collection('topics')
          .doc(topicId)
          .collection('messages');

  Stream<QuerySnapshot> messageStream() {
    return _messageRef
        .orderBy('timestamp', descending: false)
        .snapshots();
  }


  Future<void> deleteMessage(String docId) async {
    try {
      await _messageRef.doc(docId).delete();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Could not delete message",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }






  Future<void> sendMessage(BuildContext context) async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;


    if (BadWordFilter.containsBadWords(text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("🚫 Hold it. This language is not allowed."),
        ),
      );
      return;
    }

    // ✅ Firestore send (UNCHANGED)
    _messageRef.add({
      'text': text,
      'senderId': userId,
      'senderName': username,
      'timestamp': FieldValue.serverTimestamp(),
      'messageId': messageId
    });

    messageController.clear();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }



  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
