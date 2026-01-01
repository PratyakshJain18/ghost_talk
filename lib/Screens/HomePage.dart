import 'package:anonymous_chat/utils/report_webview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Components/topic_card.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),


      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF0F172A),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                    const AssetImage('assets/icon/app_icon.png'),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Ghost Talk',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.report_problem_outlined),
              title: const Text(
                'Report A Message',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Get.back();

                Get.to(
                      () => const ReportWebView(
                    url: "https://ghost-43c24.web.app/",
                  ),
                );
              },
            ),
          ],
        ),
      ),


      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        toolbarHeight: 70,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Ghost Talk",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "No names. Just voices.",
              style: TextStyle(
                fontSize: 13,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7,
          children: [
            TopicCard(
              title: "Political",
              subtitle: "Opinions without fear.",
              icon: Icons.account_balance,
              color: Colors.red.shade700,
              onTap: () {
                Get.toNamed('/chat', arguments: {
                  'topicId': 'political',
                  'topicTitle': 'Political',
                });
              },
            ),
            TopicCard(
              title: "College Criticism",
              subtitle: "Say what campus won’t hear.",
              icon: Icons.school,
              color: Colors.orange.shade700,
              onTap: () {
                Get.toNamed('/chat', arguments: {
                  'topicId': 'college_criticism',
                  'topicTitle': 'College Criticism',
                });
              },
            ),
            TopicCard(
              title: "Subject Doubts",
              subtitle: "Ask freely. Learn honestly.",
              icon: Icons.help_outline,
              color: Colors.blue.shade700,
              onTap: () {
                Get.toNamed('/chat', arguments: {
                  'topicId': 'subject_doubts',
                  'topicTitle': 'Subject Doubts',
                });
              },
            ),
            TopicCard(
              title: "Professor Criticism",
              subtitle: "Feedback without consequences.",
              icon: Icons.person_outline,
              color: Colors.purple.shade700,
              onTap: () {
                Get.toNamed('/chat', arguments: {
                  'topicId': 'professor_criticism',
                  'topicTitle': 'Professor Criticism',
                });
              },
            ),
            TopicCard(
              title: "Confessions",
              subtitle: "Things I Cant Tell Anyone",
              icon: Icons.lock_outline,
              color: Colors.purple.shade700,
              onTap: () {
                Get.toNamed('/chat', arguments: {
                  'topicId': 'confessions',
                  'topicTitle': 'Confessions',
                });
              },
            ),
            TopicCard(
              title: "Rant",
              subtitle: "Let The Poison Be Out",
              icon: Icons.campaign_outlined,
              color: Colors.green.shade700,
              onTap: () {
                Get.toNamed('/chat', arguments: {
                  'topicId': 'rant-up',
                  'topicTitle': 'Rant Up',
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
