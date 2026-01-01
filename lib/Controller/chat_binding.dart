import 'package:get/get.dart';
import '../Controller/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(
          () => ChatController(Get.arguments['topicId']),
      fenix: false,
    );
  }
}
