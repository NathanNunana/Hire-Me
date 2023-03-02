import 'package:flutter/material.dart';
import 'package:hire_me/utils/_index.dart';

void main() {
  HiremeConfig(
    values: HiremeValues(
      baseDomain: 'http://127.0.0.1:8000/api', //replace baseDomain
      authBox: 'hiremeAuth',
    ),
  );

  return runApp(const HireMe());
}

class HireMe extends StatelessWidget {
  const HireMe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hire Me',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      initialRoute: AppRouter.initRoute,
      onGenerateRoute: AppRouter.generate,
    );
  }
}
