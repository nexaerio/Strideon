import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strideon/utils/constants/colors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    bool? value = false;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notification',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Row(
                children: [
                  Checkbox(value: value, onChanged: (value) {}),
                  Text('Mark as read',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(fontSizeFactor: 1.35)),
                  const SizedBox(
                    width: 110,
                  ),
                  GestureDetector(
                    child: const Row(
                      children: [
                        Text(
                          "Deleted",
                          style: TextStyle(color: SColors.error),
                        ),
                        Icon(
                          CupertinoIcons.delete,
                          color: SColors.error,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
