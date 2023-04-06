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
      company: "Google LLC",
      location: "Carlifornia, United State",
      minSalary: 10000,
      maxSalary: 25000,
      contractTime: "Full Time",
      contractType: "Remote",
    ),
    Job(
      title: "Web Developer",
      company: "Facebook LLC",
      location: "Carlifornia, United State",
      minSalary: 12000,
      maxSalary: 30000,
      contractTime: "Full Time",
      contractType: "Remote",
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
          location: suggestions[index].location,
          contractTime: suggestions[index].contractTime,
          contractType: suggestions[index].contractType,
          salaryRange:
              "\$ ${suggestions[index].minSalary} - ${suggestions[index].maxSalary} /month",
          company: suggestions[index].company),
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
          location: suggestions[index].location,
          contractTime: suggestions[index].contractTime,
          contractType: suggestions[index].contractType,
          salaryRange:
              "\$ ${suggestions[index].minSalary} - ${suggestions[index].maxSalary} /month",
          company: suggestions[index].company),
    );
  }
}
