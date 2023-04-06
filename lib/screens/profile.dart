import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  _buildProfileCard(icon, title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(
          CupertinoIcons.add,
          color: Colors.blue,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          // leading: Icon(CupertinoIcons.wifi),
          title: Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
          ),
          trailing: Icon(CupertinoIcons.settings),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/nathan_n.png'),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Nathan Nunana",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "UI/UX Designer at Paypal Inc.",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
                onPressed: () => Navigator.pushNamed(context, '/editProfile'),
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                )),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Divider(),
        _buildProfileCard(
            const Icon(
              CupertinoIcons.person_fill,
              color: Colors.blue,
            ),
            "Contact Information"),
        _buildProfileCard(
            const Icon(
              CupertinoIcons.doc_fill,
              color: Colors.blue,
            ),
            "Summary"),
        _buildProfileCard(
            const Icon(
              CupertinoIcons.chart_pie_fill,
              color: Colors.blue,
            ),
            "Expected Salary"),
        _buildProfileCard(
            const Icon(
              CupertinoIcons.briefcase_fill,
              color: Colors.blue,
            ),
            "Work Experience"),
        _buildProfileCard(
            const Icon(
              CupertinoIcons.book_fill,
              color: Colors.blue,
            ),
            "Education"),
        _buildProfileCard(
            const Icon(
              CupertinoIcons.doc_chart_fill,
              color: Colors.blue,
            ),
            "Projects"),
        _buildProfileCard(
            const Icon(
              CupertinoIcons.doc_fill,
              color: Colors.blue,
            ),
            "Certificates and Licenses"),
      ],
    );
  }
}