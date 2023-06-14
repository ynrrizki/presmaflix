// import 'package:cached_network_image/cached_network_image.dart';
// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/app/bloc/blocs.dart';
import 'package:presmaflix/app/bloc/watchlist/watchlist_bloc.dart';
import 'package:presmaflix/app/models/content/content.dart';
// import 'package:presmaflix/app/models/watchlist/watchlist.dart';
import 'package:presmaflix/config/themes.dart';
import 'package:presmaflix/ui/widgets/widgets.dart';
import 'package:presmaflix/config/routing/argument/arguments.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class WatchListPage extends StatefulWidget {
  const WatchListPage({super.key});

  @override
  State<WatchListPage> createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage> {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Watchlist',
            style: GoogleFonts.montserrat(
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
        body: BlocBuilder<WatchlistBloc, WatchlistState>(
          bloc: context.read<WatchlistBloc>()..add(LoadWatchlists()),
          buildWhen: (previous, current) => current is WatchlistLoaded,
          builder: (context, state) {
            if (state is WatchlistLoaded) {
              if (state.watchlists
                  .where((watchlist) => watchlist.userId == user.id)
                  .isNotEmpty) {
                return ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  children: state.watchlists
                      .where((watchlist) => watchlist.userId == user.id)
                      .map((watchlist) {
                    return BlocBuilder<ContentBloc, ContentState>(
                      bloc: context.read<ContentBloc>()..add(LoadContents()),
                      builder: (context, state) {
                        if (state is ContentLoaded) {
                          List<Content> filteredContents = state.contents
                              .where((content) =>
                                  content.id == watchlist.contentId)
                              .toList();
                          if (filteredContents.isNotEmpty) {
                            Content content = filteredContents.first;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 2),
                                curve: Curves.fastOutSlowIn,
                                child: _CardContent(
                                  content: content,
                                ),
                              ),
                            );
                          }
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.my_library_books_outlined,
                      size: 50,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Your list is empty',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Add any content you like to the list so it's easier for you to find and watch it",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 180, 180, 180),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                  const SizedBox(height: 15),
                  // const Text('Watchlist Loaded'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final Content content;

  const _CardContent({
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pushNamed(
          '/content-detail',
          arguments: ContentDetailArguments(content: content),
        );
      },
      child: Slidable(
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: const Color.fromARGB(255, 32, 32, 32),
            shadowColor: const Color.fromARGB(255, 61, 61, 61),
            elevation: 5,
            child: Slidable(
              key: const ValueKey(0),
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {},
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: Icons.share,
                    label: 'Share',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      context
                          .read<WatchlistBloc>()
                          .add(DeleteWatchlistByContentId(content.id));
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PosterWidget(
                      content: content,
                      isThumbnail: true,
                      height: 150,
                      width: 170,
                      isRedirect: false,
                    ),
                    const SizedBox(height: 17),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 0,
                        bottom: 25,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            content.title,
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Slide to expand",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 180, 180, 180),
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.swipe_left,
                                  color: Color.fromARGB(255, 180, 180, 180),
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
