import 'package:flutter/material.dart';
import 'package:hire_me/providers/_index.dart';
import 'package:hire_me/utils/_index.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final fKey = GlobalKey<FormState>();
  // Skillset
  List<String> skills = [
    'Flutter',
    'React',
    'Angular',
    'Vue',
    'Node.js',
    'Python',
    'Java',
    'Swift'
  ];
  List<String> selectedSkills = [];

  // Experience
  Map<String, String> experience = {
    '1 year': '1',
    '2 years': '2',
    '3 years': '3',
    '4 years': '4',
    '5+ years': '5+',
  };
  String? selectedExperience;

  // Education
  final TextEditingController educationController = TextEditingController();

  // Contact info
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Salary Range
  RangeValues salaryRange = const RangeValues(0, 100000);
  final numberFormat = NumberFormat("#,###");

  submitDetails() async {
    if (fKey.currentState!.validate()) {
      final nav = Navigator.of(context);
      final job = context.read<JobProvider>();
      final auth = context.read<AuthProvider>();
      final snackbar = ScaffoldMessenger.of(context);
      final res = await job.saveApplicationDetails(
        name: nameController.text,
        email: emailController.text,
        education: educationController.text,
        experience: selectedExperience,
        phone: phoneController.text,
        skills: selectedSkills,
        salaryRange: "\$${salaryRange.start} - \$${salaryRange.end} /month",
        userId: auth.user!.id,
      );

      if (res) {
        snackbar.showSnackBar(const SnackBar(content: Text("Success!")));
        nav.pushReplacementNamed(AppRouter.homeRoute);
      } else {
        snackbar.showSnackBar(const SnackBar(content: Text("Failed!")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: fKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.trim() == "") {
                        return "Please enter your name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Name',
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15.0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim() == "") {
                        return "Please enter email address";
                      }
                      if (!emailREgex.hasMatch(value)) {
                        return "Please enter a valid Email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Email',
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15.0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim() == "") {
                        return "Please your phone number";
                      }
                      // if (!emailREgex.hasMatch(value)) {
                      //   return "Please enter a valid Email";
                      // }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Phone',
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15.0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'What is your highest education level?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: educationController,
                    validator: (value) {
                      if (value == null || value.trim() == "") {
                        return "Please enter your highest level of education";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter your education',
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15.0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'How much experience do you have?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField<String>(
                    validator: (value) {
                      if (value == null || value.trim() == "") {
                        return "Select the number of years of experience";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15.0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10))),
                    value: selectedExperience,
                    hint: const Text('Select experience'),
                    onChanged: (value) {
                      setState(() {
                        selectedExperience = value;
                      });
                    },
                    items: experience.entries
                        .map(
                          (entry) => DropdownMenuItem<String>(
                            value: entry.value,
                            child: Text(entry.key),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'What skills do you have?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 10,
                    children: skills
                        .map(
                          (skill) => ChoiceChip(
                            label: Text(skill),
                            selected: selectedSkills.contains(skill),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  selectedSkills.add(skill);
                                } else {
                                  selectedSkills.remove(skill);
                                }
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'What is your expected salary range?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RangeSlider(
                    values: salaryRange,
                    min: 0,
                    max: 200000,
                    divisions: 10,
                    labels: RangeLabels(
                      'Ghc ${numberFormat.format(salaryRange.start.toInt())}',
                      'Ghc ${numberFormat.format(salaryRange.end.toInt())}',
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        salaryRange = values;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(15.0)),
                      onPressed: submitDetails,
                      child: const Text('Continue'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
