import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hire_me/providers/_index.dart';
import 'package:hire_me/utils/_index.dart';
import 'package:provider/provider.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      String route = AppRouter.signIn;

      if (context.read<AuthProvider>().sb.auth.currentUser != null) {
        route = AppRouter.homeRoute;
      }
      Navigator.of(context).pushReplacementNamed(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
