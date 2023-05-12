import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/app/models/content.dart';
import 'package:presmaflix/ui/controller/custom_tabbar_controller.dart';
import 'package:presmaflix/ui/widgets/poster_widget.dart';

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
      body: CustomTabBarController(
        header: Column(
          children: [
            _posterImage(
              content,
            ),
            const SizedBox(
              height: 25,
            ),
            _title(
              content.title,
            ),
            const SizedBox(
              height: 25,
            ),
            _genre(
              content.genre.join(' • '),
            ),
            const SizedBox(
              height: 25,
            ),
            _buttonPlay(context),
            const SizedBox(
              height: 25,
            ),
            _description(
              content.description,
            ),
            const SizedBox(
              height: 25,
            ),
            _watchlistAndShareBtn(),
            const SizedBox(
              height: 25,
            ),
            _directsAndCasts(
              content.directors.join(', '),
              content.casts.join(', '),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
        tabCount: 2,
        tabs: const [
          Tab(
            text: 'Trailer',
          ),
          Tab(
            text: 'Similar',
          )
        ],
        tabBarViews: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index % 2 == 0) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  height: 100,
                  color: Colors.blue,
                );
              }
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                height: 100,
                color: Colors.red,
              );
            },
            itemCount: 100,
          ),
          Column(
            children: const [
              Text('Tab 2'),
            ],
          ),
        ],
      ),
    );
  }

  // ===============================

  Padding _watchlistAndShareBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.bookmark,
            ),
            label: const Text('Daftarku'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
            ),
            label: const Text('Daftarku'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _directsAndCasts(String directors, String casts) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Directs: ',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                directors,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Casts: ',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                casts,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding _description(String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            description,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Padding _buttonPlay(BuildContext context) {
    return Padding(
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
              const SizedBox(width: 15),
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
    );
  }

  SizedBox _genre(String genre) {
    return SizedBox(
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
            genre,
          )
        ],
      ),
    );
  }

  Text _title(String title) {
    return Text(
      style: GoogleFonts.plusJakartaSans(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
      title,
    );
  }

  Stack _posterImage(Content content) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                content.thumbnailUrl,
              ),
              fit: BoxFit.cover,
              opacity: 0.2,
            ),
          ),
          height: 170,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 45),
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
    );
  }
}
