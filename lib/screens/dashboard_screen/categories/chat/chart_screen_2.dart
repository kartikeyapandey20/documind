
import 'package:documind/screens/dashboard_screen/categories/chat/sections/chat.dart';
import 'package:documind/screens/dashboard_screen/categories/chat/sections/chat_stream.dart';
import 'package:documind/screens/dashboard_screen/categories/chat/sections/embed_batch_contents.dart';
import 'package:documind/screens/dashboard_screen/categories/chat/sections/embed_content.dart';
import 'package:documind/screens/dashboard_screen/categories/chat/sections/response_widget_stream.dart';
import 'package:documind/screens/dashboard_screen/categories/chat/sections/stream.dart';
import 'package:documind/screens/dashboard_screen/categories/chat/sections/text_and_image.dart';
import 'package:documind/screens/dashboard_screen/categories/chat/sections/text_only.dart';
import 'package:flutter/material.dart';

class SectionItem {
  final int index;
  final String title;
  final Widget widget;

  SectionItem(this.index, this.title, this.widget);
}

class MyHomePage extends StatefulWidget {
  final String title;
  final String document;
  const MyHomePage({super.key, required this.title, required this.document});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedItem = 4;
  List<SectionItem> _sections = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _sections.clear();
      _sections = [];
    });

  }
  @override
  Widget build(BuildContext context) {
    _sections = <SectionItem>[
      SectionItem(0, 'Stream text', SectionTextStreamInput()),
      SectionItem(1, 'textAndImage', const SectionTextAndImageInput()),
      SectionItem(2, 'chat', SectionChat()),
      SectionItem(3, 'Stream chat', const SectionStreamChat()),
      SectionItem(4, 'text', SectionTextInput(title: widget.title, Document: widget.document,)),
      SectionItem(5, 'embedContent',  SectionEmbedContent()),
      SectionItem(6, 'batchEmbedContents', const SectionBatchEmbedContents()),
      SectionItem(
          7, 'response without setState()', const ResponseWidgetSection()),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(widget.title
        ),
        actions: [
          PopupMenuButton<int>(
            initialValue: _selectedItem,
            onSelected: (value) => setState(() => _selectedItem = value),
            itemBuilder: (context) => _sections.map((e) {
              return PopupMenuItem<int>(value: e.index, child: Text(e.title));
            }).toList(),
            child: const Icon(Icons.more_vert_rounded),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:   [Colors.greenAccent , Color(0xFFFFFFFF)  ],
          ),
        ),
        child: IndexedStack(
          index: _selectedItem,
          children: _sections.map((e) => e.widget).toList(),
        ),
      ),
    );
  }
}
