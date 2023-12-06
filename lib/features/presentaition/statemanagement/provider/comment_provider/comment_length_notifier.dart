// import 'dart:async';

// import 'package:flutter/material.dart';

// class CommentLengthNotifier extends ChangeNotifier {
//   final _commentLengthController = StreamController<int>.broadcast();

//   Stream<int> get commentLengthStream => _commentLengthController.stream;

//   void updateCommentLength(int length) {
//     _commentLengthController.add(length);
//     notifyListeners();
//   }

//   void dispose() {
//     _commentLengthController.close();
//   }
// }
// comment_length_notifier.dart

import 'package:flutter/material.dart';

class CommentLengthNotifier with ChangeNotifier {
  int _commentLength = 0;

  int get commentLength => _commentLength;

  void setCommentLength(int length) {
    _commentLength = length;
    notifyListeners();
  }
}
