import 'package:flutter/material.dart';
import 'models.dart';

class ScheduleScreen extends StatelessWidget {
  final List<Task> tasks;

  const ScheduleScreen({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    // Filter tasks
    final now = DateTime.now();
    final todayTasks = tasks.where((t) =>
        t.date.year == now.year &&
        t.date.month == now.month &&
        t.date.day == now.day).toList();
    
    final upcomingTasks = tasks.where((t) {
      final taskDate = DateTime(t.date.year, t.date.month, t.date.day);
      final todayDate = DateTime(now.year, now.month, now.day);
      return taskDate.isAfter(todayDate);
    }).toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Schedule'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Today'),
              Tab(text: 'Upcoming'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTaskList(context, todayTasks),
            _buildTaskList(context, upcomingTasks),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList(BuildContext context, List<Task> filteredTasks) {
    if (filteredTasks.isEmpty) {
      return const Center(child: Text('No tasks found.'));
    }
    return ListView.builder(
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        final task = filteredTasks[index];
        return ListTile(
          title: Text(task.title),
          subtitle: Text(
            '${task.date.day}/${task.date.month}/${task.date.year} at ${task.time.format(context)}',
          ),
          trailing: Icon(
            task.isCompleted ? Icons.check_circle : Icons.circle_outlined,
            color: task.isCompleted ? Colors.green : Colors.grey,
          ),
        );
      },
    );
  }
}
