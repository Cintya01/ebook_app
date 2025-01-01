import 'package:flutter/material.dart';

class MoreBooks extends StatelessWidget {
  const MoreBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More Books"),
      ),
      body: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("Book $index"),
              subtitle: Text("Author $index"),
              onTap: () {
                Navigator.pushNamed(context, "/detail-book");
              },
            );
          }),
    );
  }
}
