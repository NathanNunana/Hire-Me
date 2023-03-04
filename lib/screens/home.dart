import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_me/widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          SearchBar(),
          // Center(child: Text("Hire Me")),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBar();
}

class _CustomBottomNavigationBar extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(label: 'Home', icon: Icon(CupertinoIcons.home)),
        BottomNavigationBarItem(
            label: 'Saved Jobs', icon: Icon(CupertinoIcons.bookmark)),
        BottomNavigationBarItem(
            label: 'Applications', icon: Icon(CupertinoIcons.bag)),
        BottomNavigationBarItem(
            label: 'Message', icon: Icon(CupertinoIcons.chat_bubble)),
        BottomNavigationBarItem(
            label: 'Profile', icon: Icon(CupertinoIcons.person)),
      ],
      onTap: (val) {},
    );
  }
}
