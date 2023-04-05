import 'package:flutter/material.dart';
import 'dart:math' as math;

class CompanyCard extends StatelessWidget {
  const CompanyCard({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var boxSize = 40.0;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: ClipPath(
        clipper: CustomClipCard(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black45,
          ),
          width: size.width / 1.45,
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: boxSize,
                      width: boxSize,
                      child: const Icon(
                        Icons.facebook,
                        size: 30,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Facebook",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "5 Job Vacancy",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 18.0),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.location_pin,
                          size: 18,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Canada + Ghana",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.location_pin,
                          size: 18,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "FullTime + PartTime",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                width: double.infinity,
                child: const Center(
                    child: Text(
                  "Show All",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.blue),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomClipCard extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path()
      ..moveTo(60, 0)
      ..arcTo(
        const Rect.fromLTWH(60, 0, 5 * 2, 5 * 2),
        math.pi,
        math.pi / 2,
        false,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 60)
      ..arcTo(
        const Rect.fromLTWH(0, 60, 5 * 2, 5 * 2),
        math.pi,
        math.pi / 2,
        false,
      )
      ..lineTo(60, 60)
      ..moveTo(0, 0)
      ..lineTo(50, 0)
      ..lineTo(50, 50)
      ..lineTo(0, 50)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
