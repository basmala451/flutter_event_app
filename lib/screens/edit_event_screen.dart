import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/event.dart';
import '../theme/app_colors.dart';
import '../widgets/category_chip.dart';
import '../widgets/event_info_card.dart';



class EditEventScreen extends StatefulWidget {
  final EventModel event;

  const EditEventScreen({super.key, required this.event});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late EventCategory _selectedCategory;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.event.title);
    _descriptionController =
        TextEditingController(text: widget.event.description);
    _selectedCategory = widget.event.category;
    _selectedDate = widget.event.eventDate;
    _selectedTime = widget.event.eventTime;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  void _onUpdatePressed() {
    final updatedEvent = widget.event.copyWith(
      title: _titleController.text,
      description: _descriptionController.text,
      category: _selectedCategory,
      eventDate: _selectedDate,
      eventTime: _selectedTime,
    );
    Navigator.pop(context, updatedEvent);
  }

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
          'Edit event',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            _CoverImage(category: _selectedCategory),
            const SizedBox(height: 16),


            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: EventCategory.all.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final category = EventCategory.all[index];
                  return CategoryChip(
                    category: category,
                    isSelected: category.id == _selectedCategory.id,
                    onTap: () => setState(() => _selectedCategory = category),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            const _FieldLabel('Title'),
            const SizedBox(height: 8),
            _RoundedTextField(controller: _titleController),
            const SizedBox(height: 20),

            const _FieldLabel('Description'),
            const SizedBox(height: 8),
            _RoundedTextField(
              controller: _descriptionController,
              maxLines: 6,
            ),
            const SizedBox(height: 12),

            EditableInfoRow(
              icon: Icons.calendar_today_outlined,
              label: 'Event Date',
              value: DateFormat('MMM d, yyyy').format(_selectedDate),
              onTap: _pickDate,
            ),
            const Divider(height: 1, color: AppColors.border),
            EditableInfoRow(
              icon: Icons.access_time,
              label: 'Event Time',
              value: _selectedTime.format(context),
              onTap: _pickTime,
            ),
            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _onUpdatePressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Update event',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLines;

  const _RoundedTextField({
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.cardBackground,
        contentPadding: const EdgeInsets.all(14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}


class _CoverImage extends StatelessWidget {
  final EventCategory category;

  const _CoverImage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(
        category.label,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w900,
          color: category.color,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
