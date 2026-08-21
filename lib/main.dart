import 'package:flutter/material.dart';
import 'data/event_data.dart';
import 'screens/event_details_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const EventApp());
}

class EventApp extends StatelessWidget {
  const EventApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Events',
      theme: AppTheme.theme,
      home: EventDetailsScreen(event: EventData.initialEvent),
    );
  }
}
