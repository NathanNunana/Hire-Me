import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hire_me/providers/_index.dart';
import 'package:hire_me/utils/_index.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var data = {
    "fullname": "",
    "email": "",
    "password": "",
    "c_password": "",
  };
  final _fKey = GlobalKey<FormState>();
  StreamSubscription? authSub;
  signUp() async {
    final navigator = Navigator.of(context);
    try {
      if (_fKey.currentState!.validate()) {
        final auth = context.read<AuthProvider>();
        authSub = auth.sb.auth.onAuthStateChange.listen(onStateChange);
        final res = await auth.signUp(
            fullname: data["fullname"]!,
            email: data["email"]!,
            password: data["password"]!);

        // TODO: Alert the User to verify the email
      }
    } catch (e) {
      print(e);
    }
  }

  onStateChange(AuthState state) {
    // this will handle the verification when the user verified the email redirect
    if (state.session != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          AppRouter.homeRoute, (route) => route.isFirst);
    }
  }

  @override
  void dispose() {
    if (authSub != null) {
      authSub!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _fKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Create New Account",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  onChanged: (v) => data['fullname'] = v,
                  validator: (value) {
                    if (value == null || value.trim() == "") {
                      return "Enter a fullname";
                    }
                    if (value.length <= 3) {
                      return "Fullname must be more than 3 Characters";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'Fullname',
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
                  validator: (value) {
                    if (value == null || value.trim() == "") {
                      return "Please enter email address";
                    }
                    if (!emailREgex.hasMatch(value)) {
                      return "Please enter a valid Email";
                    }
                    return null;
                  },
                  onChanged: (v) => data['email'] = v,
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
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value == null ||
                        value.trim() == "" ||
                        value.length < 6) {
                      return "password must be more than 5 characters";
                    }
                    return null;
                  },
                  onChanged: (v) => data['password'] = v,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'Password',
                      prefixIcon: const Icon(
                        Icons.lock,
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
                  validator: (value) {
                    if (value != data["password"]) {
                      return "Password does not match";
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'Confirm Password',
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.black26,
                        size: 20,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(18))),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Already have an account ?"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
