import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class JobDescription extends StatelessWidget {
  final String? title,
      description,
      subTitle,
      salaryRange,
      country,
      jobType,
      location;
  const JobDescription({
    super.key,
    this.country,
    this.description,
    this.jobType,
    this.location,
    this.salaryRange,
    this.subTitle,
    this.title,
  });

  _buildChip(text) {
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
        actions: const [
          IconButton(onPressed: null, icon: Icon(CupertinoIcons.bookmark)),
          IconButton(onPressed: null, icon: Icon(CupertinoIcons.paperplane))
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
              const Text(
                "UI/UX Designer",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Facebook LLC",
                style: TextStyle(
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
                const Text(
                  "California, United States",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "\$10,000 - \$25,000 /month",
                  style: TextStyle(
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
                    _buildChip("Full Time"),
                    _buildChip("Onsite"),
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
              SizedBox(
                height: 250,
                child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Center(
                        child: Text(description.toString()),
                      ),
                      const Center(
                        child: Text("Minimum Requirement"),
                      ),
                    ]),
              ),
            ],
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
            onPressed: () {},
            child: const Text("Apply"),
          ),
        )
      ]),
    );
  }
}
