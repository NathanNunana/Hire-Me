import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_me/providers/_index.dart';
import 'package:hire_me/screens/description.dart';
import 'package:hire_me/widgets/job_card.dart';
import 'package:provider/provider.dart';

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
    List suggestions = context.read<JobProvider>().jobs.where((element) {
      final title = element.title.toString().toLowerCase();
      final company = element.company.toString().toLowerCase();
      final input = query.toLowerCase();
      return title.contains(input) || company.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) =>
                  JobDescription(suggestions.elementAt(index)),
            )),
        child: JobCard(suggestions.elementAt(index)),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List suggestions = context.read<JobProvider>().jobs.where((element) {
      final title = element.title.toString().toLowerCase();
      final company = element.company.toString().toLowerCase();
      final input = query.toLowerCase();
      return title.contains(input) || company.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) =>
                  JobDescription(suggestions.elementAt(index)),
            )),
        child: JobCard(suggestions.elementAt(index)),
      ),
    );
  }
}
