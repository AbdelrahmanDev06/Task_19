import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../add_task/add_task_sheet.dart';
import '../add_task/data/task_model.dart';
import 'widgets/stats_card.dart';
import 'widgets/task_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFDDE0F7),
        onPressed: () => showTaskSheet(context),
        icon: const Icon(Icons.add, color: Color(0xFF1C1E26)),
        label: const Text('Task', style: TextStyle(color: Color(0xFF1C1E26))),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ValueListenableBuilder(
            valueListenable: Hive.box<TaskModel>('tasks').listenable(),
            builder: (context, Box<TaskModel> box, _) {
              final tasks = box.values.toList();
              final done = tasks.where((t) => t.status == 'Done').length;
              final pending = tasks.length - done;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28.r,
                        backgroundColor: const Color(0xFF3F51B5),
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good Morning 👋',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'Ahmed',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.notifications_none),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  StatsCard(total: tasks.length, done: done, pending: pending),
                  SizedBox(height: 24.h),
                  Text(
                    "Today's Tasks",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Expanded(
                    child: tasks.isEmpty
                        ? const Center(child: Text('No tasks yet'))
                        : ListView.builder(
                            padding: EdgeInsets.only(bottom: 90.h),
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                              final task = tasks[index];
                              return TaskCard(
                                task: task,
                                onTap: () => showTaskSheet(context, task: task),
                                onDelete: () => task.delete(),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
