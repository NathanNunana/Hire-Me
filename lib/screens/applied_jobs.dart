import 'package:flutter/material.dart';
import 'package:hire_me/widgets/search_bar.dart';

class AppliedJobs extends StatelessWidget {
  const AppliedJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ListTile(
          // leading: Icon(CupertinoIcons.wifi),
          title: Text(
            "Applications",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
          ),
        ),
        SearchBar(),
      ],
    );
  }
}
