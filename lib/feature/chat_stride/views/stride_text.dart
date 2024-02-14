import 'package:flutter/material.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:strideon/utils/constants/colors.dart';

const apiKey = "";

class StrideText extends StatefulWidget {
  const StrideText({Key? key}) : super(key: key);

  @override
  State<StrideText> createState() => _StrideTextState();
}

class _StrideTextState extends State<StrideText> {
  bool loading = false;
  List<Map<String, String>> textChat = [];
  final TextEditingController _textController = TextEditingController();

  final ScrollController _controller = ScrollController();

  // Create Gemini Instance
  final gemini = GoogleGemini(
    apiKey: apiKey,
  );

  // Text only input
  void fromText({required String query}) {
    setState(() {
      loading = true;
      textChat.add({
        "role": "User",
        "text": query,
      });
      _textController.clear();
    });
    scrollToTheEnd();

    gemini.generateFromText(query).then((value) {
      setState(() {
        loading = false;
        textChat.add({
          "role": "Stride",
          "text": value.text,
        });
      });
      scrollToTheEnd();
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
        textChat.add({
          "role": "Stride",
          "text": error.toString(),
        });
      });
      scrollToTheEnd();
    });
  }

  void scrollToTheEnd() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            controller: _controller,
            itemCount: textChat.length,
            padding: const EdgeInsets.only(bottom: 20),
            itemBuilder: (context, index) {
              return ListTile(
                isThreeLine: true,
                leading: CircleAvatar(
                  child: Text(textChat[index]["role"]!.substring(0, 1)),
                ),
                title: Text(textChat[index]["role"]!),
                subtitle: SelectableText(textChat[index]["text"]!),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView(
            // Wrap with SingleChildScrollView
            physics: const AlwaysScrollableScrollPhysics(),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
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
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                hintStyle:
                    Theme.of(context).textTheme.bodySmall!.copyWith(height: 0),
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
                            if (_textController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please add some text"),
                                ),
                              );
                              return;
                            }
                            fromText(query: _textController.text);
                          },
                          child: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).brightness == Brightness.light
                                    ? SColors.primaryBackground
                                    : SColors.darkContainer,
                            child: SizedBox(
                              height: 16,
                              width: 20,
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
              ),
              onChanged: (value) {},
            ),
          ),
        )
      ]),
    );
  }
}
