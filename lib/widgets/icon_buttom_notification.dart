import 'package:flutter/material.dart';
import 'package:flutter_dignal_2025/providers/devices_provider.dart';
import 'package:provider/provider.dart';

class IconButtomNotification extends StatefulWidget {
  const IconButtomNotification({
    super.key,
    required this.onPressed
  });

  final Function() onPressed;

  @override
  State<IconButtomNotification> createState() => _IconButtomNotificationState();
}

class _IconButtomNotificationState extends State<IconButtomNotification> {
  @override
  Widget build(BuildContext context) {

    final devicesProvider = Provider.of<DevicesProvider>(context);

    return IconButton(
      onPressed: () {
        setState(() {
          devicesProvider.notificationCounter = 0;
        });

        // _showModalBottomOpenai(context);
        widget.onPressed();
      },
      icon: Badge.count(
        count: devicesProvider.notificationCounter,
        child: Icon(Icons.terminal)
      )
    );
  }
}