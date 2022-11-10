import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      // backgroundColor: isDarkMode ? tSecondaryColor : tPrimaryColor,
      body: Container(
        padding: const EdgeInsets.all(7),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            /*Hero(
            tag: 'welcome-image-tag',
            child: Image(
                image: const AssetImage('Image'),
                height: 0.6)),*/
        Column(
          children: [
            Text('tWelcomeTitle',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline3), //
            Text('tWelcomeSubTitle',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1,
                textAlign: TextAlign.center), // Text
          ],
        ), // Column
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                child: Text('tLogin.toUpperCase'
                ), // OutlinedButton
              ), // Expanded
            ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text('tSignup.toUpperCase'
                ), // ElevatedButton
              ), // Expanded
              ],
            ) // Row
          ],
        ), // Column
      ), // Container
    ); // Scaffold
  }
}