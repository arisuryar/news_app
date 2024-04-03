import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/core/base_state/base_state.dart';
import 'package:news_app/core/widgets/custom_app_bar.dart';
import 'package:news_app/features/authentication/presentation/controller/authentication_controller.dart';

class SignInPage extends StatelessWidget {
  final AuthenticationController authC = Get.find();
  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomAppBar(),
            const Column(
              children: [
                Icon(
                  Icons.newspaper,
                  size: 200,
                  color: Colors.indigo,
                ),
                Text('Baca Berita Yuk', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton(
                  onPressed: () async {
                    await authC.authGoogle().then((_) {
                      final state = authC.baseAuth.value.state;
                      final data = authC.baseAuth.value.data;
                      final message = authC.baseAuth.value.message;

                      if (state == StatusState.loading) {
                        Get.defaultDialog(barrierDismissible: true, content: const CircularProgressIndicator());
                      } else if (state == StatusState.failed) {
                        Get.defaultDialog(content: Text(message));
                      } else if (state == StatusState.loaded) {
                        Get.offAndToNamed('/main', arguments: data);
                      } else {
                        const SizedBox();
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(Get.width, 55),
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    'Masuk dengan Google',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
