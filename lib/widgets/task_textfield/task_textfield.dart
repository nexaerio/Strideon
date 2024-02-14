import 'package:flutter/material.dart';

class TaskTextField extends StatefulWidget {
  final int maxLines;

  final String text;

  final TextEditingController textController;

  const TaskTextField({
    super.key,
    required this.maxLines,
    required this.text,
    required this.textController,
  });

  @override
  State<TaskTextField> createState() => _TaskTextFieldState();
}

class _TaskTextFieldState extends State<TaskTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            TextFormField(
              controller: widget.textController,
              maxLines: widget.maxLines,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: widget.text,
              ),
            ),
          ],
        ));
  }
}
