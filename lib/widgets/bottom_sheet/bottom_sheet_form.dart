import 'package:expenses/extensions.dart';
import 'package:expenses/models/category_enum.dart';
import 'package:expenses/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BottomSheetForm extends StatefulWidget {
  const BottomSheetForm(
      {super.key, required this.onAddExpense, required this.parentContext});

  final void Function(Expense expense) onAddExpense;
  final BuildContext parentContext;

  @override
  State<BottomSheetForm> createState() => _BottomSheetFormState();
}

class _BottomSheetFormState extends State<BottomSheetForm>
    with SingleTickerProviderStateMixin {
  late DateFormat formatter;
  late AnimationController _controller;
  late TextEditingController _titleController;
  late TextEditingController _amountController;

  late GlobalKey<FormState> _formKey;
  String? _titleError;
  String? _amountError;
  late Color iconColor;
  late Color dateTextColor;
  DateTime? _selectedDate;
  CategoryEnum? _selectedCategory;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    formatter = DateFormat.yMMMMd();
    _controller = AnimationController(vsync: this);
    _titleController = TextEditingController();
    _amountController = TextEditingController();
    _descriptionController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    iconColor = Colors.black;
    dateTextColor = Colors.black;
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
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  maxLength: 200,
                  controller: _titleController,
                  textAlign: TextAlign.start,
                  onChanged: (value) => setState(() {
                    _titleError = null;
                  }),
                  decoration: InputDecoration(
                    label: const Text("Title"),
                    errorText: _titleError,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLength: 10,
                  controller: _amountController,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => setState(() {
                    _amountError = null;
                  }),
                  decoration: InputDecoration(
                    label: const Text("Amount"),
                    errorText: _amountError,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                DropdownButtonFormField(
                  items: CategoryEnum.values.map(
                    (e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e.name),
                      );
                    },
                  ).toList(),
                  hint: const Text(
                    'Select Category',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextButton.icon(
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    color: iconColor,
                  ),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime(2001),
                      lastDate: DateTime(4001),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          iconColor = Colors.black;
                          dateTextColor = Colors.black;
                        });
                      }
                      setState(() {
                        _selectedDate = value;
                      });
                    });
                  },
                  label: Text(
                    _selectedDate.toString().isEmpty || _selectedDate == null
                        ? "Select date"
                        : formatter.format(_selectedDate!),
                    style: TextStyle(
                      color: dateTextColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  maxLines: 5,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.text,
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    label: Text(
                      "Description",
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      bool isSuccess = false;
                      if (_selectedDate == null) {
                        setState(() {
                          iconColor = const Color(0XFFB91A1B);
                          dateTextColor = const Color(0XFFB91A1B);
                        });
                      } else {
                        isSuccess = true;
                      }
                      if (_formKey.currentState!.validate()) {
                        final String enteredTitle = _titleController.text;
                        if (_titleController.isWhitespace()) {
                          setState(() {
                            _titleError = "Enter title";
                          });
                        } else {
                          isSuccess = true;
                        }
                        late double enteredAmount;
                        try {
                          if (_amountController.isWhitespace()) {
                            setState(() {
                              _amountError = "Enter amount";
                            });
                          } else {
                            enteredAmount =
                                double.parse(_amountController.text);
                            isSuccess = true;
                          }
                        } catch (e) {
                          debugPrint(e.toString());
                          setState(() {
                            _amountError = "Invalid amount";
                          });
                        }

                        if (isSuccess) {
                          final CategoryEnum enteredCategory =
                              _selectedCategory!;
                          final DateTime enteredDate = _selectedDate!;
                          final String enteredDescription =
                              _descriptionController.text;
                          debugPrint(enteredTitle);
                          debugPrint(enteredAmount.toString());
                          debugPrint(enteredCategory.toString());
                          debugPrint(formatter.format(enteredDate));
                          widget.onAddExpense(
                            Expense(
                              title: enteredTitle,
                              amount: enteredAmount,
                              category: enteredCategory,
                              date: enteredDate,
                              description: enteredDescription,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Added Successfully",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.green,
                              elevation: 1,
                            ),
                          );
                          Navigator.pop(
                            widget.parentContext,
                          );
                        }
                      }
                    },
                    child: const Text(
                      "Add",
                    ),
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}
