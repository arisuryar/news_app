import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:news_app/features/authentication/presentation/controller/authentication_controller.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({
    super.key,
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final AuthenticationController authC = Get.find();

  @override
  void dispose() {
    super.dispose();
    authC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              authC.currentUsers.photoURL == null
                  ? Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        color: Colors.grey[300],
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 64,
                        color: Colors.black,
                      ),
                    )
                  : Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        image: DecorationImage(
                          image: NetworkImage(authC.currentUsers.photoURL!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              Text(authC.currentUsers.displayName!.capitalizeFirst!,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(authC.currentUsers.email!, style: const TextStyle(fontSize: 18, color: Colors.grey)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ElevatedButton(
                onPressed: () async {
                  await Get.defaultDialog(
                    title: 'Keluar',
                    middleText: 'Apakah anda yakin ingin keluar?',
                    textConfirm: 'Ya',
                    textCancel: 'Tidak',
                    onCancel: () => Get.back(),
                    onConfirm: () async {
                      await authC.logout.then((value) {
                        Get.back();
                        Get.back();
                        Get.offAndToNamed('/sign-in');
                      });
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(Get.width, 55),
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Keluar',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ),
        ],
      ),
    );
  }
}
