// The ButtonComponent widget represents a customized button used multiple times in the app.

// Import necessary packages
import 'package:flutter/material.dart';

// Define the ButtonComponent widget
class ButtonComponent extends StatelessWidget {
  // Define properties required for the button
  final String btnTxt;
  final Color btnColor;
  final Color txtColor;
  final String btnIcon;

  // Constructor to initialize the properties
  const ButtonComponent({
    Key? key,
    required this.btnTxt,
    required this.btnColor,
    required this.txtColor,
    required this.btnIcon,
  }) : super(key: key);

  // Build method to create the button's UI
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          // Define the action when the button is pressed (to be implemented)
        },
        style: ElevatedButton.styleFrom(
          elevation: 10,
          primary: btnColor, // Background color
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 68.0),
          child: Row(
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Image.asset(btnIcon),
              ),
              SizedBox(width: 10,),
              Text(
                btnTxt,
                style: TextStyle(color: txtColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
