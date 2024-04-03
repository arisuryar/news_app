// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:news_app/core/presentation/account_page.dart';
import 'package:news_app/core/widgets/custom_app_bar.dart';
import 'package:news_app/features/news/presentation/pages/home_page.dart';
import 'package:news_app/features/news/presentation/pages/search_page.dart';

class MainPage extends StatelessWidget {
  MainPage({
    super.key,
    required this.user,
  });
  final User user;
  final controller = MainController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 150),
        child: const CustomAppBar(),
      ),
      body: Obx(() => controller.page[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(() => NavigationBar(
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (value) {
              controller.selectedIndex.value = value;
            },
            indicatorColor: Colors.transparent,
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            height: 65,
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(Icons.home, color: Colors.indigo),
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.search, color: Colors.indigo),
                icon: Icon(Icons.search_outlined),
                label: 'Cari',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.person, color: Colors.indigo),
                icon: Icon(Icons.person_outline),
                label: 'Akun',
              ),
            ],
          )),
    );
  }
}

class MainController extends GetxController {
  List<Widget> page = [
    const HomePage(),
    const SearchPage(),
    const AccountPage(),
  ].obs;

  var selectedIndex = 0.obs;
}
