import 'package:flutter/material.dart';
import 'package:hire_me/providers/_index.dart';
import 'package:hire_me/widgets/job_card.dart';
import 'package:hire_me/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class AppliedJobs extends StatefulWidget {
  const AppliedJobs({super.key});

  @override
  State<AppliedJobs> createState() => _AppliedJobsState();
}

class _AppliedJobsState extends State<AppliedJobs> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.microtask(() {
        context.read<JobProvider>().fetchAppliedJobs(true);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final jobs = context.watch<JobProvider>();
    return Column(
      children: [
        const ListTile(
          // leading: Icon(CupertinoIcons.wifi),
          title: Text(
            "Applications",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
          ),
        ),
        const SearchBar(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [for (var job in jobs.appliedJobs) JobCard(job)],
            ),
          ),
        ),
      ],
    );
  }
}
