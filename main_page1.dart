import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_22/complete_task.dart';
import 'package:flutter_application_22/task.dart';
import 'package:intl/intl.dart';

class Main_Page extends StatefulWidget {
  const Main_Page({super.key});

  @override
  State<Main_Page> createState() => _Main_PageState();
}

class _Main_PageState extends State<Main_Page> {
  TextEditingController _text = TextEditingController();
  TextEditingController _date = TextEditingController();
  DateTime datetime = DateTime.now();
  String newtaskname = "";

  void initState() {
    super.initState();
    _text = TextEditingController();
  }

  List<Task> _tasks = <Task>[];

  // create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("New Task", textAlign: TextAlign.center),
          content: SingleChildScrollView(
              child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  newtaskname = value;
                },
                decoration: const InputDecoration(
                  hintText: "Enter your Task",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: datetime,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (newDate == null) return;
                    setState(() {
                      datetime = newDate;
                    });

                    TimeOfDay? newTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                          hour: datetime.hour, minute: datetime.minute),
                    );
                    if (newTime == null) return;

                    final newDateTime = DateTime(newDate.year, newDate.month,
                        newDate.day, newTime.hour, newTime.minute);

                    setState(() {
                      datetime = newDateTime;
                    });
                  },
                  child: const Text(
                    'Select Date & Time',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  )),
            ],
          )),
          actions: [
            CupertinoDialogAction(
              onPressed: addToList,
              child:
                  const Text("Save", style: TextStyle(color: Colors.blueGrey)),
            ),
            CupertinoDialogAction(
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.blueGrey),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  //add tsk to list
  void addToList() {
    setState(() {
      _tasks.add(Task(
        taskName: newtaskname,
        dateTime: datetime,
      ));
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd - kk:mm').format(datetime);

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: const Color(0xFFEEEFF5),
            appBar: AppBar(
              bottom: const TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.list_outlined),
                  text: 'Tasks',
                ),
                Tab(
                  icon: Icon(Icons.file_download_done_sharp),
                  text: 'Completed',
                )
              ]),
              backgroundColor: Colors.blueGrey,
              title: const Text(
                "Index",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
            ),
            drawer: Drawer(
              backgroundColor: const Color(0xFFEEEFF5),
              child: ListView(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(color: Colors.blueGrey),
                    // ignore: prefer_const_literals_to_create_immutables
                    child: Stack(children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://cdn.dribbble.com/users/899296/screenshots/17086155/media/ab388e976dd78c8432ada54439e5f3cd.png?compress=1&resize=400x300"),
                          radius: 50.0,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Suzan shalaldeh ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ]),
                  ),
                  ListTile(
                    title: const Text(
                      "Index",
                      style: TextStyle(color: Colors.blueGrey, fontSize: 25),
                    ),
                    leading: const Icon(
                      Icons.inbox_rounded,
                      size: 25,
                      color: Color.fromARGB(255, 235, 70, 19),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 290, top: 8),
                  child: const Text(
                    "Tasks",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 400,
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(30),
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 255, 255),
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                          offset: Offset(5.0, 5.0),
                        ),
                      ], borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ListView.builder(
                        itemCount: _tasks.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              // leading: Checkbox(value: value, onChanged: onChanged),
                              title: Text(_tasks[index].taskName),
                              trailing: Text(DateFormat('yyyy/MM/dd --- kk:mm')
                                  .format(_tasks[index].dateTime)),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 20),
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        backgroundColor: Colors.blueGrey,
                        onPressed: createNewTask,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
