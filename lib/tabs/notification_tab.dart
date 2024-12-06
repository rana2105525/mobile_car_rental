import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:mobile_car_rental/models/notificationItem_model.dart';
import 'package:mobile_car_rental/screens/home_screen.dart';
import 'package:mobile_car_rental/screens/profile_screen.dart';
import 'package:mobile_car_rental/screens/settings_screen.dart';

class NotificationTab extends StatefulWidget {
  @override
  _NotificationTabState createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  List<NotificationItem> notifications = [
    NotificationItem(
        "New notification 1", DateTime.now(), NotificationStatus.newItem),
    NotificationItem(
        "Yesterday's notification",
        DateTime.now().subtract(Duration(days: 1)),
        NotificationStatus.yesterday),
    NotificationItem("Older notification",
        DateTime.now().subtract(Duration(days: 3)), NotificationStatus.older),
    NotificationItem(
        "Another new notification", DateTime.now(), NotificationStatus.newItem),
    NotificationItem("Some older notification",
        DateTime.now().subtract(Duration(days: 5)), NotificationStatus.older),
  ];

  List<NotificationItem> getNotificationsForToday() {
    DateTime today = DateTime.now();
    return notifications.where((notification) {
      return notification.date.year == today.year &&
          notification.date.month == today.month &&
          notification.date.day == today.day;
    }).toList();
  }

  List<NotificationItem> getNotificationsForYesterday() {
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    return notifications.where((notification) {
      return notification.date.year == yesterday.year &&
          notification.date.month == yesterday.month &&
          notification.date.day == yesterday.day;
    }).toList();
  }

  List<NotificationItem> getNotificationsForOlder() {
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    return notifications.where((notification) {
      return notification.date.isBefore(yesterday);
    }).toList();
  }

  String getFormattedDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String getFormattedTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  // Header Section
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Notifications",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Notification List View
          ListView(
            padding: EdgeInsets.only(
                bottom: 70), // Leave space for the bottom nav bar
            children: [
              _buildHeader(), // Display the header here
              Padding(
                padding: const EdgeInsets.all(8.0),
              ),
              if (getNotificationsForToday().isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Today",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                ...getNotificationsForToday().map((notification) {
                  int index = notifications.indexOf(notification);
                  return Dismissible(
                    key: Key(notification.message),
                    onDismissed: (direction) {
                      setState(() {
                        notifications.removeAt(index);
                      });
                    },
                    background: Container(color: Colors.grey),
                    child: NotificationCard(notification: notification),
                  );
                }).toList(),
              ],
              if (getNotificationsForYesterday().isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Yesterday",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                ...getNotificationsForYesterday().map((notification) {
                  int index = notifications.indexOf(notification);
                  return Dismissible(
                    key: Key(notification.message),
                    onDismissed: (direction) {
                      setState(() {
                        notifications.removeAt(index);
                      });
                    },
                    background: Container(color: Colors.grey),
                    child: NotificationCard(notification: notification),
                  );
                }).toList(),
              ],
              if (getNotificationsForOlder().isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Older",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                ...getNotificationsForOlder().map((notification) {
                  int index = notifications.indexOf(notification);
                  return Dismissible(
                    key: Key(notification.message),
                    onDismissed: (direction) {
                      setState(() {
                        notifications.removeAt(index);
                      });
                    },
                    background: Container(color: Colors.grey),
                    child: NotificationCard(notification: notification),
                  );
                }).toList(),
              ],
            ],
          ),
          // Bottom Navigation Bar positioned at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomNavBar(),
          ),
        ],
      ),
    );
  }

  // Bottom Navigation Bar
  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: const Color.fromARGB(255, 66, 66, 66),
          padding: const EdgeInsets.all(16),
          gap: 8,
          selectedIndex:
              1, // Set the default selected index to 1 (Notifications tab)
          onTabChange: (index) {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationTab()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
                break;
            }
          },
          tabs: const [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.notifications, text: 'Notifications'),
            GButton(icon: Icons.person, text: 'Profile'),
            GButton(icon: Icons.settings, text: 'Settings'),
          ],
        ),
      ),
    );
  }
}


class NotificationCard extends StatelessWidget {
  final NotificationItem notification;

  const NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Use Row to display date on the left and time on the right
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getFormattedDate(notification.date),
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                getFormattedTime(notification.date),
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          SizedBox(height: 8),
          // Notification container with black background and filling the screen width
          Container(
            width: double.infinity, // Fills the available width
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                  255, 24, 24, 24), // Black background for the notification
              borderRadius: BorderRadius.circular(30), // Border radius of 30
              border: Border.all(color: Color.fromARGB(255, 24, 24, 24)),
            ),
            child: Text(
              notification.message,
              style:
                  TextStyle(color: Colors.white), // White text for the message
            ),
          ),
        ],
      ),
    );
  }

  String getFormattedDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String getFormattedTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }
}
