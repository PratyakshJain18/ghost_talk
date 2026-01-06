import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Controller/chat_controller.dart';
import '../../utils/user_identity.dart';
class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key }) ;

  String getTime(Timestamp? timestamp) {
    if (timestamp == null) return '';
    return DateFormat('dd MMM, hh:mm a').format(timestamp.toDate());
  }

  @override
  Widget build(BuildContext context) {
    final String topicTitle = Get.arguments['topicTitle'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        title: Text(
          topicTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [


          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: controller.messageStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData ||
                    snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "No messages yet.\nStart the conversation 👇",
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                final messages = snapshot.data!.docs;
                return ListView.builder(
                  controller: controller.scrollController,

                  padding: const EdgeInsets.all(12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final data =
                    messages[index].data() as Map<String, dynamic>;

                    final isMe = data['senderId'] == userId;
                    final time = getTime(data['timestamp']);
                    final doc = snapshot.data!.docs[index];
                    final String messageId = doc.id;
                    final docId = messages[index].id;

                    return GestureDetector(
                      onLongPress: () {
                        Get.bottomSheet(
                          SafeArea(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  if (isMe)
                                    ListTile(
                                      leading: const Icon(Icons.delete, color: Colors.red),
                                      title: const Text(
                                        "Delete Message",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onTap: () async {
                                        Get.back();
                                        await controller.deleteMessage(docId);
                                      },
                                    ),


                                  ListTile(
                                    leading: const Icon(Icons.info, color: Colors.blue),
                                    title: const Text(
                                      "Copy Message Id",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onTap: () {
                                      Get.back();
                                      controller.copyMessageId(
                                        context: context,
                                        messageId: data["messageId"], // ✅ FIXED
                                      );
                                    },
                                  ),
                                  if (!isMe)
                                    ListTile(
                                      leading: const Icon(Icons.flag, color: Colors.red),
                                      title: const Text("Report Message"),
                                      onTap: () async {
                                        Get.back(); // close bottom sheet

                                        final bool didReport =
                                        await controller.reportMessage(messageId);

                                        if (didReport) {
                                          Get.snackbar(
                                            "Reported",
                                            "Thank you for reporting inappropriate content.",
                                            snackPosition: SnackPosition.BOTTOM,
                                            icon: const Icon(Icons.flag, color: Colors.red),
                                            margin: const EdgeInsets.all(12),
                                            borderRadius: 12,
                                          );
                                        } else {
                                          Get.snackbar(
                                            "Already Reported",
                                            "You have already reported this message.",
                                            snackPosition: SnackPosition.BOTTOM,
                                            icon: const Icon(Icons.info, color: Colors.orange),
                                            margin: const EdgeInsets.all(12),
                                            borderRadius: 12,
                                          );
                                        }
                                      },

                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!isMe)
                                Text(
                                  data['senderName'],
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              Text(
                                data['text'],
                                style: TextStyle(
                                  color: isMe ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                time,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[900],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          /// ⌨️ INPUT
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.messageController,
                    decoration: const InputDecoration(
                      hintText: "Type a message",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Obx(() => IconButton(
                  onPressed: controller.canSend.value
                      ? () => controller.sendMessage(context)
                      : null,
                  icon: const Icon(Icons.send),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
