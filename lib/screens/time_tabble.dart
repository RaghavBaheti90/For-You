import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:table_calendar/table_calendar.dart';

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  DateTime _selectedDay = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  TextEditingController _reminderController = TextEditingController();
  Map<DateTime, List<Map<String, String>>> _reminders = {};

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.purple, // Header background color
            colorScheme: ColorScheme.light(
              primary: Colors.purple, // Selected time text color
            ),
            timePickerTheme: TimePickerThemeData(
              dialHandColor: Colors.purple, // Hand color of the clock
              dialBackgroundColor:
                  Colors.grey.shade200, // Background for the dial
              hourMinuteColor: MaterialStateColor.resolveWith(
                  (states) => states.contains(MaterialState.selected)
                      ? Colors.purple // Selected hour and minute color
                      : Colors.white),
              hourMinuteTextColor: MaterialStateColor.resolveWith(
                  (states) => states.contains(MaterialState.selected)
                      ? Colors.white // Text color for selected hour/minute
                      : Colors.black),
            ),
            textTheme: TextTheme(
              headline4: TextStyle(
                color: Colors.purple, // Time picker dial number color
              ),
              button: TextStyle(
                color: Colors.purple, // Custom OK and Cancel buttons text color
              ),
            ),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              buttonColor: Colors.purple, // Button background color
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Set Reminder'),
        leading: IconButton(
          icon: Image.asset('asset/images/back.png'), // Your custom back icon
          onPressed: () {
            Navigator.pop(context); // Back action
          },
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _selectedDay,
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2050, 12, 31),
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            headerStyle: HeaderStyle(
              leftChevronIcon: Image.asset(
                'asset/images/back.png', // Your custom back arrow icon
                height: 24,
                width: 24,
              ),
              rightChevronIcon: Image.asset(
                'asset/images/forward.png', // Your custom next arrow icon
                height: 24,
                width: 24,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: TextField(
              controller: _reminderController,
              decoration: InputDecoration(
                labelText: 'Enter reminder',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Selected Time: ${_selectedTime.format(context)}',
                ),
              ),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: Text(
                  'Select Time',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (_reminderController.text.isNotEmpty) {
                  if (_reminders[_selectedDay] == null) {
                    _reminders[_selectedDay] = [];
                  }
                  _reminders[_selectedDay]!.add({
                    'time': _selectedTime.format(context),
                    'reminder': _reminderController.text,
                  });
                  _reminderController.clear();
                }
              });
            },
            child: Text(
              'Set Reminder',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Expanded(
            child: _reminders.isNotEmpty
                ? ListView(
                    children: _reminders.entries.map((entry) {
                      String formattedDate = DateFormat(
                        'yyyy-MM-dd',
                      ).format(entry.key); // Format the date
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: entry.value.map((reminder) {
                          return Padding(
                            padding: EdgeInsets.all(screenWidth * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, // Distribute the content evenly
                              children: [
                                // Date Text
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    formattedDate,
                                    style: TextStyle(
                                        fontFamily: "Kanit-Regular",
                                        fontSize: screenWidth *
                                            0.04), // Display the formatted date

                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                SizedBox(
                                    width: screenWidth *
                                        0.02), // Space between date and time

                                // Time Text
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    '${reminder['time']}',
                                    style: TextStyle(
                                        fontFamily: "Kanit-Regular",
                                        fontSize: screenWidth * 0.05),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                SizedBox(
                                    width: screenWidth *
                                        0.02), // Space between time and reminder

                                // Reminder Text
                                Flexible(
                                  flex: 2,
                                  child: Text(
                                    '${reminder['reminder']}',
                                    style: TextStyle(
                                        fontFamily: "Kanit-Regular",
                                        fontSize: screenWidth * 0.05),
                                    maxLines: 1,
                                    overflow: TextOverflow
                                        .ellipsis, // Handle overflow text
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  )
                : Center(
                    child: Text('No reminders for selected day'),
                  ),
          )
        ],
      ),
    );
  }
}
