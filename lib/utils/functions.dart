import 'package:flutter/material.dart';
import 'package:presmaflix/presentation/config/themes_config.dart';

void loading(BuildContext context, {bool isLoading = true}) {
  isLoading
      ? showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
            );
          },
        )
      : Navigator.pop(context);
}
