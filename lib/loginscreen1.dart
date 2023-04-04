import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  // const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Text("Login Account"),
              Text("E-mail | Phone no"),
              TextFormField(
                decoration: const InputDecoration(
                    //prefixIcon: Icon(Icons.person_outline_outlined),
                    //labelText: temail,
                    hintText: "E-mail",
                    border: OutlineInputBorder()),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    //prefixIcon: Icon(Icons.person_outline_outlined),
                    //labelText: temail,
                    hintText: "Password",
                    border: OutlineInputBorder()),
              ),
              ElevatedButton(onPressed: null, child: Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
