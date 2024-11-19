import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

class NotificationTabBar extends StatelessWidget {
  const NotificationTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // عدد التبويبات
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Notifications",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50), // حجم التبويبات
            child: Container(
              // لون الخلفية العامة
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0), // المسافة من الجوانب
                child: TabBar(
                  indicator: BoxDecoration(
                    color: Colors.green, // لون الخلفية للتبويب المحدد
                    borderRadius: BorderRadius.circular(20), // الحواف الدائرية
                  ),
                  unselectedLabelColor: Colors.grey, // لون النص غير المحدد
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  tabs: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Tab(child: _buildTabItem(context, "All", 0)),
                    ),
                    Tab(child: _buildTabItem(context, "Jobs", 1)),
                    Tab(child: _buildTabItem(context, "My posts", 2)),
                    Tab(child: _buildTabItem(context, "Mentions", 3)),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            buildNotificationList("All"), // محتوى التبويب الأول
            buildNotificationList("Jobs"), // محتوى التبويب الثاني
            buildNotificationList("My posts"), // محتوى التبويب الثالث
            buildNotificationList("Mentions"), // محتوى التبويب الرابع
          ],
        ),
      ),
    );
  }

  // تصميم التبويب الواحد
  Widget _buildTabItem(BuildContext context, String text, int tabIndex) {
    return Builder(
      builder: (context) {
        final TabController? controller = DefaultTabController.of(context);
        final bool isSelected = controller?.index == tabIndex;

        return Container(
        
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6), // المسافات الداخلية
          decoration: BoxDecoration(


            color: isSelected ? Colors.green : Colors.transparent, // لون الخلفية
            borderRadius: BorderRadius.circular(20), // الحواف الدائرية
            border: isSelected
                ? null
                : Border.all(color: Colors.grey.shade400), // حدود للتبويبات غير المحددة
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? Colors.white : Colors.black, // لون النص
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }

  // ميثود لإنشاء قائمة إشعارات مخصصة
  Widget buildNotificationList(String type) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10, // عدد الإشعارات التجريبي
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: QColors.primaryBackground,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.notifications, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$type Notification ${index + 1}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "This is a detailed description of the notification.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.green),
              ],
            ),
          ),
        );
      },
    );
  }
}
