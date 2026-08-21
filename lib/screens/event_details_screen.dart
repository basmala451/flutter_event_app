import 'package:flutter/material.dart';
import '../models/event.dart';
import 'package:intl/intl.dart';

import '../theme/app_colors.dart';
import '../widgets/event_info_card.dart';

import 'edit_event_screen.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Event details',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppColors.iconEdit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditEventScreen(event: event),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.iconDelete),
            onPressed: () {

            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            _CoverImage(category: event.category),
            const SizedBox(height: 20),
            Text(
              _subtitleForCategory(event.category.id),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            InfoTile(
              icon: Icons.calendar_today_outlined,
              title: DateFormat('d MMMM').format(event.eventDate),
              subtitle: event.eventTime.format(context),
            ),
            const SizedBox(height: 20),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.descriptionBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                event.description,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String _subtitleForCategory(String categoryId) {
    switch (categoryId) {
      case 'sport':
        return "We're going to play football";
      case 'book_club':
        return "Let's discuss our next book";
      case 'birthday':
        return "It's time to celebrate!";
      default:
        return '';
    }
  }
}


class _CoverImage extends StatelessWidget {
  final EventCategory category;

  const _CoverImage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(
        category.label,
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w900,
          color: category.color,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
