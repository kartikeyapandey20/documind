import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lottie/lottie.dart';

import '../widgets/chat_input_box.dart';

class SectionTextInput extends StatefulWidget {
  final String title;
  final String Document;
  const SectionTextInput({super.key, required this.title, required this.Document});

  @override
  State<SectionTextInput> createState() => _SectionTextInputState();
}

class _SectionTextInputState extends State<SectionTextInput> {
  final controller = TextEditingController();
  final gemini = Gemini.instance;
  String? searchedText, result;
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool set) => setState(() => _loading = set);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      result = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (searchedText != null)
          MaterialButton(
              color: Colors.blue.shade700,
              onPressed: () {
                setState(() {
                  searchedText = null;
                  result = null;
                });
              },
              child: Text('search: $searchedText')),
        Expanded(
            child: loading
                ? Lottie.asset('assets/lottie/ai.json')
                : result != null
                ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Markdown(data: result!),
            )
                : const Center(child: Text('Search something!'))),
        ChatInputBox(
          controller: controller,
          onSend: () {
            if (controller.text.isNotEmpty) {
              String prompt =
                  "You are A expert tender insight giver you give great insights and if user greets you with hii and hello or any other greeting you reply with the greeting and do not give answer straight away and say hii first and then user ask for summary then and then only give summary and also provide good summary and insight for following data . DATA : ${widget.Document}";
              searchedText = controller.text;
              controller.clear();
              loading = true;
              String finalText = prompt + searchedText!;
              gemini.text(finalText).then((value) {
                result = value?.content?.parts?.last.text;
                loading = false;
              });
            }
          },
        ),
      ],
    );
  }
}
