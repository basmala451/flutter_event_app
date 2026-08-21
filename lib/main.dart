import 'package:event_ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'models/event.dart';

import 'screens/event_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: EventDetailsScreen(event: EventModel.mock()),
    );
  }
}
