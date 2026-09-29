import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/main_button.dart';
import 'package:flutter_application_1/features/home/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final picker = ImagePicker();
  final nameController = TextEditingController();
  File? _image;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> pickImageFromCamera() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() => _image = File(photo.path));
    }
  }

  Future<void> pickImageFromGallery() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() => _image = File(photo.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Padding(
                        padding: EdgeInsets.all(16.0.r),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Mainbutton(
                              title: 'Camera',
                              ontap: () {
                                Navigator.pop(context);
                                pickImageFromCamera();
                              },
                            ),
                            Mainbutton(
                              title: 'Gallery',
                              ontap: () {
                                Navigator.pop(context);
                                pickImageFromGallery();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFFE8EBF5),
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? Icon(
                            Icons.person,
                            size: 40.r,
                            color: const Color(0xFF3F51B5),
                          )
                        : null,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Create Your Profile',
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1C1E26),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Add your name and profile picture',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 32.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Full Name',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1C1E26),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                TextField(
                  controller: nameController,
                  style: TextStyle(fontSize: 16.sp),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Mainbutton(
                  title: 'Continue',
                  ontap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
