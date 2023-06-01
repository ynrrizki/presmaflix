// import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/app/models/content.dart';
import 'package:presmaflix/app/models/video.dart';
import 'package:presmaflix/config/routing/argument/content/content_video_args.dart';
import 'package:presmaflix/ui/widgets/card_video_widget.dart';
import 'package:presmaflix/ui/widgets/tabbar_controller.dart';
import 'package:presmaflix/ui/widgets/poster_widget.dart';

class ContentDetailPage extends StatelessWidget {
  const ContentDetailPage({
    super.key,
    required this.content,
  });

  final Content content;

  @override
  Widget build(BuildContext context) {
    List<Video> videos = Video.videos;
    List<Content> contents = Content.contents;
    List<String> tabTypes = [];
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
      body: TabBarController(
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
            _buttonPlay(
              context,
              videos.where((video) => video.type == 'full-length').first,
            ),
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
        // Mengambil panjang tab video yang sudah di group dan ditambahkan angka satu
        // untuk Tab 'Similar'
        tabCount: _generateTab(videos, tabTypes).length + 1,
        tabs: [
          ..._generateTab(videos, tabTypes),
          const Tab(text: 'Similar'),
        ],
        tabBarViews: _generateTabView(videos, tabTypes)
          ..add(
            _tabSimilar(contents),
          ),
      ),
    );
  }

  Padding _tabSimilar(List<Content> contents) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 25),
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.7,
          mainAxisSpacing: 16,
          crossAxisSpacing: 7,
        ),
        itemCount: contents.length,
        itemBuilder: (context, index) => AnimationConfiguration.staggeredGrid(
          position: index,
          columnCount: contents.length,
          delay: const Duration(milliseconds: 200),
          child: ScaleAnimation(
            child: FadeInAnimation(
              child: PosterWidget(
                content: contents[index],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _generateTabView(List<Video> videos, List<String> tabTypes) {
    // Menampilkan video berdasarkan tipe
    // tampilkan video yang berasosiasi dengan content.id dan memiliki tipe yang sama dengan Tab
    return videos
        .where((video) =>
            video.mediaId == content.id && video.type != 'full-length')
        .fold<List<Widget>>(
      [],
      (list, video) {
        // Jika tipe video sama dengan tipe Tab, tambahkan video ke List<Video>
        if (video.type == tabTypes[list.length]) {
          // conver to ListView.builder
          list.add(
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              children: [
                ...videos
                    .where(
                      (video) =>
                          video.mediaId == content.id &&
                          video.type != 'full-length' &&
                          video.type == tabTypes[list.length],
                    )
                    .map(
                      (video) => AnimationConfiguration.staggeredList(
                        position: videos.indexOf(video),
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          horizontalOffset: -250.0,
                          curve: Curves.easeOutExpo,
                          child: FadeInAnimation(
                            child: CardVideoWidget(
                              video: video,
                              padding: const EdgeInsets.only(bottom: 20),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          );
        }
        return list;
      },
    );
  }

  List<Tab> _generateTab(List<Video> videos, List<String> tabTypes) {
    return videos
        // Mengambil video yang memenuhi kriteria
        // (berasosiasi dengan content.id dan memiliki tipe selain 'full-length')
        .where((video) =>
            video.mediaId == content.id && video.type != 'full-length')
        // Mengelompokkan video berdasarkan tipe dan membuat List<Tab> baru
        .fold<List<Tab>>([], (list, video) {
      // Jika tipe video belum ada pada List<Tab>, tambahkan Tab baru dengan tipe tersebut
      if (!list.any((tab) => tab.text == video.type)) {
        list.add(Tab(text: video.type));
        if (!tabTypes.contains(video.type)) {
          tabTypes.add(video.type);
        }
      }
      return list;
    });
  }

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
                  color: Colors.grey,
                ),
              ),
              Text(
                directors,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
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
                  color: Colors.grey,
                ),
              ),
              Text(
                casts,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
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
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Padding _buttonPlay(BuildContext context, Video video) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pushNamed("/content-video",
            arguments: ContentVideoArguments(video: video)),
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
            genre,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: Colors.grey,
            ),
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
                content.posterUrl,
              ),
              fit: BoxFit.cover,
              opacity: 0.2,
            ),
          ),
          height: 195,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 95),
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