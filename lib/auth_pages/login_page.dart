import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kartoyun/auth_pages/register_page.dart';
import 'package:kartoyun/components/custom_background.dart';
import 'package:kartoyun/home_page.dart';
import 'package:kartoyun/components/colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkIfUserLoggedIn();
  }

  void _checkIfUserLoggedIn() async {
    Map<String, String> credentials = await AppPreferences.getUserCredentials();

    if ((credentials['email'] ?? '').isNotEmpty && (credentials['password'] ?? '').isNotEmpty) {
      _emailController.text = credentials['email']!;
      _passwordController.text = credentials['password']!;
      _login(context);
    }
  }



  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                padding: const EdgeInsets.all(26.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 120),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hoşgeldiniz!',
                          style: GoogleFonts.inter(
                            fontSize: 28,
                            color: MyColors.yesil,
                          ),
                        ),
                        Text(
                          'Bilgilerinizi girerek giriş yapabilirsiniz.',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            color: MyColors.koyugri,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 26,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _emailController,
                          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.normal),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: GoogleFonts.inter(color: MyColors.koyugri, fontSize: 16),
                            contentPadding: EdgeInsets.symmetric(vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: MyColors.acikgri,
                            prefixIcon: Icon(Icons.email, color: MyColors.koyugri,),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: MyColors.yesil),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: MyColors.acikbeyaz),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),

                        SizedBox(height: 16),
                        TextField(
                          controller: _passwordController,
                          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.normal),
                          decoration: InputDecoration(
                            labelText: 'Şifre',
                            labelStyle: GoogleFonts.inter(color: MyColors.koyugri, fontSize: 16),
                            contentPadding: EdgeInsets.symmetric(vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: MyColors.acikgri,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: MyColors.koyugri,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: MyColors.yesil),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: MyColors.acikbeyaz),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () => _login(context),
                          child: Text(
                            'Giriş Yap',
                            style: GoogleFonts.inter(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            minimumSize: Size(double.infinity, 5),
                            primary: MyColors.yesil,
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(8.0),
                  color: MyColors.acikyesil,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Bir hesabın yok mu?",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: MyColors.koyugri,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                          );
                        },
                        child: Column(
                          children: [
                            Text(
                              'Kayıt Ol',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: MyColors.yesil,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 0),
                              height: 1,
                              width: 60,
                              color: MyColors.yesil,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      String uid = userCredential.user!.uid;
      await AppPreferences.saveUserCredentials(_emailController.text, _passwordController.text, uid);

      print('Giriş başarılı. Kullanıcı ID: $uid');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      print('Hata: $e');
    }
  }
}

class AppPreferences {
  static const String KEY_EMAIL = 'email';
  static const String KEY_PASSWORD = 'password';
  static const String KEY_UID = 'uid';

  static Future<void> saveUserCredentials(String email, String password, String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KEY_EMAIL, email);
    prefs.setString(KEY_PASSWORD, password);
    prefs.setString(KEY_UID, uid);
  }

  static Future<Map<String, String>> getUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString(KEY_EMAIL) ?? '';
    String password = prefs.getString(KEY_PASSWORD) ?? '';
    String uid = prefs.getString(KEY_UID) ?? '';
    return {'email': email, 'password': password, 'uid': uid};
  }
}
