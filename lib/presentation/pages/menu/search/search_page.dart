import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/presentation/bloc/blocs.dart';
// import 'package:presmaflix/app/bloc/rating/rating_bloc.dart';
// import 'package:presmaflix/app/cubits/search/search_cubit.dart' as search_cubit;
import 'package:presmaflix/data/models/content/content.dart';
import 'package:presmaflix/data/repositories/firestore/rating/rating_repo.dart';
import 'package:presmaflix/presentation/routes/argument/arguments.dart';
import 'package:presmaflix/presentation/config/themes_config.dart';
import 'package:presmaflix/presentation/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  bool isSearchEmpty = true; // Tambahkan variabel ini
  RatingRepository ratingRepository = RatingRepository();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_updateSearchState);
  }

  @override
  void dispose() {
    searchController.removeListener(_updateSearchState);
    searchController.dispose();
    super.dispose();
  }

  void _updateSearchState() {
    setState(() {
      isSearchEmpty = searchController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
        title: SearchFieldWidget(
          hintText: 'Judul',
          searchController: searchController,
          onChanged: (value) {
            context.read<SearchBloc>().add(
                  SearchContent(title: value),
                );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Batalkan',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15)
        ],
      ),
      body: isSearchEmpty
          ? const IdleSearch()
          : LoadSearch(
              ratingRepository: ratingRepository,
            ),
    );
  }
}

class LoadSearch extends StatelessWidget {
  const LoadSearch({
    super.key,
    required this.ratingRepository,
  });

  final RatingRepository ratingRepository;

  @override
  Widget build(BuildContext context) {
    List<Content> contents = Content.contents;
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) => current is SearchLoaded,
      builder: (context, state) {
        if (state is SearchLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        } else if (state is SearchLoaded) {
          contents = state.contents;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: contents.map(
                (content) {
                  // double rating = 0.0;
                  // ratingRepository
                  //     .getRatingByContent(content.id)
                  //     .listen((event) => rating = event).toString();
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('ratings')
                        .where('contentId', isEqualTo: content.id)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer.fromColors(
                          baseColor: const Color.fromARGB(123, 121, 121, 121),
                          highlightColor:
                              const Color.fromARGB(255, 128, 128, 128),
                          child: ContentCardWidget(
                            content,
                            name: content.title,
                            directs: content.directors.first,
                            imageURL: content.posterUrl,
                            rating: 0.0,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        double totalRating = 0.0;
                        int ratingCount = snapshot.data!.docs.length;
                        for (var doc in snapshot.data!.docs) {
                          totalRating += doc.data()['rating'] ?? 0;
                        }
                        log((totalRating / ratingCount).toString(),
                            name: 'getRatingByContent');
                        totalRating = totalRating / ratingCount;
                        if (totalRating.isNaN) {
                          totalRating = 0.0;
                        }
                        return ContentCardWidget(
                          content,
                          name: content.title,
                          directs: content.directors.first,
                          imageURL: content.posterUrl,
                          rating: totalRating,
                        );
                      }
                    },
                  );
                },
              ).toList(),
            ),
          );
        }

        return const Center(
          child: Text('Something went wrong'),
        );
      },
    );
  }
}

class ContentCardWidget extends StatelessWidget {
  const ContentCardWidget(
    this.content, {
    super.key,
    required this.name,
    required this.directs,
    required this.imageURL,
    required this.rating,
  });

  final Content content;
  final String name;
  final String directs;
  final String imageURL;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context, rootNavigator: true).pushNamed(
            '/content-detail',
            arguments: ContentDetailArguments(content: content),
          );
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        leading: CachedNetworkImage(
          imageUrl: imageURL,
          fit: BoxFit.cover,
          width: 50,
          alignment: Alignment.center,
          imageBuilder: (context, imageProvider) {
            Decoration boxDecoration = BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: imageProvider,
                repeat: ImageRepeat.noRepeat,
                fit: BoxFit.cover,
                isAntiAlias: true,
              ),
            );

            return Container(
              decoration: boxDecoration,
            );
          },
          progressIndicatorBuilder: (context, url, progress) =>
              Shimmer.fromColors(
            baseColor: const Color.fromARGB(123, 121, 121, 121),
            highlightColor: const Color.fromARGB(255, 128, 128, 128),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          errorWidget: (context, url, error) => ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              'assets/images/no_image.png',
              alignment: Alignment.center,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        // leading: Container(
        //   width: 50,
        //   decoration: BoxDecoration(
        //     color: Colors.grey,
        //     borderRadius: BorderRadius.circular(10),
        //     image: DecorationImage(
        //       image: CachedNetworkImageProvider(imageURL),
        //       fit: BoxFit.cover,
        //       alignment: Alignment.topCenter,
        //     ),
        //   ),
        // ),
        title: Text(
          name,
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              directs,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Rating $rating',
                  style: GoogleFonts.poppins(
                    color: kPrimaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.star,
                  size: 14,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IdleSearch extends StatelessWidget {
  const IdleSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Pencarian Terakhir
          // List<Chip>

          // Judul Trending
          // Slider

          // Genre Favorit
          // GridBuilder

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                  child: Text(
                    'Genre Favorit',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                    ),
                  ),
                ),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  childAspectRatio: (9.5) / (3.6),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2,
                  children: [
                    _genreCard(
                      context,
                      title: 'Drama',
                      leading: const Icon(Icons.house_outlined),
                    ),
                    _genreCard(
                      context,
                      title: 'Romansa',
                      leading: const Icon(CupertinoIcons.heart),
                    ),
                    _genreCard(
                      context,
                      title: 'Komedi',
                      leading: const Icon(Icons.emoji_emotions_outlined),
                    ),
                    _genreCard(
                      context,
                      title: 'Horror',
                      leading: const Icon(Icons.local_movies_outlined),
                    ),
                    _genreCard(
                      context,
                      title: 'Fiksi',
                      leading: const Icon(Icons.science_outlined),
                    ),
                    _genreCard(
                      context,
                      title: 'Misteri',
                      leading: const Icon(Icons.search_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Card _genreCard(BuildContext context,
      {required String title, required Widget leading}) {
    List<Content> contents = [];
    return Card(
      child: BlocListener<ContentBloc, ContentState>(
        bloc: context.read<ContentBloc>()..add(LoadContents()),
        listener: (context, state) {
          if (state is ContentLoaded) {
            contents = state.contents;
          }
        },
        child: ListTile(
          onTap: () {
            Navigator.of(context, rootNavigator: true).pushNamed(
              '/content-all',
              arguments: ContentAllArguments(
                title: title,
                contents: contents
                    .where((content) =>
                        content.genre.any((element) => element.contains(title)))
                    .toList(),
              ),
            );
          },
          leading: leading,
          title: Text(title),
        ),
      ),
    );
  }
}
