import 'package:flutter/material.dart';

import '../constants.dart';

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Movies',
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        foregroundColor: iconColor,
      ),
      body: Column(
        children: const [],
      ),
    );
  }
}
