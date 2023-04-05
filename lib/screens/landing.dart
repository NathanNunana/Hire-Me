import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_me/screens/home.dart';
import 'package:hire_me/screens/saved_jobs.dart';
import 'package:hire_me/screens/profile.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SavedJobs(),
    Center(child: Text('Applied Jobs')),
    Center(child: Text('Chat')),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 16.0, right: 16.0, left: 16.0),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    CupertinoIcons.home,
                    color: (_selectedIndex == 0) ? Colors.blue : null,
                  ),
                  onPressed: () {
                    _onItemTapped(0);
                  },
                ),
                IconButton(
                  icon: Icon(
                    CupertinoIcons.bookmark,
                    color: (_selectedIndex == 1) ? Colors.blue : null,
                  ),
                  onPressed: () {
                    _onItemTapped(1);
                  },
                ),

                IconButton(
                  icon: Icon(
                    CupertinoIcons.briefcase,
                    color: (_selectedIndex == 2) ? Colors.blue : null,
                  ),
                  onPressed: () {
                    _onItemTapped(2);
                  },
                ),
                // SizedBox(width: 30.0),
                IconButton(
                  icon: Icon(
                    CupertinoIcons.chat_bubble_text,
                    color: (_selectedIndex == 3) ? Colors.blue : null,
                  ),
                  onPressed: () {
                    _onItemTapped(3);
                  },
                ),
                IconButton(
                  icon: Icon(
                    CupertinoIcons.profile_circled,
                    color: (_selectedIndex == 4) ? Colors.blue : null,
                  ),
                  onPressed: () {
                    _onItemTapped(4);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
