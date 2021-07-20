import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:heligate_contact/heligate_contact.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _contact = 'Chọn 1 contact';

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Heligate Flutter Native Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('Picker'),
                onPressed: () => _getAContact(),
              ),
              Text(_contact)
            ],
          ),
        ),
      ),
    );
  }

  _getAContact() async {
    String contact;
    try {
      contact = await HeligateContact.getAContact();
    } on PlatformException {
      contact = 'Failed to get contact.';
    }
    if (!mounted) return;
    setState(() {
      _contact = contact;
    });
  }
}
