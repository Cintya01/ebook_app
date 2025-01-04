import 'package:ebook_app/pages/primary_pages/bookmark.dart';
import 'package:ebook_app/pages/primary_pages/homepage.dart';
import 'package:ebook_app/pages/primary_pages/reading.dart';
import 'package:ebook_app/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetPages = [
    HomePage(),
    ReadingPage(),
    Bookmark(),
  ];

  void _onIconTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _widgetPages[_selectedIndex],
      bottomNavigationBar: Container(
        width: double.infinity,
        height: size.height * 0.09,
        color: AppColor.white,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _itemBottomNavigatorMenu(
                onTap: () {
                  _onIconTapped(0);
                },
                isSelected: _selectedIndex == 0,
                label: 'Explore',
                icon: Icons.explore_outlined,
              ),
              _itemBottomNavigatorMenu(
                onTap: () {
                  _onIconTapped(1);
                },
                isSelected: _selectedIndex == 1,
                label: 'Reading',
                icon: Icons.book_outlined,
              ),
              _itemBottomNavigatorMenu(
                onTap: () {
                  _onIconTapped(2);
                },
                isSelected: _selectedIndex == 2,
                label: 'Bookmark',
                icon: Icons.bookmark_border_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemBottomNavigatorMenu({
    required Function() onTap,
    required String label,
    required IconData icon,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? AppColor.orange : AppColor.darkGrey),
          Text(label, style: TextStyle(color: AppColor.darkGrey)),
        ],
      ),
    );
  }
}
