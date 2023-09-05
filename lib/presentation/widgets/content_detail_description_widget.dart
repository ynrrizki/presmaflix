import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/presentation/cubits/content_detail/view_more/view_more_cubit.dart';

class ContentDetailDescriptionWidget extends StatefulWidget {
  const ContentDetailDescriptionWidget({
    super.key,
    required this.description,
    required this.state,
  });
  final String description;
  final bool state;

  @override
  State<ContentDetailDescriptionWidget> createState() =>
      _ContentDetailDescriptionWidgetState();
}

class _ContentDetailDescriptionWidgetState
    extends State<ContentDetailDescriptionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isTextOverflowed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      widget.description,
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w400,
        color: Colors.grey,
      ),
    );

    final textSpan =
        TextSpan(text: widget.description, style: textWidget.style);

    final textPainter = TextPainter(
      text: textSpan,
      maxLines: 5,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);

    isTextOverflowed = textPainter.didExceedMaxLines;

    return Column(
      children: [
        AnimatedCrossFade(
          firstChild: Text(
            widget.description,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          secondChild: Text(
            widget.description,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          crossFadeState: widget.state
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
        if (isTextOverflowed)
          TextButton(
            onPressed: () {
              context.read<ViewMoreCubit>().updateViewMore(!widget.state);
            },
            child: Text(widget.state ? 'show less' : 'show more'),
          ),
      ],
    );
  }
}
