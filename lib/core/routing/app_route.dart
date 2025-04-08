// ignore_for_file: prefer_const_constructors, unused_import, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/model.dart';
import 'package:flutter_application_1/presentation/page/detail.dart';
import 'package:flutter_application_1/presentation/page/forgot_password.dart';
import 'package:flutter_application_1/presentation/page/home.dart';
import 'package:flutter_application_1/presentation/page/introduction.dart';
import 'package:flutter_application_1/presentation/page/login.dart';
import 'package:flutter_application_1/presentation/page/new_password.dart';
import 'package:flutter_application_1/presentation/page/notif_forgotPassword.dart';
import 'package:flutter_application_1/presentation/page/notif_success.dart';
import 'package:flutter_application_1/presentation/page/otp_verifikasi.dart';
import 'package:flutter_application_1/presentation/page/register.dart';
import 'package:flutter_application_1/presentation/page/search.dart';
import 'package:flutter_application_1/presentation/page/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

part 'rout_name.dart';

final appRoute = GoRouter(routes: [
  GoRoute(
    path: '/Home',
    name: Routes.home,
    builder: (context, state) =>  HomeScreen(),
  ),
  GoRoute(
    path: '/detail',
    name: Routes.detail,
    builder: (context, state) {
      final _data = state.extra as DetailWisata;
      return DetailScreen(data: _data);
    },
  ),
  GoRoute(
    path: '/search',
    name: Routes.search,
    builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>? ?? {};
      final String searchQuery = extra['searchQuery'] as String? ?? "";
      final int categoryID = extra['categoryID'] as int? ?? 0;
      return SearchScreen(categoryID: categoryID, searchQuery: searchQuery);
    },
  ),
  GoRoute(
    path: '/',
    name: Routes.splash,
    builder: (context, state) =>  SplashScreen(),
  ),
  GoRoute(
    path: '/intro',
    name: Routes.Intro,
    builder: (context, state) => ScreenIntroduction(),
  ),
  GoRoute(
    path: '/login',
    name: Routes.login,
    builder: (context, state) => LoginScreen(),
  ),
  GoRoute(
    path: '/register',
    name: Routes.register,
    builder: (context, state) => RegisterScreen(),
  ),
  GoRoute(
    path: '/forgot_password',
    name: Routes.forgot_password,
    builder: (context, state) => const ForgotPasswordScreen(),
  ),
  GoRoute(
    path: '/otp_verification',
    name: Routes.otp_verifikasi,
     builder: (context, state) {
        final email = state.extra as String;
        return OtpVerification(email: email);
        }),
  GoRoute(
    path: '/new_password',
    name: Routes.new_password,
    builder: (context, state) => NewPassword(),
  ),
  GoRoute(
    path: '/notif_success',
    name: Routes.notif_success,
    builder: (context, state) => NotifSuccesScreen(),
  ),
  GoRoute(
    path: '/notif_success_forgot_password',
    name: Routes.notif_success_forgot_password,
    builder: (context, state) => SuccessForgotPassword(),
  ),
]);