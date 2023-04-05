import 'package:flutter/material.dart';
import 'package:hire_me/services/_index.dart';
import 'package:hire_me/utils/_index.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiremeConfig(
    values: HiremeValues(
      baseDomain: 'http://127.0.0.1:8000/api', //replace baseDomain
      authBox: 'hiremeAuth',
    ),
  );

  await HiveServiceImpl().initBoxes();

  return runApp(
    MultiProvider(
      providers: Singleton.registerProvider(),
      child: const HireMe(),
    ),
  );
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
