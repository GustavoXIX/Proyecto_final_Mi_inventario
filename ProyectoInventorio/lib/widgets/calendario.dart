import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarFormField extends StatefulWidget {
  const CalendarFormField({
    Key? key,
    required this.controller,
    required this.onDateSelected,
    required this.hintText,
    required this.labelText,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(DateTime) onDateSelected;
  final String hintText;
  final String labelText;
  final String? Function(String?)? validator;

  @override
  _CalendarFormFieldState createState() => _CalendarFormFieldState();
}

class _CalendarFormFieldState extends State<CalendarFormField> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        widget.controller.text = DateFormat('dd/MM/yyyy').format(picked);
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller.text.isNotEmpty) {
      _selectedDate = DateFormat('dd/MM/yyyy').parse(widget.controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 160.0),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: TextInputType.datetime,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          prefixIcon: const Icon(Icons.calendar_today),
          fillColor: Theme.of(context).cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onTap: () => _selectDate(context),
      ),
    );
  }
}
