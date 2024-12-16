import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:management_app/core/constants/global_variable.dart';
import 'package:management_app/core/utils/dialog.dart';
import 'package:management_app/core/utils/snack_bar.dart';
import 'package:management_app/core/utils/time_picker.dart';
import 'package:management_app/data/repositories/calendar_repository.dart';
import 'package:management_app/data/requests/create_calendars_request.dart';
import 'package:management_app/data/requests/delete_calendar_request.dart';
import 'package:management_app/data/requests/get_calendars_request.dart';
import 'package:management_app/data/responses/get_calendars_response.dart';

class ManageCalendarScreen extends StatefulWidget {
  const ManageCalendarScreen({super.key});

  @override
  State<ManageCalendarScreen> createState() => _ManageCalendarScreenState();
}

class _ManageCalendarScreenState extends State<ManageCalendarScreen> {
  EventController<GetCalendarsData?> calendarController =
      EventController<GetCalendarsData?>();
  final ValueNotifier<GetCalendarsData?> currentPick = ValueNotifier(null);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final ValueNotifier<TimeOfDay?> _startTime = ValueNotifier(null);
  final ValueNotifier<TimeOfDay?> _endTime = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    var currentDate = DateTime.now();
    var currentMonth = DateTime(currentDate.year, currentDate.month);
    var nextMonth = DateTime(currentDate.year, currentDate.month + 1);
    var endMonth = nextMonth.subtract(const Duration(seconds: 1));
    var request = GetCalendarsRequest(fromDate: currentMonth, toDate: endMonth);
    fetchData(request);
  }

  Future<void> fetchData(GetCalendarsRequest request) async {
    var events = <CalendarEventData<GetCalendarsData>>[];
    var data = await CalendarRepository().getCalendars(request, context);
    calendarController.removeWhere((e) => true);
    for (var e in data) {
      GetCalendarsData? temp = GetCalendarsData(
          id: e.id, startTime: e.startTime, endTime: e.endTime);
      var event = CalendarEventData<GetCalendarsData>(
          date: DateTime(e.startTime.year, e.startTime.month, e.startTime.day),
          event: temp,
          title: "Work");
      events.add(event);
    }
    calendarController.addAll(events);
  }

  Widget infoItem(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(49, 49, 49, 1),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          value,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(49, 49, 49, 1),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    // list order
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: MonthView<GetCalendarsData?>(
                        controller: calendarController,
                        minMonth: DateTime.now(),
                        maxMonth: DateTime(2050),
                        initialMonth: DateTime.now(),
                        cellAspectRatio: 1,
                        onCellTap: GlobalVariable.scope == 'Restaurant' ? (events, date) {
                          if (events.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                      height: 300,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Create work day - ${DateFormat("yyyy-MM-dd").format(date)}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          Form(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  onTap: () async {
                                                    TimeOfDay? time =
                                                        await selectTime(
                                                            context);
                                                    if (time != null) {
                                                      _startTime.value = time;
                                                      _startController.text =
                                                          formatTimeOfDay(time);
                                                    }
                                                  },
                                                  controller: _startController,
                                                  readOnly: true,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: "Start time",
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromRGBO(
                                                              118, 118, 118, 1),
                                                          width:
                                                              1), // Màu viền khi không được chọn
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            35, 35, 35, 1),
                                                        width: 1,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            182, 0, 0, 1),
                                                        width: 1,
                                                      ),
                                                    ),
                                                    focusedErrorBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            182, 0, 0, 1),
                                                        width: 1,
                                                      ),
                                                    ),
                                                    errorStyle: TextStyle(
                                                        color: Color.fromRGBO(
                                                            182, 0, 0, 1)),
                                                    border: InputBorder.none,
                                                  ),
                                                  style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          49, 49, 49, 1),
                                                      fontSize: 14,
                                                      decoration:
                                                          TextDecoration.none),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Please enter choose start time.";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                TextFormField(
                                                  onTap: () async {
                                                    TimeOfDay? time =
                                                        await selectTime(
                                                            context);
                                                    if (time != null) {
                                                      _endTime.value = time;
                                                      _endController.text =
                                                          formatTimeOfDay(time);
                                                    }
                                                  },
                                                  controller: _endController,
                                                  readOnly: true,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: "End time",
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromRGBO(
                                                              118, 118, 118, 1),
                                                          width:
                                                              1), // Màu viền khi không được chọn
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            35, 35, 35, 1),
                                                        width: 1,
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            182, 0, 0, 1),
                                                        width: 1,
                                                      ),
                                                    ),
                                                    focusedErrorBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            182, 0, 0, 1),
                                                        width: 1,
                                                      ),
                                                    ),
                                                    errorStyle: TextStyle(
                                                        color: Color.fromRGBO(
                                                            182, 0, 0, 1)),
                                                    border: InputBorder.none,
                                                  ),
                                                  style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          49, 49, 49, 1),
                                                      fontSize: 14,
                                                      decoration:
                                                          TextDecoration.none),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Please enter choose your closing time.";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Expanded(
                                              child: SizedBox(
                                            height: 1,
                                          )),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.black
                                                      .withOpacity(0.6),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16,
                                                      vertical: 10),
                                                  textStyle: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          153, 162, 232, 1)),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                ),
                                                child: const Text(
                                                  "CANCEL",
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 40,
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    if (_startTime.value!
                                                            .getTotalMinutes >=
                                                        _endTime.value!
                                                            .getTotalMinutes) {
                                                      showSnackBar(context,
                                                          'start time must be less than end time');
                                                      return;
                                                    }
                                                    var startTime = DateTime(
                                                      date.year,
                                                      date.month,
                                                      date.day,
                                                      _startTime.value!.hour,
                                                      _startTime.value!.minute,
                                                    );
                                                    var endTime = DateTime(
                                                      date.year,
                                                      date.month,
                                                      date.day,
                                                      _endTime.value!.hour,
                                                      _endTime.value!.minute,
                                                    );
                                                    var calendarInput =
                                                        CreateCalendarInput(
                                                            startDate:
                                                                startTime,
                                                            endDate: endTime);
                                                    var request =
                                                        CreateCalendarsRequest(
                                                            inputs: [
                                                          calendarInput
                                                        ]);
                                                    var result =
                                                        await CalendarRepository()
                                                            .createCalendars(
                                                                request,
                                                                context);
                                                    if (result) {
                                                      var currentMonth =
                                                          DateTime(date.year,
                                                              date.month);
                                                      var nextMonth = DateTime(
                                                          date.year,
                                                          date.month + 1);
                                                      var endMonth =
                                                          nextMonth.subtract(
                                                              const Duration(
                                                                  seconds: 1));
                                                      var request =
                                                          GetCalendarsRequest(
                                                              fromDate:
                                                                  currentMonth,
                                                              toDate: endMonth);
                                                      await fetchData(request);
                                                      Navigator.pop(context);
                                                    }
                                                  }
                                                },
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.black,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16,
                                                      vertical: 10),
                                                  textStyle: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          153, 162, 232, 1)),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                ),
                                                child: const Text(
                                                  "SAVE",
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                        } : null,
                        startDay: WeekDays.sunday,
                        onEventLongTap: GlobalVariable.scope == 'Restaurant' ?(event, date) {
                          showDeleteDialog(
                            context,
                            'work day',
                            DateFormat("yyyy-MM-dd")
                                .format(event.event!.startTime),
                            () async {
                              var request = DeleteCalendarsRequest(
                                  ids: [event.event!.id]);
                              bool rs = await CalendarRepository()
                                  .deleteCalendars(request, context);
                              if (rs) {
                                var currentMonth =
                                    DateTime(date.year, date.month);
                                var nextMonth =
                                    DateTime(date.year, date.month + 1);
                                var endMonth = nextMonth
                                    .subtract(const Duration(seconds: 1));
                                var request = GetCalendarsRequest(
                                    fromDate: currentMonth, toDate: endMonth);
                                await fetchData(request);
                                Navigator.pop(context);
                              }
                            },
                          );
                        } : null,
                        onEventTap: (event, date) =>
                            currentPick.value = event.event,
                        onPageChange: (date, page) {
                          var nextMonth = DateTime(date.year, date.month + 1);
                          var endMonth =
                              nextMonth.subtract(const Duration(seconds: 1));
                          var request = GetCalendarsRequest(
                              fromDate: date, toDate: endMonth);
                          fetchData(request);
                        },
                        borderSize: 0.5,
                        showWeekTileBorder: false,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ValueListenableBuilder(
                      valueListenable: currentPick,
                      builder: (context, value, child) {
                        if (value == null) {
                          return const SizedBox();
                        }
                        return Column(
                          children: [
                            const Text(
                              'Time shift',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(49, 49, 49, 1),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            infoItem('Id: ', value.id.toString()),
                            const SizedBox(
                              height: 4,
                            ),
                            infoItem(
                                'Start time: ', value.startTime.toString()),
                            const SizedBox(
                              height: 4,
                            ),
                            infoItem('End time: ', value.endTime.toString())
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            CupertinoIcons.arrow_left,
                            size: 20,
                            color: Color.fromRGBO(49, 49, 49, 1),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Text(
                          'Work days',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(49, 49, 49, 1),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
