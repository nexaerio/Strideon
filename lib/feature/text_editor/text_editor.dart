/*
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class TextEditorScreen extends StatefulWidget {
  const TextEditorScreen({super.key});

  @override
  State<TextEditorScreen> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditorScreen> {
  @override
  Widget build(BuildContext context) {
    QuillController _controller = QuillController.basic();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                // height: SDeviceUtils.getScreenHeight(context) * 0.25,
                width: double.infinity,
                child: QuillToolbar.simple(
                    configurations: QuillSimpleToolbarConfigurations(
                  controller: _controller,
                  showCodeBlock: true,
                )),
              ),
              Expanded(
                  child: QuillEditor.basic(
                      configurations: QuillEditorConfigurations(
                controller: _controller,
                padding: const EdgeInsets.all(8),
                readOnly: false,
                scrollable: true,
                expands: false,
                autoFocus: false,
              ))),
              Text('Working on it.....'),
            ],
          ),
        ),
      ),
    );
  }
}
*/
