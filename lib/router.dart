import 'dart:io';

import 'package:flutter/material.dart';
import 'package:howsapp/features/select_contacts/screens/select_contact_screen.dart';
import 'package:howsapp/features/chat/screens/mobile_chat_screen.dart';
import 'package:howsapp/features/status/screens/confirm_status_screen.dart';

import 'common/widgets/error.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/otp_screen.dart';
import 'features/auth/screens/user_information_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );

    case OTPScreen.routeName:
      final String verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(
          verificationId: verificationId,
        ),
      );

    case UserInformationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserInformationScreen(),
      );

    case SelectContactScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SelectContactScreen(),
      );

    case MobileChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      return MaterialPageRoute(
        builder: (context) => MobileChatScreen(
          name: name,
          uid: uid,
        ),
      );

    case ConfirmStatusScreen.routeName:
      final File file = settings.arguments as File;
      return MaterialPageRoute(
        builder: (context) => ConfirmStatusScreen(
          file: file,
        ),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page does not exist'),
        ),
      );
  }
}
