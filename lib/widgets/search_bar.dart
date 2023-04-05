import 'package:flutter/material.dart';
import 'package:hire_me/models/_index.dart';
import 'package:hire_me/widgets/job_card.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
      child: TextField(
        onTap: () => showSearch(context: context, delegate: Search()),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: const Icon(Icons.filter_list),
            filled: true,
            hintText: 'Search for a job or a company',
            hintStyle: const TextStyle(color: Colors.black54),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            )),
      ),
    );
  }
}

class Search extends SearchDelegate {
  List<Job> data = [
    Job(
      title: "UI/UX Designer",
      subTitle: "Google LLC",
      country: "Carlifornia, United State",
      salaryRange: "\$10,000 - \$25,000 /month",
      jobType: "Full Time",
      location: "Remote",
    ),
    Job(
      title: "Web Developer",
      subTitle: "Facebook LLC",
      country: "Carlifornia, United State",
      salaryRange: "\$12,000 - \$30,000 /month",
      jobType: "Full Time",
      location: "Remote",
    )
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () => query.isEmpty ? close(context, null) : query = '',
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Job> suggestions = data.where((element) {
      final result = element.title.toString().toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) => JobCard(
          title: suggestions[index].title,
          country: suggestions[index].country,
          jobType: suggestions[index].jobType,
          location: suggestions[index].location,
          salaryRange: suggestions[index].salaryRange,
          subTitle: suggestions[index].subTitle),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Job> suggestions = data.where((element) {
      final result = element.title.toString().toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) => JobCard(
          title: suggestions[index].title,
          country: suggestions[index].country,
          jobType: suggestions[index].jobType,
          location: suggestions[index].location,
          salaryRange: suggestions[index].salaryRange,
          subTitle: suggestions[index].subTitle),
    );
  }
}
