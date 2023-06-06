import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/app/models/content.dart';
import 'package:presmaflix/ui/widgets/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ContentAllPage extends StatelessWidget {
  const ContentAllPage(
      {super.key, required this.title, required this.contents});
  final String title;
  final List<Content> contents;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        shadowColor: Colors.grey,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 25),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.7,
            mainAxisSpacing: 16,
            crossAxisSpacing: 7,
          ),
          itemCount: contents.length,
          itemBuilder: (context, index) => AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 375),
            columnCount: contents.length,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: PosterWidget(
                  content: contents[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
