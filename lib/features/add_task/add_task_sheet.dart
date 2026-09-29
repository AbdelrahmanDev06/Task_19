import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/task_model.dart';

const List<String> taskStatuses = ['Pending', 'In Progress', 'Done'];

const List<Color> taskColors = [
  Color(0xFF2196F3),
  Color(0xFF4CAF50),
  Color(0xFFFF9800),
  Color(0xFF9C27B0),
];

void showTaskSheet(BuildContext context, {TaskModel? task}) {
  final titleController = TextEditingController(text: task?.title ?? '');
  final subtitleController = TextEditingController(text: task?.subtitle ?? '');
  String status = task?.status ?? 'Pending';
  int colorValue = task?.colorValue ?? taskColors[0].value;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) => StatefulBuilder(
      builder: (context, setSheetState) => Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 20.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task == null ? 'New Task' : 'Edit Task',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: subtitleController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              children: taskStatuses
                  .map(
                    (s) => ChoiceChip(
                      label: Text(s),
                      selected: status == s,
                      onSelected: (_) => setSheetState(() => status = s),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 12.h),
            Row(
              children: taskColors
                  .map(
                    (c) => GestureDetector(
                      onTap: () => setSheetState(() => colorValue = c.value),
                      child: Container(
                        margin: EdgeInsets.only(right: 10.w),
                        width: 30.r,
                        height: 30.r,
                        decoration: BoxDecoration(
                          color: c,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colorValue == c.value
                                ? Colors.black
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F51B5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () {
                  if (titleController.text.trim().isEmpty) return;
                  final box = Hive.box<TaskModel>('tasks');
                  if (task == null) {
                    box.add(
                      TaskModel(
                        title: titleController.text.trim(),
                        subtitle: subtitleController.text.trim(),
                        status: status,
                        colorValue: colorValue,
                      ),
                    );
                  } else {
                    task.title = titleController.text.trim();
                    task.subtitle = subtitleController.text.trim();
                    task.status = status;
                    task.colorValue = colorValue;
                    task.save();
                  }
                  Navigator.pop(sheetContext);
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
