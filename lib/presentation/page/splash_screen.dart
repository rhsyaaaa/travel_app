// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_build_context_synchronously, prefer_const_literals_to_create_immutables, unused_import, annotate_overrides, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/routing/app_route.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    void initState() {
    Future.delayed(Duration(seconds: 3), () => context.goNamed(Routes.Intro));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Center(child: 
                Image.asset(
                  "assets/traver.png",
                  height: 200,
                  width: 200,
                  )
                )),
            Center(
              child: Text("Version 1.1.0"),
            )
          ],
        ),
    );
  }
}
