import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:news_app/core/presentation/account_page.dart';
import 'package:news_app/core/presentation/main_page.dart';

import 'package:news_app/features/authentication/presentation/controller/authentication_controller.dart';
import 'package:news_app/features/authentication/presentation/presentaiton/sign_in_page.dart';
import 'package:news_app/features/news/presentation/pages/home_page.dart';
import 'package:news_app/features/news/presentation/pages/search_page.dart';
import 'package:news_app/features/news/presentation/pages/web_view_page.dart';
import 'package:news_app/firebase_options.dart';

import 'package:news_app/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependenciesBindings().dependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  final AuthenticationController authC = Get.find();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: authC.userStatus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Tampilkan loading atau splash screen jika masih menunggu
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.connectionState == ConnectionState.active) {
            // Jika inisialisasi selesai, cek status pengguna
            if (snapshot.data == null) {
              // Jika pengguna belum masuk, arahkan ke halaman masuk
              return SignInPage();
            } else {
              // Jika pengguna sudah masuk, arahkan ke halaman utama
              return MainPage(user: snapshot.data!);
            }
          }
          // Handle kondisi lain jika diperlukan
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
      getPages: [
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/main', page: () => MainPage(user: authC.currentUsers)),
        GetPage(name: '/sign-in', page: () => SignInPage()),
        GetPage(name: '/search', page: () => const SearchPage()),
        GetPage(name: '/web-page', page: () => const WebViewPage()),
        GetPage(name: '/account', page: () => const AccountPage()),
      ],
    );
  }
}
