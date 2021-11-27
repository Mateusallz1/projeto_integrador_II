import 'package:flutter/material.dart';

class NotificationsUserPage extends StatefulWidget {
  const NotificationsUserPage({Key? key}) : super(key: key);

  @override
  State<NotificationsUserPage> createState() => _NotificationsUserPage();
}

class _NotificationsUserPage extends State<NotificationsUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: const Text('Notificações'),
      ),
    );
  }
}
