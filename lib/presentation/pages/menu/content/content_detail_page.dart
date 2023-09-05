// import 'dart:developer';
import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/presentation/bloc/blocs.dart';
import 'package:presmaflix/presentation/bloc/rating/rating_bloc.dart';
import 'package:presmaflix/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:presmaflix/presentation/cubits/content_detail/view_more/view_more_cubit.dart';
import 'package:presmaflix/presentation/cubits/watchlist/watchlist_cubit.dart'
    as watchlist_cubit;
import 'package:presmaflix/data/models/content/content.dart';
import 'package:presmaflix/data/models/rating/rating.dart';
import 'package:presmaflix/data/models/user/user.dart';
import 'package:presmaflix/data/models/video/video.dart';
import 'package:presmaflix/presentation/routes/argument/arguments.dart';
import 'package:presmaflix/presentation/config/themes_config.dart';
import 'package:presmaflix/presentation/widgets/content_detail_description_widget.dart';
import 'package:presmaflix/presentation/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ContentDetailPage extends StatefulWidget {
  const ContentDetailPage({
    super.key,
    required this.content,
  });

  final Content content;

  @override
  State<ContentDetailPage> createState() => _ContentDetailPageState();
}

class _ContentDetailPageState extends State<ContentDetailPage> {
  List<Video> videos = [];
  List<Content> contents = [];
  List<String> tabTypes = [];
  bool isFirstLoad = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoBloc, VideoState>(
      listener: (context, state) {
        if (state is VideoLoaded && isFirstLoad) {
          setState(() {});
          isFirstLoad = false;
          videos = state.videos;
        }
      },
      listenWhen: (previous, current) => current is VideoLoaded,
      buildWhen: (previous, current) => current != previous,
      bloc: context.read<VideoBloc>()
        ..add(
          LoadVideosByContent(widget.content),
        ),
      builder: (context, state) {
        if (state is VideoLoading) {
          return _skleton(context);
        } else if (state is VideoLoaded) {
          // videos = state.videos;
          log((_generateTab(videos, tabTypes).length).toString(),
              name: 'generateTabe.length');
          log((_generateTab(videos, tabTypes).length + 1).toString(),
              name: 'generateTabe.length + 1');
          return Scaffold(
            extendBodyBehindAppBar: true,
            extendBody: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              forceMaterialTransparency: true,
              actionsIconTheme: const IconThemeData(
                color: Colors.white,
              ),
              foregroundColor: Colors.white,
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              leading: const BackButton(
                color: Colors.white,
              ),
            ),
            body: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 1110,
                ),
                child: TabBarController(
                  header: Column(
                    children: [
                      _posterImage(
                        widget.content,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      _title(
                        widget.content.title,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      _genre(
                        widget.content.genre.join(' • '),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _RatingWidget(content: widget.content),
                      const SizedBox(
                        height: 25,
                      ),
                      _buttonPlay(
                        context,
                        video: state.videos.firstWhereOrNull(
                            (video) => video.type == 'full-length'),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      _description(
                        widget.content.description,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      _actionsBtn(context),
                      const SizedBox(
                        height: 25,
                      ),
                      _directsAndCasts(
                        widget.content.directors.join(', '),
                        widget.content.casts.join(', '),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                  tabCount: _generateTab(videos, tabTypes).length + 1,
                  tabs: _generateTabs(videos, tabTypes),
                  tabBarViews: _generateTabViews(videos, tabTypes),
                ),
              ),
            ),
          );
        }
        return _skleton(context);
      },
    );
  }

  Scaffold _skleton(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 1110,
          ),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                _posterImage(widget.content, isShimmer: true),
                const SizedBox(
                  height: 25,
                ),
                _title(widget.content.title, isShimmer: true),
                const SizedBox(
                  height: 25,
                ),
                _genre(widget.content.genre.join(' • '), isShimmer: true),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  height: 10,
                ),
                Shimmer.fromColors(
                  baseColor: const Color.fromARGB(123, 121, 121, 121),
                  highlightColor: const Color.fromARGB(255, 128, 128, 128),
                  child: _RatingWidget(content: widget.content),
                ),
                const SizedBox(
                  height: 25,
                ),
                _buttonPlay(
                  context,
                  video: videos.isEmpty
                      ? null
                      : videos
                          .where((video) => video.type == 'full-length')
                          .single,
                  isShimmer: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                _description(widget.content.description, isShimmer: true),
                const SizedBox(
                  height: 25,
                ),
                _actionsBtn(context, isShimmer: true),
                const SizedBox(
                  height: 25,
                ),
                _directsAndCasts(widget.content.directors.join(', '),
                    widget.content.casts.join(', '),
                    isShimmer: true),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabSimilar(List<Content> contents) {
    return BlocBuilder<ContentBloc, ContentState>(
      builder: (context, state) {
        if (state is ContentLoaded) {
          contents = state.contents;
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
              itemBuilder: (context, index) =>
                  AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: contents.length,
                delay: const Duration(milliseconds: 200),
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: PosterWidget(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/content-detail',
                          arguments: ContentDetailArguments(
                            content: contents[index],
                          ),
                        );
                      },
                      content: contents[index],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        );
      },
    );
  }

  List<Tab> _generateTabs(List<Video> videos, List<String> tabTypes) {
    final List<Tab> tabs = _generateTab(videos, tabTypes);
    tabs.add(const Tab(text: 'Similar'));
    return tabs;
  }

  List<Widget> _generateTabViews(List<Video> videos, List<String> tabTypes) {
    final List<Widget> tabViews = _generateTabView(videos, tabTypes);
    tabViews.add(_tabSimilar(contents));
    return tabViews;
  }

  List<Widget> _generateTabView(List<Video> videos, List<String> tabTypes) {
    // Menampilkan video berdasarkan tipe
    // tampilkan video yang berasosiasi dengan content.id dan memiliki tipe yang sama dengan Tab
    return videos
        .where((video) =>
            video.contentId == widget.content.id && video.type != 'full-length')
        .fold<List<Widget>>(
      [],
      (list, video) {
        // Jika tipe video sama dengan tipe Tab, tambahkan video ke List<Video>
        if (video.type == tabTypes[list.length]) {
          // conver to ListView.builder
          list.add(
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 0),
              children: [
                ...videos
                    .where(
                      (video) =>
                          video.contentId == widget.content.id &&
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
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 16,
                              ),
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
            video.contentId == widget.content.id && video.type != 'full-length')
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

  Widget _actionsBtn(BuildContext context, {bool isShimmer = false}) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    if (!isShimmer) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _WatchlistBtn(widget: widget, user: user),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton.icon(
                  onPressed: () => _ratingModal(
                    context,
                    content: widget.content,
                    user: user,
                  ),
                  icon: const Icon(
                    Icons.star,
                  ),
                  label: const Text('Rating'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => _moreModalBottomSheet(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: const BorderSide(color: Colors.white),
              ),
              child: const Icon(Icons.more_horiz),
            )
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: const Color.fromARGB(123, 121, 121, 121),
                highlightColor: const Color.fromARGB(255, 128, 128, 128),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark,
                  ),
                  label: const Text('My List'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Shimmer.fromColors(
                baseColor: const Color.fromARGB(123, 121, 121, 121),
                highlightColor: const Color.fromARGB(255, 128, 128, 128),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                  ),
                  label: const Text('Share'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(123, 121, 121, 121),
            highlightColor: const Color.fromARGB(255, 128, 128, 128),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.white),
              ),
              child: const Icon(Icons.file_download_outlined),
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> _ratingModal(BuildContext context,
      {required Content content, required User user}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rate this Content', textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                BlocBuilder<RatingBloc, RatingState>(
                  bloc: context.read<RatingBloc>()
                    ..add(LoadRatingByUser(user.id, content.id)),
                  buildWhen: (previous, current) =>
                      current is RatingByUserLoaded,
                  builder: (context, state) {
                    if (state is RatingByUserLoaded) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RatingBar(
                            allowHalfRating: true,
                            itemSize: 35,
                            glow: false,
                            ratingWidget: RatingWidget(
                              full: const Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              half: const Icon(
                                Icons.star_half,
                                color: Colors.orange,
                              ),
                              empty: const Icon(
                                Icons.star_border,
                                color: Colors.orange,
                              ),
                            ),
                            initialRating: state.rating.rating ?? 0.0,
                            onRatingUpdate: (value) {
                              HapticFeedback.vibrate();
                              context.read<RatingBloc>().add(
                                    AddRating(
                                      rating: const Rating().copyWith(
                                        id: state.rating.id,
                                        contentId: widget.content.id,
                                        userId: user.id,
                                        email: user.email!,
                                        rating: value,
                                      ),
                                    ),
                                  );
                            },
                          ),
                        ],
                      );
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // const SizedBox(height: 7.5),
                        RatingBar(
                          allowHalfRating: true,
                          itemSize: 35,
                          ignoreGestures: true,
                          ratingWidget: RatingWidget(
                            full: const Icon(
                              Icons.star,
                              color: Colors.orange,
                            ),
                            half: const Icon(
                              Icons.star_half,
                              color: Colors.orange,
                            ),
                            empty: const Icon(
                              Icons.star_border,
                              color: Colors.orange,
                            ),
                          ),
                          initialRating: 0.0,
                          onRatingUpdate: (value) {
                            HapticFeedback.vibrate();
                            context.read<RatingBloc>().add(
                                  AddRating(
                                    rating: const Rating().copyWith(
                                      contentId: widget.content.id,
                                      email: user.email,
                                      rating: value,
                                    ),
                                  ),
                                );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Future<dynamic> _moreModalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    showDragHandle: true,
    constraints: const BoxConstraints(
      maxHeight: 200,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Card(
                  child: ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.download),
                    title: const Text('Download'),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      Share.share(
                          'http://play.google.com/store/apps/details?id=com.smkprestasiprima.presmaflix');
                    },
                    leading: const Icon(Icons.share),
                    title: const Text('Share'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Widget _directsAndCasts(String directors, String casts,
    {bool isShimmer = false}) {
  if (!isShimmer) {
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
  return Shimmer.fromColors(
    baseColor: const Color.fromARGB(123, 121, 121, 121),
    highlightColor: const Color.fromARGB(255, 128, 128, 128),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
                height: 15,
                width: 50,
              ),
              const SizedBox(width: 5),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
                height: 15,
                width: 50,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
                height: 15,
                width: 50,
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
                height: 15,
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
                height: 15,
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
                height: 15,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _description(String description, {bool isShimmer = false}) {
  if (!isShimmer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<ViewMoreCubit, bool>(
        builder: (context, state) {
          return ContentDetailDescriptionWidget(
            description: description,
            state: state,
          );
        },
      ),
    );
  }
  return Shimmer.fromColors(
    baseColor: const Color.fromARGB(123, 121, 121, 121),
    highlightColor: const Color.fromARGB(255, 128, 128, 128),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
            height: 15,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
            height: 15,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
            height: 15,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
            height: 15,
            width: 200,
          ),
        ],
      ),
    ),
  );
}

Widget _buttonPlay(BuildContext context,
    {Video? video, bool isShimmer = false}) {
  if (!isShimmer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ZoomTapAnimation(
        child: ElevatedButton(
          onPressed: () => video != null
              ? Navigator.of(context).pushNamed("/content-video",
                  arguments: ContentVideoArguments(video: video))
              : null,
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
      ),
    );
  }
  return Shimmer.fromColors(
    baseColor: const Color.fromARGB(123, 121, 121, 121),
    highlightColor: const Color.fromARGB(255, 128, 128, 128),
    child: Padding(
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
    ),
  );
}

Widget _genre(String genre, {bool isShimmer = false}) {
  if (!isShimmer) {
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
  return Shimmer.fromColors(
    baseColor: const Color.fromARGB(123, 121, 121, 121),
    highlightColor: const Color.fromARGB(255, 128, 128, 128),
    child: SizedBox(
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
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
            height: 15,
            width: 50,
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
            height: 15,
            width: 50,
          ),
        ],
      ),
    ),
  );
}

Widget _title(String title, {bool isShimmer = false}) {
  if (!isShimmer) {
    return Text(
      style: GoogleFonts.plusJakartaSans(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
      title,
    );
  }
  return Shimmer.fromColors(
    baseColor: const Color.fromARGB(123, 121, 121, 121),
    highlightColor: const Color.fromARGB(255, 128, 128, 128),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1),
      ),
      height: 17,
      width: 100,
    ),
  );
}

Widget _posterImage(Content content, {bool isShimmer = false}) {
  if (!isShimmer) {
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
            child: Hero(
              tag: 'videoPlayer',
              child: PosterWidget(
                content: content,
                height: 170,
                width: 125,
                isRedirect: false,
              ),
            ),
          ),
        ),
      ],
    );
  }
  return Shimmer.fromColors(
    baseColor: const Color.fromARGB(123, 121, 121, 121),
    highlightColor: const Color.fromARGB(255, 128, 128, 128),
    child: Stack(
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
    ),
  );
}

class _WatchlistBtn extends StatelessWidget {
  const _WatchlistBtn({
    required this.widget,
    required this.user,
  });

  final ContentDetailPage widget;
  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      buildWhen: (previous, current) => current is IsWatchlistExistsLoaded,
      bloc: context.read<WatchlistBloc>()
        ..add(LoadIsWatchlistExists(widget.content.id, user.id)),
      builder: (context, state) {
        if (state is IsWatchlistExistsLoaded) {
          return state.isExists
              ? ElevatedButton.icon(
                  onPressed: () {
                    context
                        .read<WatchlistBloc>()
                        .add(DeleteWatchlistByContentId(widget.content.id));
                    HapticFeedback.vibrate();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        action: SnackBarAction(
                          onPressed: () {},
                          label: 'Okay',
                        ),
                        content: Text(
                          "Content Removed from My List",
                          style: const TextStyle().copyWith(
                            color: Colors.white,
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.bookmark_added,
                  ),
                  label: const Text('My List'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    disabledForegroundColor: Colors.blue,
                    side: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                )
              : ElevatedButton.icon(
                  onPressed: () {
                    context
                        .read<watchlist_cubit.WatchlistCubit>()
                        .isWatchlistExists(
                            contentId: widget.content.id, userId: user.id);
                    HapticFeedback.vibrate();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        action: SnackBarAction(
                            label: 'View',
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushReplacementNamed(
                                '/watchlist',
                              );
                            }),
                        content: Text(
                          "Content Added to My List",
                          style: const TextStyle().copyWith(
                            color: Colors.white,
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.bookmark,
                  ),
                  label: const Text('My List'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                );
        }
        return ElevatedButton.icon(
          onPressed: () {
            context.read<watchlist_cubit.WatchlistCubit>().isWatchlistExists(
                contentId: widget.content.id, userId: user.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                action: SnackBarAction(
                    label: 'View',
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(
                        '/watchlist',
                      );
                    }),
                content: Text(
                  "Content Added to My List",
                  style: const TextStyle().copyWith(
                    color: Colors.white,
                  ),
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          icon: const Icon(
            Icons.bookmark,
          ),
          label: const Text('My List'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            side: const BorderSide(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

class _RatingWidget extends StatelessWidget {
  final Content content;
  const _RatingWidget({
    // super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatingBloc, RatingState>(
      bloc: context.read<RatingBloc>()..add(LoadRating(content.id)),
      buildWhen: (previous, current) => current is RatingLoaded,
      builder: (context, state) {
        if (state is RatingLoaded) {
          return Column(
            children: [
              Chip(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                labelPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.orange,
                    style: BorderStyle.none,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                side: BorderSide.none,
                label: Text(
                  state.rating.toString(),
                  style: GoogleFonts.poppins(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              // const SizedBox(height: 7.5),
              RatingBar(
                allowHalfRating: true,
                itemSize: 17,
                ignoreGestures: true,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  half: const Icon(
                    Icons.star_half,
                    color: Colors.orange,
                  ),
                  empty: const Icon(
                    Icons.star_border,
                    color: Colors.orange,
                  ),
                ),
                initialRating: state.rating,
                onRatingUpdate: (value) {},
              ),
            ],
          );
        }
        return Column(
          children: [
            Chip(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.orange,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text(
                0.0.toString(),
                style: GoogleFonts.poppins(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            // const SizedBox(height: 7.5),
            RatingBar(
              allowHalfRating: true,
              itemSize: 17,
              ignoreGestures: true,
              ratingWidget: RatingWidget(
                full: const Icon(
                  Icons.star,
                  color: Colors.orange,
                ),
                half: const Icon(
                  Icons.star_half,
                  color: Colors.orange,
                ),
                empty: const Icon(
                  Icons.star_border,
                  color: Colors.orange,
                ),
              ),
              initialRating: 0.0,
              onRatingUpdate: (value) {},
            ),
          ],
        );
      },
    );
  }
}
