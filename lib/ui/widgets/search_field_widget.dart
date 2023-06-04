import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({
    Key? key,
    required this.searchController,
    this.hintText = 'Search',
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  final TextEditingController searchController;
  final String hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: onChanged,
      autofocus: false,
      style: GoogleFonts.plusJakartaSans(
          color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        constraints: const BoxConstraints(
          maxHeight: 35,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        hintText: hintText,
        filled: true,
        fillColor: const Color.fromARGB(255, 43, 43, 43),
        border: InputBorder.none,
        prefixIcon: const Icon(Icons.search),
        prefixIconColor: Colors.white,
        hintStyle: GoogleFonts.plusJakartaSans(
          color: Colors.grey,
        ),
      ),
    );
  }
}
