import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String pathName = '/home';

  @override
  Widget build(BuildContext context) {
    return const HomePageScreen();
  }
}

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Text(
                'How fast can you buy product?',
                style: GoogleFonts.poppins(fontSize: 35),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                  colors: [Color(0xff6210E1), Color(0xff2503B9)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Text(
                  'Play',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: Colors.white.withOpacity(.80),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
