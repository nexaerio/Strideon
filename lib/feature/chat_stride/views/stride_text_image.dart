import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:strideon/core/firebase/get_name.dart';
import 'package:strideon/feature/chat_stride/views/stride_text.dart';
import 'package:strideon/utils/constants/colors.dart';

class StrideImageChat extends StatefulWidget {
  const StrideImageChat({
    super.key,
  });

  @override
  State<StrideImageChat> createState() => _StrideChatState();
}

class _StrideChatState extends State<StrideImageChat> {
  bool loading = false;
  List textAndImageChat = [];
  File? imageFile;

  final ImagePicker picker = ImagePicker();

  final TextEditingController _textController = TextEditingController();
  final ScrollController _controller = ScrollController();

  // Create Gemini Instance
  final gemini = GoogleGemini(
    apiKey: apiKey,
  );

  // Text only input
  void fromTextAndImage({required String query, required File image}) {
    setState(() {
      loading = true;
      textAndImageChat.add({
        "role": "User",
        "text": query,
        "image": image,
      });
      _textController.clear();
      imageFile = null;
    });
    scrollToTheEnd();

    gemini.generateFromTextAndImages(query: query, image: image).then((value) {
      setState(() {
        loading = false;
        textAndImageChat
            .add({"role": "Stride", "text": value.text, "image": ""});
      });
      scrollToTheEnd();
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
        textAndImageChat
            .add({"role": "Stride", "text": error.toString(), "image": ""});
      });
      scrollToTheEnd();
    });
  }

  void scrollToTheEnd() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (textAndImageChat.isEmpty) ...[
              Expanded(
                  flex: 10,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const GetName(),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('Ask me a question :)',
                            style: Theme.of(context).textTheme.headlineMedium),

                        // color: SColors.buttonPrimary, fontSize: 20),
                      ],
                    ),
                  ))
            ],
            Expanded(
              child: ListView.builder(
                controller: _controller,
                itemCount: textAndImageChat.length,
                padding: const EdgeInsets.only(bottom: 20),
                itemBuilder: (context, index) {
                  return ListTile(
                    isThreeLine: true,
                    leading: CircleAvatar(
                      child:
                          Text(textAndImageChat[index]["role"].substring(0, 1)),
                    ),
                    title: Text(textAndImageChat[index]["role"]),
                    subtitle: SelectableText(textAndImageChat[index]["text"]),
                    trailing: textAndImageChat[index]["image"] == ""
                        ? null
                        : Image.file(
                            textAndImageChat[index]["image"],
                            width: 90,
                          ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 26),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () async {
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        imageFile = image != null ? File(image.path) : null;
                      });
                    },
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/icons/icon-attachment.png',
                          color: const Color(0xFF7B56EB)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: TextFormField(
                    controller: _textController,
                    minLines: 1,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 14),
                    decoration: InputDecoration(
                        hintText: 'Write a Message',
                        contentPadding: const EdgeInsets.only(
                            left: 20, top: 10, bottom: 10),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(height: 0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: loading
                              ? const CircularProgressIndicator()
                              : InkWell(
                                  onTap: () {
                                    if (imageFile == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Please select an image")));
                                      return;
                                    }
                                    fromTextAndImage(
                                        query: _textController.text,
                                        image: imageFile!);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).brightness ==
                                                Brightness.light
                                            ? SColors.primaryBackground
                                            : SColors.darkContainer,
                                    child: SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: Center(
                                        child: Image.asset(
                                          'assets/icons/icon-send.png',
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? const Color(0xFFA186F1)
                                              : SColors.primaryBackground,
                                          scale: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        )),
                    onChanged: (value) {},
                  )),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: imageFile != null
          ? Container(
              margin: const EdgeInsets.only(bottom: 80),
              height: 150,
              child: Image.file(imageFile ?? File("")),
            )
          : null,
    );
  }
}
