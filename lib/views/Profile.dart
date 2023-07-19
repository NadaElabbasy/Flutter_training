import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
    final String email;
  const Profile({super.key, required this.email,});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 252, 238, 50),
        title: Text("Profile"),
        centerTitle: true,
      ),
      body:
      Column(
        children: [
       Text(widget.email),
      ],
      ),
      
    );
  }
}