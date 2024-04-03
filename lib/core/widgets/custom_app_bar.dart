import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: MyClipper2(),
          child: Container(
            width: Get.width,
            height: 150,
            color: Colors.indigo.shade900,
          ),
        ),
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            width: Get.width,
            height: 150,
            color: Colors.indigo.shade600,
          ),
        ),
      ],
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * 0.3);

    path.cubicTo(
      size.width / 2,
      size.height / 4,
      size.width * 0.4,
      size.height * 0.90,
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class MyClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);

    path.cubicTo(
      size.width / 2.2,
      size.height / 6,
      size.width * 0.45,
      size.height * 0.90,
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
