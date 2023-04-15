import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_me/providers/_index.dart';
import 'package:provider/provider.dart';

class SubmitApplication extends StatefulWidget {
  final String? jobId;
  const SubmitApplication({super.key, this.jobId});

  @override
  State<SubmitApplication> createState() => _SubmitApplicationState();
}

class _SubmitApplicationState extends State<SubmitApplication> {
  showSuccessDialog() {}

  showAlertDialog(userId, applicationId, jobId) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      onPressed: () async {
        print(userId);
        print(applicationId);
        print(jobId);
        final res = await context
            .read<JobProvider>()
            .apply(userId, applicationId, jobId);
        print(res);
        // showSuccessDialog();
      },
      child: const Text("Yes"),
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Confirm"),
      content: const Text("Would you like to submit this application?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = context.read<JobProvider>().data;
    final user = context.read<AuthProvider>().user;
    final len = data!.length - 1;
    List skills = data[len]['skills'];
    print(data);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Apply Job",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    children: [
                      const ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                        title: Text(
                          'Contact Information',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                        child: Divider(),
                      ),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: Text(data[len]['email']),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: Text(data[len]['phone']),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ListTile(
                        leading: Icon(
                          CupertinoIcons.book,
                          color: Colors.blue,
                        ),
                        title: Text(
                          'Education',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5),
                        child: Text(
                          data[len]['education'],
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ListTile(
                        leading: Icon(
                          CupertinoIcons.briefcase,
                          color: Colors.blue,
                        ),
                        title: Text(
                          'Skills',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5),
                        child: Wrap(
                          spacing: 10,
                          children: skills
                              .map((e) => Chip(label: Text(e.toString())))
                              .toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ListTile(
                        leading: Icon(
                          CupertinoIcons.calendar,
                          color: Colors.blue,
                        ),
                        title: Text(
                          'Experience',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5),
                        child: Text(
                          "${data[len]['experience']} years",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ListTile(
                        leading: Icon(
                          CupertinoIcons.chart_pie,
                          color: Colors.blue,
                        ),
                        title: Text(
                          'Expected Salary',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5),
                        child: Text(
                          data[len]['salary_range'],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      showAlertDialog(
                          user!.id,
                          int.parse(data[len]['id'].toString()),
                          int.parse(widget.jobId.toString()));
                    },
                    child: const Text("Submit"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
