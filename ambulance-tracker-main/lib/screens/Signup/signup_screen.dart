// @dart=2.9

import 'dart:io';

import 'package:ambulance_tracker/helper/dialogs.dart';
import 'package:ambulance_tracker/screens/choice_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ambulance_tracker/constants.dart';
import 'package:ambulance_tracker/screens/Login/login_screen.dart';
import 'package:ambulance_tracker/Components/already_have_an_account_acheck.dart';
import 'package:ambulance_tracker/Components/rounded_button.dart';
import 'package:ambulance_tracker/Components/rounded_input_field.dart';
import 'package:ambulance_tracker/Components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  final ValueChanged<String> onChanged;
  Body({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            SizedBox(height: size.height * 0.03),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/images/hands.png",
                width: size.width * 0.7,
              ),
            ),
            TextField(
              controller: emailcontroller,
              onChanged: onChanged,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                icon: Icon(
                  icon,
                  color: kPrimaryColor,
                ),
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
            TextField(
              controller: passwordcontroller,
              obscureText: true,
              onChanged: onChanged,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Password",
                icon: Icon(
                  Icons.lock,
                  color: kPrimaryColor,
                ),
                suffixIcon: Icon(
                  Icons.visibility,
                  color: kPrimaryColor,
                ),
                border: InputBorder.none,
              ),
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async {
                if (emailcontroller.text.isNotEmpty ||
                    passwordcontroller.text.isNotEmpty) {
                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: emailcontroller.text.trim(),
                          password: passwordcontroller.text.trim())
                      .whenComplete(() {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => ChoicePage()));
                    Dialogs.showsnackbar(
                        context, 'Your email has been created');
                  });
                } else {
                  Dialogs.showsnackbar(
                      context, 'Email or Password cannot be empty');
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      // Here i can use size.width but use double.infinity because both work as a same
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 0.25,
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: Color(0xFFD9D9D9),
        height: 1.5,
      ),
    );
  }
}

class SocalIcon extends StatelessWidget {
  final String iconSrc;
  final Function press;
  const SocalIcon({
    Key key,
    this.iconSrc,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSrc,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
