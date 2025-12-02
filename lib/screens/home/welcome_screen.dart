import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC1DDB0),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 120),

            // 🔥 LOGO DAUN
            Transform.translate(
              offset: const Offset(61, 38),
              child: Image.asset(
                "assets/images/logo_daun.png",
                height: 80,
              ),
            ),

            const SizedBox(height: 0),

            // 🔥 TEXT VEGMART
            const Text(
              "VegMart.ID",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A6C38),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 80),

            // 🔥 LOGO BESAR DI TENGAH
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 250, 254, 246),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    "assets/images/logo_vegmart.png",
                    height: 100,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 90),

            // 🔥 TAGLINE
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "“Segar setiap hari, sehat sepanjang hari”",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 80),

            // 🔥 LOGIN BUTTON
            Center(
              child: SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B6E33),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  child: const Text(
                    "login",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔥 SIGNUP BUTTON
            Center(
              child: SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B6E33),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/signup");
                  },
                  child: const Text(
                    "sign-up",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
