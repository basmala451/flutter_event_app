import '../models/event.dart';

class EventData {
  static final Event initialEvent = Event(
    title: 'We’re going to play football',
    description:
        'Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit eget neque metus. '
        'Nulla non malesuada odio doloribus amet sit. Phasellus nec enim. '
        'Amet consectetur dolor et at. Cras massa diam porta facilisis ipsum.',
    category: 'Sport',
    date: DateTime(2026, 1, 21),
    time: '12:12 PM',
    imageAsset: 'assets/images/sport.png',
  );
}
