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
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 15)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
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
