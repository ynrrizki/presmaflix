// import 'package:cached_network_image/cached_network_image.dart';
// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/app/bloc/blocs.dart';
import 'package:presmaflix/app/bloc/watchlist/watchlist_bloc.dart';
import 'package:presmaflix/app/models/content/content.dart';
import 'package:presmaflix/app/models/watchlist/watchlist.dart';
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
          buildWhen: (previous, current) => previous != current,
          bloc: context.read<WatchlistBloc>()..add(LoadWatchlists()),
          builder: (context, state) {
            if (state is WatchlistLoaded) {
              return ListView.builder(
                itemCount: state.watchlists.length,
                itemBuilder: (context, index) {
                  Watchlist watchlist = state.watchlists[index];
                  return BlocBuilder<ContentBloc, ContentState>(
                    bloc: context.read<ContentBloc>()..add(LoadContents()),
                    builder: (context, state) {
                      if (state is ContentLoaded) {
                        List<Content> filteredContents = state.contents
                            .where(
                                (content) => content.id == watchlist.contentId)
                            .toList();
                        if (filteredContents.isNotEmpty) {
                          Content content = filteredContents.first;
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(
                                '/content-detail',
                                arguments:
                                    ContentDetailArguments(content: content),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0),
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
                },
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

// class WatchListBody extends StatefulWidget {
//   const WatchListBody({super.key, this.watchlists = const <Watchlist>[]});

//   final List<Watchlist> watchlists;

//   @override
//   State<WatchListBody> createState() => _WatchListBodyState();
// }

// class _WatchListBodyState extends State<WatchListBody> {
//   List<Content> contents = [];
//   List<bool> selectedItems = [];
//   bool isLongPress = false;

//   @override
//   void initState() {
//     super.initState();
//     selectedItems = List.generate(widget.watchlists.length, (index) => false);
//   }

//   bool get hasSelectedItems {
//     return selectedItems.any((item) => item);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ContentBloc, ContentState>(
//       builder: (context, state) {
//         if (state is ContentLoaded) {
//           contents = state.contents;
//         }
//         return ListView(
//           padding: const EdgeInsets.symmetric(vertical: 0),
//           itemCount: widget.watchlists.length,
//           itemBuilder: (context, index) => ,
//         );
//       },
//     );
//   }
// }

class _CardContent extends StatelessWidget {
  final Content content;

  const _CardContent({
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      child: Slidable(
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Slidable(
              key: const ValueKey(0),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PosterWidget(
                      content: content,
                      isThumbnail: true,
                      height: 100,
                      width: 170,
                      isRedirect: false,
                    ),
                    const SizedBox(width: 17),
                    Expanded(
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
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.swipe_left,
                                  color: Colors.white,
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
