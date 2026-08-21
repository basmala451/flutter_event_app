import 'package:flutter/material.dart';
import '../models/event.dart';
import '../theme/app_colors.dart';

class EditEventScreen extends StatefulWidget {
  final Event event;

  const EditEventScreen({super.key, required this.event});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late DateTime selectedDate;
  late String selectedTime;
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.event.title);
    descriptionController =
        TextEditingController(text: widget.event.description);
    selectedDate = widget.event.date;
    selectedTime = widget.event.time;
    selectedCategory = widget.event.category;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
          ),
          child: child!,
        );
      },
    );

    if (result != null) {
      setState(() => selectedDate = result);
    }
  }

  Future<void> pickTime() async {
    final parts = selectedTime.split(' ');
    final hm = parts.first.split(':');
    final initial = TimeOfDay(
      hour: int.tryParse(hm[0]) ?? 12,
      minute: int.tryParse(hm[1]) ?? 12,
    );

    final result = await showTimePicker(
      context: context,
      initialTime: initial,
    );

    if (result != null) {
      setState(() => selectedTime = result.format(context));
    }
  }

  void save() {
    widget.event
      ..title = titleController.text.trim().isEmpty
          ? 'Untitled event'
          : titleController.text.trim()
      ..description = descriptionController.text.trim()
      ..category = selectedCategory
      ..date = selectedDate
      ..time = selectedTime
      ..imageAsset = selectedCategory == 'Book club'
          ? 'assets/images/book_club.png'
          : 'assets/images/sport.png';

    Navigator.pop(context, true);
  }

  String formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _categorySelector(),
                    const SizedBox(height: 14),
                    _label('Title'),
                    const SizedBox(height: 6),
                    TextField(controller: titleController),
                    const SizedBox(height: 14),
                    _label('Description'),
                    const SizedBox(height: 6),
                    TextField(
                      controller: descriptionController,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 14),
                    _dateRow(),
                    const SizedBox(height: 8),
                    _timeRow(),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: FilledButton(
                        onPressed: save,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                        child: const Text(
                          'Update event',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 18, 4),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.chevron_left, color: AppColors.blue),
          ),
          const Expanded(
            child: Text(
              'Edit event',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: AppColors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categorySelector() {
    return Wrap(
      spacing: 7,
      children: [
        _choice('Book club', Icons.menu_book_outlined),
        _choice('Sport', Icons.sports_soccer_outlined),
        _choice('Birthday', Icons.cake_outlined),
      ],
    );
  }

  Widget _choice(String label, IconData icon) {
    final selected = selectedCategory == label;
    return GestureDetector(
      onTap: () => setState(() => selectedCategory = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? AppColors.lightBlue : Colors.white,
          border: Border.all(
            color: selected ? AppColors.blue : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: AppColors.blue),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.text,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String value) {
    return Text(
      value,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.text,
      ),
    );
  }

  Widget _dateRow() {
    return InkWell(
      onTap: pickDate,
      child: Row(
        children: [
          const Icon(Icons.calendar_month_outlined, size: 30, color: AppColors.blue),
          const SizedBox(width: 7),
          const Text('Event Date', style: TextStyle(fontSize: 15)),
          const Spacer(),
          Text(
            formatDate(selectedDate),
            style: const TextStyle(
              fontSize: 20,
              color: AppColors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeRow() {
    return InkWell(
      onTap: pickTime,
      child: Row(
        children: [
          const Icon(Icons.access_time_outlined, size: 30, color: AppColors.blue),
          const SizedBox(width: 7),
          const Text('Event Time', style: TextStyle(fontSize: 15)),
          const Spacer(),
          Text(
            selectedTime,
            style: const TextStyle(
              fontSize: 20,
              color: AppColors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
