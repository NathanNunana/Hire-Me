import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_me/models/_index.dart';
import 'package:hire_me/providers/_index.dart';
import 'package:hire_me/screens/description.dart';
import 'package:hire_me/widgets/job_card.dart';
import 'package:hire_me/widgets/read_more.dart';
import 'package:hire_me/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<dynamic>? jobs;
  Future getJobs() async {
    return await context.read<JobProvider>().fetchJobs();
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
                children: [
                  const Text(
                    "Recent Jobs",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, "/viewAll"),
                    child: const Text(
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
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length >= 10
                            ? 10
                            : snapshot.data.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () => {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => JobDescription(
                                    title:
                                        snapshot.data[index].title.toString(),
                                    company:
                                        snapshot.data[index].company.toString(),
                                    location: snapshot.data[index].location
                                        .toString(),
                                    salaryRange:
                                        "\$ ${snapshot.data[index].minSalary} - ${snapshot.data[index].maxSalary} /month",
                                    contractTime: snapshot
                                        .data[index].contractTime
                                        .toString(),
                                    contractType:
                                        snapshot.data[index].contractType ??
                                            "hybrid",
                                    description: snapshot
                                        .data[index].description
                                        .toString(),
                                    jobId:
                                        snapshot.data[index].jobId.toString(),
                                  ),
                                )),
                          },
                          child: JobCard(
                            title: snapshot.data[index].title.toString(),
                            company: snapshot.data[index].company.toString(),
                            location: snapshot.data[index].location.toString(),
                            salaryRange:
                                "\$ ${snapshot.data[index].minSalary} - ${snapshot.data[index].maxSalary} /month",
                            contractTime:
                                snapshot.data[index].contractTime.toString(),
                            contractType:
                                snapshot.data[index].contractType ?? "hybrid",
                          ),
                        ),
                      );
                    } else {
                      return const Text('No Jobs Posted');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              )),
            ),
            // Center(child: Text("Hire Me")),
          ],
        ),
      ),
    );
  }
}
