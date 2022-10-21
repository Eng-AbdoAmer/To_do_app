import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/utils/constants.dart';
import '../../data_source/local/curd.dart';
import 'archive_tasks.dart';
import 'done_tasks.dart';
import 'new_tasks.dart';
import '../../model/note_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var DateController = TextEditingController();

  deleteTasksDetails() {
    titleController.text = '';
    DateController.text = '';
    timeController.text = '';
  }

  @override
  void initState() {
    titleController != TextEditingController;
    timeController != TextEditingController;
    DateController != TextEditingController;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    timeController.dispose();
    DateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var FormKey = GlobalKey<FormState>();
    bool isBottomSheetOpen = false;
    IconData flotIcon = Icons.add;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Create New Taskes',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scaffoldKey.currentState?.showBottomSheet((context) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  color: Colors.transparent,
                  child: Form(
                    key: FormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextFormField(
                          maxLines: 4,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            label: const Text('Task Title'),
                            prefixIcon: Icon(Icons.title),
                          ),
                          controller: titleController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "title must no't be Empty ";
                            } else {
                              return null;
                            }
                          },
                        ),
                        sizeH,
                        TextFormField(
                          keyboardType: TextInputType.datetime,
                          onTap: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((value) {
                              timeController.text =
                                  value!.format(context).toString();
                              print(value.format(context));
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            label: Text('Date Time'),
                            prefixIcon: Icon(
                              Icons.watch_later_outlined,
                            ),
                          ),
                          controller: timeController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "time must no't be Empty ";
                            } else {
                              return null;
                            }
                          },
                        ),
                        sizeH,
                        TextFormField(
                          keyboardType: TextInputType.datetime,
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2025-12-01'))
                                .then((value) {
                              print(DateFormat.yMMMMd().format(value!));
                              DateController.text =
                                  DateFormat.yMMMMd().format(value);
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            label: Text('task Date'),
                            prefixIcon: Icon(
                              Icons.calendar_today,
                            ),
                          ),
                          controller: DateController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Date must no't be Empty ";
                            } else {
                              return null;
                            }
                          },
                        ),
                        sizeH,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 120,
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (FormKey.currentState!.validate()) {
                                      setState(() {
                                        Note note = Note(
                                            noteTitle:
                                                titleController.value.text,
                                            noteDate: DateController.value.text,
                                            noteTime:
                                                timeController.value.text);
                                        saveNoteAtDB(note);
                                        isBottomSheetOpen = false;
                                        Navigator.pop(context);
                                        // Navigator.of(context);
                                      });
                                    }
                                  },
                                  child: Text("save")),
                            ),
                            Container(
                              width: 120,
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () {
                                    deleteTasksDetails();
                                  },
                                  child: Text("Delete")),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        },
        child: Icon(flotIcon),
      ),
      body: NewTaskeScreen(),
    );
  }

  void saveNoteAtDB(Note note) {
    CURD.curd.insertNote(note).then((row) {
      if (row != 0) {
        _ShowSuccessMassage("row inserted");
      } else {
        _ShowErrorMassage("Sorry Error in saveNote");
      }
    });
  }

  void _ShowErrorMassage(String massage) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(massage)));
  }

  void _ShowSuccessMassage(String massageError) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(massageError)));
  }
}
