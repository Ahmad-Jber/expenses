import 'package:expenses/models/category_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BottomSheetForm extends StatefulWidget {
  const BottomSheetForm({super.key});

  @override
  State<BottomSheetForm> createState() => _BottomSheetFormState();
}

class _BottomSheetFormState extends State<BottomSheetForm>
    with SingleTickerProviderStateMixin {
  late DateFormat formatter;
  late AnimationController _controller;
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    formatter = DateFormat.yMMMMd();
    _controller = AnimationController(vsync: this);
    _titleController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10,
      ),
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            TextFormField(
              maxLength: 200,
              controller: _titleController,
              textAlign: TextAlign.start,
              decoration: const InputDecoration(
                label: Text("Title"),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLength: 10,
              controller: _amountController,
              textAlign: TextAlign.start,
              decoration: const InputDecoration(
                label: Text("Amount"),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton.icon(
              onPressed: () {
                showDatePicker(
                        context: context,
                        firstDate: DateTime(2001),
                        lastDate: DateTime(4001))
                    .then((value) {
                  setState(() {
                    _selectedDate = value;
                  });
                });
              },
              icon: const Icon(
                Icons.calendar_month_outlined,
                color: Colors.black54,
              ),
              label: Text(
                _selectedDate.toString().isEmpty || _selectedDate == null
                    ? "Select date"
                    : formatter.format(_selectedDate!),
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
              iconAlignment: IconAlignment.start,
              
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
              items: CategoryEnum.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(e.name),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Add"))
          ],
        ),
      ),
    );
  }
}
