import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hire_me/providers/_index.dart';
import 'package:hire_me/services/_index.dart';
import 'package:hire_me/utils/_index.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  HiremeConfig(
    values: HiremeValues(
      baseDomain: 'http://127.0.0.1:8000/api', //replace baseDomain
      authBox: 'hiremeAuth',
    ),
  );

  await HiveServiceImpl().initBoxes();

  await Supabase.initialize(
    url: dotenv.get("SUPABASE_URL", fallback: ""),
    anonKey: dotenv.get("SUPABASE_ANON", fallback: ""),
  );

  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => JobProvider(),
        ),
      ],
      // providers: Singleton.registerProvider(),
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
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      initialRoute: AppRouter.initRoute,
      onGenerateRoute: AppRouter.generate,
    );
  }
}
