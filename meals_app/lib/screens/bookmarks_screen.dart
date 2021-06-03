import 'package:flutter/cupertino.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // No need of scaffold if using it inside tabbed layout
    return Center(
      child: Text('Bookmarks'),
    );
  }
}
