import 'package:flutter/material.dart';
import 'package:hire_me/providers/_index.dart';
import 'package:hire_me/widgets/search_bar.dart';
import 'package:hire_me/widgets/job_card.dart';
import 'package:provider/provider.dart';

class SavedJobs extends StatelessWidget {
  const SavedJobs({super.key});

  @override
  Widget build(BuildContext context) {
    final job = context.read<JobProvider>().jobs;
    final auth = context.read<AuthProvider>();
    List filteredJobs = job
        .where(((element) => auth.user!.userMetadata!["jobId"]
            .contains(element.jobId.toString())))
        .toList();
    print("$filteredJobs ${auth.user!.userMetadata!['jobId']}");
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
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: filteredJobs.length,
            itemBuilder: (context, index) => JobCard(
              company: filteredJobs[index].company.toString(),
              contractTime: filteredJobs[index].contractTime.toString(),
              contractType: filteredJobs[index].contractType.toString(),
              location: filteredJobs[index].location.toString(),
              salaryRange:
                  "\$ ${filteredJobs[index].minSalary} - ${filteredJobs[index].maxSalary} /month",
              title: filteredJobs[index].title.toString(),
            ),
          ),
        )),
      ],
    );
  }
}
