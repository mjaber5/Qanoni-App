import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart'; // تأكد من وجود ملف الألوان الخاص بك

class NotificationTabBar extends StatefulWidget {
  const NotificationTabBar({super.key});

  @override
  State<NotificationTabBar> createState() => _NotificationTabBarState();
}

class _NotificationTabBarState extends State<NotificationTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // إزالة الظل
        centerTitle: true,
        title: const Text(
          "Notifications",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          padding: const EdgeInsets.symmetric(vertical: 12),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: QColors.secondary, // لون الخلفية عند التحديد
          ),
          indicatorPadding: EdgeInsets.zero,
          indicatorColor: Colors.transparent, // إخفاء الخط السفلي الافتراضي
          labelColor: Colors.white, // لون النص للتبويب المحدد
          unselectedLabelColor: Colors.black87, // لون النص للتبويبات غير المحددة
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: List.generate(4, (index) {
            final List<String> tabTitles = ["All", "Jobs", "My Posts", "Mentions"];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.7),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade400, // لون الحدود
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20), // الشكل الدائري
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                  child: Tab(
                    text: tabTitles[index],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildNotificationList("All"),
          buildNotificationList("Jobs"),
          buildNotificationList("My Posts"),
          buildNotificationList("Mentions"),
        ],
      ),
    );
  }

  Widget buildNotificationList(String type) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.15,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 10,
                  spreadRadius: 3,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: QColors.secondary,
                  child: Icon(Icons.notifications, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$type Notification ${index + 1}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "This is a detailed description of the notification that can span two lines.",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios,
                    color: Colors.grey, size: 18),
              ],
            ),
          ),
        );
      },
    );
  }
}
