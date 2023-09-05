import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchFieldWidget extends StatefulWidget {
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
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    widget.searchController.removeListener(_onSearchTextChanged);
    super.dispose();
  }

  void _onSearchTextChanged() {
    setState(() {
      _showClearButton = widget.searchController.text.isNotEmpty;
    });
  }

  void _clearSearchText() {
    setState(() {
      widget.searchController.clear();
      _showClearButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextField(
          controller: widget.searchController,
          onChanged: widget.onChanged,
          autofocus: false,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            hintText: widget.hintText,
            filled: true,
            fillColor: const Color.fromARGB(255, 43, 43, 43),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            constraints: const BoxConstraints(
              maxHeight: 37,
            ),
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: Colors.white,
            hintStyle: GoogleFonts.plusJakartaSans(
              color: Colors.grey,
            ),
          ),
        ),
        if (_showClearButton)
          IconButton(
            icon: const Icon(Icons.close),
            color: Colors.white,
            onPressed: _clearSearchText,
          ),
      ],
    );
  }
}
