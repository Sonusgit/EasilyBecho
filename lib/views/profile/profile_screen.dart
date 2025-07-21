import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easilybecho/controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                profileController.fetchProfile(); // 🔁 Only on button tap
              },
              child: const Text("Load Profile"),
            ),
            Expanded(
              child: Obx(() {
                if (profileController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final user = profileController.profile.value;
                if (user == null) {
                  return const Center(child: Text('No profile data available'));
                }

                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text('Name: ${user.payload.shopStoreName}'),
                    Text('Email: ${user.payload.email}'),
                    Text('Phone: ${user.payload.adhaarNumber}'),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
