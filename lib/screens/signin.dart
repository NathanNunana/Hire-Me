// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool visible = true;
    return Scaffold(
      body: SafeArea(
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
                        (visible) ? Icons.visibility : Icons.visibility_off,
                        size: 20,
                        color: Colors.black26,
                      ),
                      onPressed: () {
                        setState(() {
                          visible != visible;
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
                onPressed: () => Navigator.pushNamed(context, "/home"),
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
          ],
        ),
      ),
    );
  }
}
