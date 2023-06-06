import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/app/models/content.dart';
import 'package:presmaflix/ui/widgets/poster_widget.dart';
import 'package:presmaflix/config/routing/argument/content/content_detail_args.dart';

class WatchListPage extends StatefulWidget {
  const WatchListPage({super.key});

  @override
  State<WatchListPage> createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage> {
  List<Content> contents = Content.contents;
  List<bool> selectedItems = [];
  bool isLongPress = false;

  @override
  void initState() {
    super.initState();
    selectedItems = List.generate(contents.length, (index) => false);
  }

  bool get hasSelectedItems {
    return selectedItems.any((item) => item);
  }

  @override
  Widget build(BuildContext context) {
    log(isLongPress.toString());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Watchlist',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),
          ),
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          shadowColor: Colors.grey,
          elevation: 0.5,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 0),
          itemCount: contents.length,
          itemBuilder: (context, index) => GestureDetector(
            onLongPress: () {
              setState(() {
                isLongPress = true;
                selectedItems[index] = true;
              });
            },
            onTap: () {
              if (isLongPress) {
                setState(() {
                  if (hasSelectedItems) {
                    // Jika ada item yang terpilih, maka item yang ditekan akan berubah statusnya
                    selectedItems[index] = !selectedItems[index];
                  } else {
                    // Jika tidak ada item yang terpilih, maka item yang ditekan akan diarahkan ke detail
                    isLongPress = false;
                  }
                });
              } else {
                hasSelectedItems
                    ? null
                    : Navigator.of(context, rootNavigator: true).pushNamed(
                        '/content-detail',
                        arguments:
                            ContentDetailArguments(content: contents[index]),
                      );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: _CardContent(
                content: contents[index],
                isLongPress: isLongPress,
                isSelected: selectedItems[index],
                hasSelected: selectedItems.contains(true),
                onTap: () {
                  setState(() {
                    selectedItems[index] = !selectedItems[index];
                  });
                },
              ),
            ),
          ),
        ),
        floatingActionButton: hasSelectedItems
            ? FloatingActionButton(
                backgroundColor: Colors.primaries[0],
                onPressed: () {
                  // Tampilkan item yang terpilih
                  List<Content> selectedContent = [];
                  for (int i = 0; i < selectedItems.length; i++) {
                    if (selectedItems[i]) {
                      selectedContent.add(contents[i]);
                    }
                  }
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Items Selected'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: selectedContent
                            .map((content) => Text(content.title))
                            .toList(),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Icon(Icons.check),
              )
            : null,
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final Content content;
  final bool isLongPress;
  final bool isSelected;
  final bool hasSelected;
  final VoidCallback onTap;

  const _CardContent({
    required this.content,
    required this.isLongPress,
    required this.isSelected,
    required this.hasSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (isLongPress && hasSelected)
              Checkbox(
                activeColor: Colors.primaries[0],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                value: isSelected,
                onChanged: (_) => onTap(),
              ),
            PosterWidget(
              content: content,
              isThumbnail: true,
              height: 100,
              width: 170,
              isRedirect: false,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                content.title,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
