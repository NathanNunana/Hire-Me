import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_me/widgets/company_card.dart';
import 'package:hire_me/widgets/job_card.dart';
import 'package:hire_me/widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildHeader(context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 25,
      ),
      title: const Text(
        "Good Morning 👋",
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: const Text(
        "Nathan Nunana",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 19,
        ),
      ),
      trailing: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: const IconButton(
          onPressed: null,
          icon: Icon(
            CupertinoIcons.bell,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const SearchBar(),
            const CompanyCard(),
            const JobCard(),
            // Center(child: Text("Hire Me")),
          ],
        ),
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
