import 'package:flutter/material.dart';
import 'package:hire_me/providers/_index.dart';
import 'package:hire_me/widgets/search_bar.dart';
import 'package:hire_me/widgets/job_card.dart';
import 'package:provider/provider.dart';

class SavedJobs extends StatefulWidget {
  const SavedJobs({super.key});

  @override
  State<SavedJobs> createState() => _SavedJobsState();
}

class _SavedJobsState extends State<SavedJobs> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.microtask(() {
        context.read<AuthProvider>().getSavedJobs(true);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
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
            itemCount: auth.savedJobs.length,
            itemBuilder: (context, index) => JobCard(
              auth.savedJobs.elementAt(index),
            ),
          ),
        )),
      ],
    );
  }
}
