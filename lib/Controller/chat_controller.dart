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

  RxBool canSend = true.obs;
  DateTime? _lastSentTime;
  bool _hasShownCooldownMsg = false;
  final int cooldownSeconds = 3;




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


  bool canSendMessage() {
    if (_lastSentTime == null) return true;

    final diff = DateTime.now().difference(_lastSentTime!);
    if (diff.inSeconds >= 3) {
      _hasShownCooldownMsg = false;
      return true;
    }
    return false;
  }




  void copyMessageId({required BuildContext context, required String messageId,}) {
    Clipboard.setData(
      ClipboardData(text: messageId),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Message ID copied"),
        duration: Duration(seconds: 2),
      ),
    );
  }


  Future<void> sendMessage(BuildContext context) async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    // 🚫 Spam cooldown
    if (!canSend.value) {
      if (!_hasShownCooldownMsg) {
        _hasShownCooldownMsg = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("⏳ Please wait 3 seconds before sending again"),
          ),
        );
      }
      return;
    }

    //  Bad word filter
    if (BadWordFilter.containsBadWords(text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("🚫 Hold it. This language is not allowed."),
        ),
      );
      return;
    }


    canSend.value = false;
    _lastSentTime = DateTime.now();

    // ✅ Firestore send
    await _messageRef.add({
      'text': text,
      'senderId': userId,
      'senderName': username,
      'timestamp': FieldValue.serverTimestamp(),
      'messageId': messageId,
    });

    messageController.clear();

    // ⏳ UNLOCK after cooldown
    Future.delayed(const Duration(seconds: 3), () {
      canSend.value = true;
      _hasShownCooldownMsg = false;
    });


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
