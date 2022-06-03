import 'package:flutter/material.dart';

// 閉じる Navigator.of(context, rootNavigator: true).pop();

showFullScreenProgressDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return progressWidget();
    },
  );
}

Widget progressWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          '読み込み中',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            decoration: TextDecoration.none,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        CircularProgressIndicator(
          color: Colors.red,
        ),
      ],
    ),
  );
}
