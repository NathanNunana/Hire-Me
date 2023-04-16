import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hire_me/models/_index.dart';
import 'package:hire_me/providers/_index.dart';
import 'package:hire_me/screens/application.dart';
import 'package:hire_me/utils/_index.dart';
import 'package:provider/provider.dart';

class JobDescription extends StatelessWidget {
  final Job job;
  const JobDescription(
    this.job, {
    super.key,
  });

  _buildChip(String? text) {
    if (text == null) return const SizedBox();
    return Container(
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(5)),
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();
    final snackbar = ScaffoldMessenger.of(context);
    final nav = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
        actions: [
          IconButton(
              onPressed: () async {
                // print("jobId $jobId");
                final res = await auth.saveJob(job.id);
                if (res) {
                  snackbar.showSnackBar(const SnackBar(
                      content: Text(
                    "Job Saved!",
                    style: TextStyle(color: Colors.green),
                  )));
                } else {
                  snackbar.showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Failed!",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }
              },
              icon: const Icon(
                CupertinoIcons.bookmark,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.paperplane,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(18)),
                child: const Icon(
                  Icons.facebook,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                job.title.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                job.company.toString(),
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.black26,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                const SizedBox(
                  height: 8,
                ),
                Text(
                  job.location.toString(),
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "\$ ${job.minSalary} - ${job.maxSalary} /month",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Wrap(
                  spacing: 8,
                  children: [
                    _buildChip(job.contractTime),
                    _buildChip(job.contractType ?? "hybrid"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Posted 10 days ago, ends in 31 Dec",
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(
                  height: 20,
                ),
              ])
            ],
          ),
        ),
        DefaultTabController(
          length: 2,
          child: Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const TabBar(
                  labelColor: Colors.black,
                  tabs: [
                    Tab(text: "Job Description"),
                    Tab(text: "Minimum Qualification"),
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              job.description.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Center(
                            child: Text("Minimum Requirement"),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
            onPressed: () async {
              nav.push(
                CupertinoPageRoute(
                  builder: (_) => SubmitApplication(
                    jobId: job.id,
                  ),
                ),
              );
            },
            child: const Text("Apply"),
          ),
        )
      ]),
    );
  }
}
