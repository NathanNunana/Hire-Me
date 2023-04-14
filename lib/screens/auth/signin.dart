import 'package:flutter/material.dart';
import 'package:hire_me/providers/_index.dart';
import 'package:hire_me/utils/_index.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final fKey = GlobalKey<FormState>();

  signIn() async {
    if (fKey.currentState!.validate()) {
      final nav = Navigator.of(context);
      final auth = context.read<AuthProvider>();
      final snackbar = ScaffoldMessenger.of(context);
      final res =
          await auth.signIn(_emailController.text, _passwordController.text);

      if (res) {
        snackbar.showSnackBar(
            const SnackBar(content: Text("Signed in Successfully!")));
        nav.pushReplacementNamed(AppRouter.onboardingRoute);
      } else {
        snackbar.showSnackBar(const SnackBar(content: Text("Sign in Failed!")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool visible = true;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: fKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login to Your Account",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _emailController,
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
                      filled: true,
                      hintText: 'Email',
                      prefixIcon: const Icon(
                        Icons.mail,
                        color: Colors.black26,
                        size: 20,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(18))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _passwordController,
                  validator: (value) => value == null || value.trim() == ""
                      ? "Please enter a password"
                      : null,
                  obscureText: visible,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'Password',
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.black26,
                        size: 20,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          visible ? Icons.visibility : Icons.visibility_off,
                          size: 20,
                          color: Colors.black26,
                        ),
                        onPressed: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(18))),
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              Container(
                padding: const EdgeInsets.all(15.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: signIn,
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: const Text(
                    "Sign in",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRouter.registerRoute);
                },
                child: const Text("Not having an Account? Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
