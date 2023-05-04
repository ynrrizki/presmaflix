import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/app/models/content.dart';
import 'package:presmaflix/ui/widgets/poster_widget.dart';
import 'package:presmaflix/ui/widgets/detail_tabbar_widget.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.content,
  });

  final Content content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // stack poster image
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(content.thumbnailUrl),
                      fit: BoxFit.cover,
                      opacity: 0.2,
                    ),
                  ),
                  height: 170,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: PosterWidget(
                      content: content,
                      height: 170,
                      width: 125,
                      isRedirect: false,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 25,
            ),
            // title
            Text(
              style: GoogleFonts.plusJakartaSans(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
              content.title,
            ),
            const SizedBox(
              height: 25,
            ),
            // genre
            SizedBox(
              // color: Colors.amber,
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 1.5,
                        horizontal: 5,
                      ),
                      child: Text(
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                        ),
                        '13+',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                    ),
                    content.genre.join(' • '),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // button play
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.play_arrow,
                      ),
                      Text(
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.bold,
                        ),
                        'Play Now',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    content.description,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            // tabbar
            const DetailTabBarWidget(),
          ],
        ),
      ),
    );
  }
}