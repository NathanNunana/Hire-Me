import 'package:flutter/material.dart';
import 'package:hire_me/widgets/search_bar.dart';
import 'package:hire_me/widgets/job_card.dart';

class SavedJobs extends StatelessWidget {
  const SavedJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          // leading: Icon(CupertinoIcons.wifi),
          title: Text(
            "Saved Jobs",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
          ),
        ),
        const SearchBar(),
        Expanded(
            child: SizedBox(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: const [
              JobCard(
                title: "UI/UX Designer",
                company: "Google LLC",
                location: "Carlifornia, United State",
                salaryRange: "\$ 12,000 - \$ 15,000 /month",
                contractTime: "Full Time",
                contractType: "Remote",
              ),
              JobCard(
                title: "UI/UX Designer",
                company: "Google LLC",
                location: "Carlifornia, United State",
                salaryRange: "\$ 12,000 - \$ 15,000 /month",
                contractTime: "Full Time",
                contractType: "Remote",
              ),
            ],
          ),
        )),
      ],
    );
  }
}
