import 'package:flutter/material.dart';
import '../theme/app_colors.dart';


class EventCategory {
  final String id;
  final String label;
  final IconData icon;
  final Color color;

  const EventCategory({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
  });

  static const sport = EventCategory(
    id: 'sport',
    label: 'Sport',
    icon: Icons.directions_bike,
    color: AppColors.categorySport,
  );

  static const bookClub = EventCategory(
    id: 'book_club',
    label: 'Book club',
    icon: Icons.menu_book,
    color: AppColors.categoryBookClub,
  );

  static const birthday = EventCategory(
    id: 'birthday',
    label: 'Birthday',
    icon: Icons.cake,
    color: AppColors.categoryBirthday,
  );

  static const List<EventCategory> all = [bookClub, sport, birthday];
}


class EventModel {
  final String id;
  final String title;
  final String description;
  final DateTime eventDate;
  final TimeOfDay eventTime;
  final String coverImagePath;
  final EventCategory category;

  const EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.eventDate,
    required this.eventTime,
    required this.coverImagePath,
    required this.category,
  });

  EventModel copyWith({
    String? title,
    String? description,
    DateTime? eventDate,
    TimeOfDay? eventTime,
    String? coverImagePath,
    EventCategory? category,
  }) {
    return EventModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      eventDate: eventDate ?? this.eventDate,
      eventTime: eventTime ?? this.eventTime,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      category: category ?? this.category,
    );
  }


  static EventModel mock() {
    return EventModel(
      id: '1',
      title: 'Reading book club',
      description:
      'Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit eget neque senectus a. Nulla at non malesuada odio duis lectus amet nisi sit. Risus hac enim maecenas auctor et. At cras massa diam porta facilisi lacus purus. Amet sit ac malesuada quis eget feugiat.',
      eventDate: DateTime(2026, 1, 30),
      eventTime: const TimeOfDay(hour: 23, minute: 22),
      coverImagePath: 'assets/images/book_club_cover.png',
      category: EventCategory.bookClub,
    );
  }
}
