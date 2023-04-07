import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_me/providers/_index.dart';
import 'package:hire_me/screens/description.dart';
import 'package:hire_me/widgets/job_card.dart';
import 'package:hire_me/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class ViewAll extends StatelessWidget {
  const ViewAll({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.read<JobProvider>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back)),
                const Flexible(child: SearchBar()),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "${provider.jobs.length} found",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => InkWell(
                  onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => JobDescription(
                          title: provider.jobs[index].title.toString(),
                          company: provider.jobs[index].company.toString(),
                          location: provider.jobs[index].location.toString(),
                          salaryRange:
                              "\$ ${provider.jobs[index].minSalary} - ${provider.jobs[index].maxSalary} /month",
                          contractTime:
                              provider.jobs[index].contractTime.toString(),
                          contractType:
                              provider.jobs[index].contractType ?? "hybrid",
                          description:
                              provider.jobs[index].description.toString(),
                        ),
                      )),
                  child: JobCard(
                    title: provider.jobs[index].title.toString(),
                    company: provider.jobs[index].company.toString(),
                    location: provider.jobs[index].location.toString(),
                    salaryRange:
                        "\$ ${provider.jobs[index].minSalary} - ${provider.jobs[index].maxSalary} /month",
                    contractTime: provider.jobs[index].contractTime.toString(),
                    contractType: provider.jobs[index].contractType ?? "hybrid",
                  ),
                ),
                itemCount:
                    provider.jobs.length >= 50 ? 50 : provider.jobs.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
