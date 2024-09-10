import 'package:flutter/material.dart';

class BottomSheetForm extends StatefulWidget {
  const BottomSheetForm({super.key});

  @override
  State<BottomSheetForm> createState() => _BottomSheetFormState();
}

class _BottomSheetFormState extends State<BottomSheetForm>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
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
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return "enter title";
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text("Title"),
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              maxLength: 10,
              controller: _amountController,
              textAlign: TextAlign.start,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return "enter amount";
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text("Amount"),
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: -1,
                  child: IconButton(
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
                    icon: const Icon(Icons.calendar_month_outlined),
                  ),
                ),
                Expanded(
                  child: Text(
                    _selectedDate.toString().isEmpty || _selectedDate == null
                        ? "Select date"
                        : _selectedDate.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Add"))
          ],
        ),
      ),
    );
  }
}
