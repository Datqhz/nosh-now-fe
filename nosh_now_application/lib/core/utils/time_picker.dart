import 'package:flutter/material.dart';

Future<TimeOfDay?> selectTime(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  return picked;
}

String formatTimeOfDay(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

Future<DateTime?> showYearPicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) async {
  DateTime? selectedDate = initialDate;
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width - 40,
          child: YearPicker(
            selectedDate: initialDate,
            onChanged: (DateTime dateTime) {
              selectedDate = dateTime;
              Navigator.pop(context);
            },
            firstDate: firstDate,
            lastDate: lastDate,
          ),
        ),
      );
    },
  );
  return selectedDate;
}

Future<DateTime?> showMonthYearPicker({
  required BuildContext context,
  required DateTime initialDate,
}) async {
  DateTime? selectedDate;
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width - 40,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Text("Select Month & Year"),
                    CalendarDatePicker(
                      initialDate: initialDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                      onDateChanged: (DateTime date) {
                        selectedDate = date;
                      },
                      currentDate: initialDate,
                      initialCalendarMode: DatePickerMode.year,
                    ),
                  ],
                ),
              ),
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
  return selectedDate;
}

Future<DateTime?> selectDate(BuildContext context, int option) async {
  DateTime initialDate = DateTime.now();
  DateTime? picked;
  if (option == 1) {
    picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
  } else if (option == 2) {
    picked = await showMonthYearPicker(
      context: context,
      initialDate: initialDate,
    );
  } else if (option == 3) {
    picked = await showYearPicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
  }
  return picked;
}
