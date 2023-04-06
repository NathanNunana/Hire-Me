import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_me/models/_index.dart';
import 'package:hire_me/providers/_index.dart';
import 'package:hire_me/widgets/read_more.dart';
import 'package:hire_me/widgets/job_card.dart';
import 'package:hire_me/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future? jobs;
  Future<Job> getJobs() async {
    return await Provider.of<JobProvider>(context).fetchJobs();
  }

  @override
  void initState() {
    super.initState();
    jobs = getJobs();
  }

  Widget _buildHeader(context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage('assets/images/nathan_n.png'),
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
          fontSize: 17,
        ),
      ),
      trailing: Container(
        height: 50,
        width: 50,
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
            size: 20,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SearchBar(),
            // Container(
            //   margin:
            //       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: const [
            //       Text(
            //         "Top Companies",
            //         style:
            //             TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //       ),
            //       InkWell(
            //         onTap: null,
            //         child: Text(
            //           "See All",
            //           style: TextStyle(
            //               fontWeight: FontWeight.w600, color: Colors.blue),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            const ReadMore(),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   physics: const BouncingScrollPhysics(),
            //   child: Row(
            //     children: const [
            //       CompanyCard(),
            //       CompanyCard(),
            //       CompanyCard(),
            //     ],
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Recent Jobs",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: null,
                    child: Text(
                      "See All",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                  child: FutureBuilder(
                future: jobs,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (snapshot.hasData) {
                      return Text(snapshot.data);
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              )
                  // ListView(
                  //   shrinkWrap: true,
                  //   physics: const BouncingScrollPhysics(),
                  //   children: [
                  //     InkWell(
                  //       onTap: () => Navigator.pushNamed(context, '/details',
                  //           arguments: <String, String>{
                  //             'description': 'Job Description',
                  //           }),
                  //       child: const JobCard(
                  //         title: "UI/UX Designer",
                  //         company: "Google LLC",
                  //         location: "Carlifornia, United State",
                  //         salaryRange: "\$10,000 - \$25,000 /month",
                  //         contractTime: "Full Time",
                  //         contractType: "Remote",
                  //       ),
                  //     ),
                  //     const JobCard(
                  //       title: "UI/UX Designer",
                  //       company: "Google LLC",
                  //       location: "Carlifornia, United State",
                  //       salaryRange: "\$10,000 - \$25,000 /month",
                  //       contractTime: "Full Time",
                  //       contractType: "Remote",
                  //     ),
                  //   ],
                  // ),
                  ),
            ),
            // Center(child: Text("Hire Me")),
          ],
        ),
      ),
    );
  }
}
