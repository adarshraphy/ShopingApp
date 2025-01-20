import 'package:ecommerce/screens/otp_page.dart';
import 'package:ecommerce/widgets/widget_bottomnav.dart';
import 'package:ecommerce/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GooglePage extends StatefulWidget {
  const GooglePage({super.key});

  @override
  State<GooglePage> createState() => _GooglePageState();
}

class _GooglePageState extends State<GooglePage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isSigningIn = false;

  Future<void> googleSignIn() async {
    if (isSigningIn)
      return;

    setState(() {
      isSigningIn = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("User canceled the sign-in");
        setState(() {
          isSigningIn = false;
        });
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        print("User signed in: ${user.displayName}, Email: ${user.email}");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WidgetBottomnav(index: 0)),
        );
      } else {
        print("Sign-in was unsuccessful");
      }
    } catch (error) {
      print("Sign in failed: $error");
    } finally {
      setState(() {
        isSigningIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 155),
              child: Lottie.asset("assets/images/signup_animation.json"),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome to", style: GoogleFonts.acme(color: Color(0xFF4966f3), fontSize: 25)),
                Text(" Shopista", style: GoogleFonts.acme(color: Color(0xFFd45030), fontSize: 25)),
                Image.asset("assets/images/applogo.png", height: 30, width: 30),
              ],
            ),
            SizedBox(height: 10),
            Text("Your ultimate destination for shopping.", style: GoogleFonts.actor(color: Colors.black, fontSize: 12)),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  hintText: "Enter Your Number",
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 150,
              height: 30,
              child: ElevatedButton(
                child: WidgetText(text: "SENT CODE", color: Colors.white, size: 15, weight: FontWeight.w500),

                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(),));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    indent: 20,
                    endIndent: 10,
                  ),
                ),
                Text('Or Continue with'),
                Expanded(
                  child: Divider(
                    indent: 20,
                    endIndent: 10,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 80,
              child: ElevatedButton(
                child: Image.asset(
                  "assets/images/Google_Icons-09-512.webp",
                  width: 30,
                  height: 30,
                ),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.black,
                ),
                onPressed: googleSignIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
