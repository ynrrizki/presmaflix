import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:presmaflix/app/models/content.dart';
import 'package:presmaflix/ui/widgets/banner_widget.dart';
import 'package:presmaflix/ui/widgets/horizontal_list_poster_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Content> contents = Content.contents;
    return Scaffold(
      body: ListView(
        children: [
          BannerWidget(
            data: contents.map((e) => e.thumbnailUrl).toList(),
          ),
          HorizontalListPosterWidget(
            title: 'Movies',
            onTap: () {},
            contents: contents,
          ),
          const SizedBox(height: 25),
          HorizontalListPosterWidget(
            title: 'Animation',
            onTap: () {},
            contents: contents,
          ),
          const SizedBox(height: 25),
          HorizontalListPosterWidget(
            title: 'Tv Global',
            onTap: () {},
            contents: contents,
          ),
          const SizedBox(height: 25),
          HorizontalListPosterWidget(
            title: 'Music Video',
            onTap: () {},
            contents: contents,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

// EXAMPLE in HERE ⬇️⬇️⬇️

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // final ScrollController scrollController = ScrollController();
//     // return Scaffold(
//     //   body: ListView(
//     //     children: const [
//     //       SizedBox(
//     //         height: 1000,
//     //       ),
//     //       SizedBox(
//     //         height: 1000,
//     //       ),
//     //     ],
//     //   ),
//     // body: NestedScrollView(
//     //   controller: scrollController,
//     //   headerSliverBuilder: (context, innerBoxIsScrolled) {
//     //     return [];
//     //   },
//     //   body: ListView(
//     //     children: [
//     //       Container(
//     //         color: Colors.red,
//     //         height: 500,
//     //       ),
//     //       Container(
//     //         color: Colors.blue,
//     //         height: 500,
//     //       ),
//     //     ],
//     //   ),
//     // ),
//     // );
//     return AutoRefresh(
//       duration: const Duration(milliseconds: 2000),
//       child: Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(
//               parent: AlwaysScrollableScrollPhysics(),
//             ),
//             padding: const EdgeInsets.all(16.0),
//             child: AnimationLimiter(
//               child: Column(
//                 children: AnimationConfiguration.toStaggeredList(
//                   duration: const Duration(milliseconds: 375),
//                   childAnimationBuilder: (widget) => SlideAnimation(
//                     horizontalOffset: MediaQuery.of(context).size.width / 2,
//                     child: FadeInAnimation(child: widget),
//                   ),
//                   children: [
//                     EmptyCard(
//                       width: MediaQuery.of(context).size.width,
//                       height: 166.0,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: const [
//                           EmptyCard(height: 50.0, width: 50.0),
//                           EmptyCard(height: 50.0, width: 50.0),
//                           EmptyCard(height: 50.0, width: 50.0),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       children: const [
//                         Flexible(child: EmptyCard(height: 150.0)),
//                         Flexible(child: EmptyCard(height: 150.0)),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Row(
//                         children: const [
//                           Flexible(child: EmptyCard(height: 50.0)),
//                           Flexible(child: EmptyCard(height: 50.0)),
//                           Flexible(child: EmptyCard(height: 50.0)),
//                         ],
//                       ),
//                     ),
//                     EmptyCard(
//                       width: MediaQuery.of(context).size.width,
//                       height: 166.0,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
