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

  Future getAppliedJobs() async {
    final auth = context.read<AuthProvider>();
    return await context.read<JobProvider>().fetchAppliedJobs(auth.user!.id);
  }

  @override
  void initState() {
    super.initState();
    jobs = getJobs();
    getAppliedJobs();
  }

  Widget _buildHeader(context, name) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage('assets/images/profile.png'),
      ),
      title: const Text(
        "Good Morning 👋",
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Text(
        name,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 17,
        ),
      ),
      trailing: Container(
        height: 40,
        width: 40,
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
    final List user = context
        .read<AuthProvider>()
        .user!
        .userMetadata!['fullname']
        .toString()
        .split(" ");
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, user.sublist(1, user.length).join(" ")),
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
