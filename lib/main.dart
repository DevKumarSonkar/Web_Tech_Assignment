import 'package:flutter/material.dart';
import 'models.dart';
import 'tasks_screen.dart';
import 'schedule_screen.dart';
import 'notes_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minimal Task App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  // Global State
  List<Task> tasks = [];
  List<Note> notes = [];

  // Functions to modify state
  void _addTask(String title, DateTime date, TimeOfDay time) {
    setState(() {
      tasks.add(Task(title: title, date: date, time: time));
    });
  }

  void _toggleTask(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _addNote(String title, String content) {
    setState(() {
      notes.add(Note(title: title, content: content));
    });
  }

  @override
  Widget build(BuildContext context) {
    // List of screens to show
    final List<Widget> screens = [
      TasksScreen(
        tasks: tasks,
        onAddTask: _addTask,
        onToggleComplete: _toggleTask,
        onDeleteTask: _deleteTask,
      ),
      ScheduleScreen(tasks: tasks),
      NotesScreen(
        notes: notes,
        onAddNote: _addNote,
      ),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'Notes',
          ),
        ],
      ),
    );
  }
}
