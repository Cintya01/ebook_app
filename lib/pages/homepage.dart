import 'package:ebook_app/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const double iconSize = 32;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.settings, size: iconSize, color: AppColor.orange),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.shopping_bag_outlined,
                        size: iconSize, color: AppColor.darkGrey)),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: AppColor.orange,
                  child: Icon(Icons.person, color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
      body: const Center(
        child: Text('Welcome to Ebook App'),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: size.height * 0.1,
        decoration: BoxDecoration(
          color: AppColor.orange,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _itemBottomNavigatorMenu(
              onTap: () {},
              label: 'Explore',
              icon: Icons.explore_outlined,
            ),
            _itemBottomNavigatorMenu(
              onTap: () {},
              label: 'Reading',
              icon: Icons.book_outlined,
            ),
            _itemBottomNavigatorMenu(
              onTap: () {},
              label: 'Bookmark',
              icon: Icons.bookmark_border_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemBottomNavigatorMenu({
    required Function() onTap,
    required String label,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColor.white),
          Text(label, style: TextStyle(color: AppColor.white)),
        ],
      ),
    );
  }
}
