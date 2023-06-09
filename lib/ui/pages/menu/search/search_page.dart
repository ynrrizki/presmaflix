import 'package:flutter/material.dart';
import 'package:presmaflix/ui/widgets/widgets.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

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
          searchController: TextEditingController(),
        ),
        actions: [
          TextButton(
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
          const SizedBox(width: 15)
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            // Pencarian Terakhir
            // List<Chip>

            // Judul Trending
            // Slider

            // Genre Favorit
            // GridBuilder
          ],
        ),
      ),
    );
  }
}
