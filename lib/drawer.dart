// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:<Widget> [
            UserAccountsDrawerHeader(
              accountName: Text("Harshita Vishwakarma"), 
              accountEmail: Text("vishwakarmaharshita8@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),        
                  ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Account"),
              subtitle: Text("Personal"),
              trailing: Icon(Icons.edit),
            ),
             ListTile(
              leading: Icon(Icons.email),
              title: Text("Email"),
              subtitle: Text("vishwakarmaharshita8@gmail.com"),
              trailing: Icon(Icons.send),
            ),
          ],
        ),
      );
  }
}
