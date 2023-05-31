import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:presmaflix/app/models/content.dart';
import 'package:presmaflix/ui/widgets/poster_widget.dart';

class WatchListPage extends StatelessWidget {
  const WatchListPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Content> contents = Content.contents;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Watchlist',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
            ),
          ),
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          shadowColor: Colors.grey,
          elevation: 0.5,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          itemCount: contents.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: _cardContent(contents, index),
          ),
        ),
      ),
    );
  }

  Align _cardContent(List<Content> contents, int index) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PosterWidget(
            content: contents[index],
            isThumbnail: true,
            height: 100,
            width: 170,
            isRedirect: true,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              contents[index].title,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
