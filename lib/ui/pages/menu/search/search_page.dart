import 'package:flutter/material.dart';
import 'package:presmaflix/ui/widgets/search_field_widget.dart';
// import 'package:presmaflix/ui/widgets/text_field_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        title: SearchFieldWidget(
          searchController: TextEditingController(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [],
        ),
      ),
    );
  }
}
