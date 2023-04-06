import 'package:flutter/material.dart';

class ReadMore extends StatelessWidget {
  const ReadMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
            image: AssetImage('assets/images/readmore.png'),
            fit: BoxFit.contain,
            alignment: Alignment.centerRight),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: const Text(
                "See how you can find a job easily!",
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5,
                    wordSpacing: .5),
                maxLines: 2,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: const Text(
                "Read more",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}