import 'package:clothes_app/admin/add_user_screen.dart';
import 'package:clothes_app/admin/admin_login.dart';
import 'package:clothes_app/adminn/accounts_list.dart';

import 'package:clothes_app/users/authentification/SignUp_screen.dart';
import 'package:clothes_app/users/authentification/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../admin/add_seller_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Admin Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade100,
                ),
                onPressed: () {
                  _showAddOptions(context);
                },
                child: Text(
                  'Add Options',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade100,
              ),
              onPressed: () {
                Get.to(AccountListScreen());
              },
              child: Text(
                'Delete Options',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.to(AddUserScreen());
                  // Navigate to Add User screen or functionality
                },
                child: Text('Add User'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(AddSellerScreen());
                  // Navigate to Add Seller screen or functionality
                },
                child: Text('Add Seller'),
              ),
            ],
          ),
        );
      },
    );
  }

  
}
