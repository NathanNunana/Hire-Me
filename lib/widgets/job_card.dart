import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class JobCard extends StatelessWidget {
  final String? title,
      company,
      salaryRange,
      contractType,
      contractTime,
      location;
  const JobCard({
    super.key,
    this.contractType,
    this.salaryRange,
    this.company,
    this.title,
    this.contractTime,
    this.location,
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
    final abb = company.toString().split(" ").first;
    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10.0,
        ),
        margin: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.circular(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(18)),
                child: Text(abb),
              ),
              title: Text(
                title.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(company.toString()),
              trailing: const Icon(
                CupertinoIcons.bookmark,
                size: 20,
              ),
            ),
            const Divider(
              color: Colors.black26,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                location.toString(),
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                salaryRange.toString(),
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
                  _buildChip(contractTime),
                  _buildChip(contractType),
                ],
              )
            ])
          ],
        ));
  }
}
