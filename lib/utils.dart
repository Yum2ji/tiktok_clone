import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool isDarkMode(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;

showFirebaseErrorSnack(
  BuildContext context,
  Object? error,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
/*       action: SnackBarAction(
        label: "OK",
        onPressed: () {},
      ), */
      content: Text(
        (error as FirebaseException).message ?? "Something went wrong",
      ),
    ),
  );
}
