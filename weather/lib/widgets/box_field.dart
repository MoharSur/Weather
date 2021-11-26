import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BoxField extends StatelessWidget {
  FaIcon icon;
  String data, value;

  BoxField({required this.icon, required this.data, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon ,
              const SizedBox(height: 5.0),
              Text(data, style: const TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              )),
              const SizedBox(height: 3.0),
              Text(value, style: const TextStyle(
                color: Colors.white,
                fontSize: 12.0
              )),
            ],
          ),
        ));
  }
}
