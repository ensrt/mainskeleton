import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kartoyun/auth_pages/login_page.dart';
import 'package:kartoyun/components/custom_background.dart';
import 'package:kartoyun/components/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void _register() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        await _firestore.collection('Kullanicilar').doc(userCredential.user!.uid).set({
          'email': _emailController.text,
          'adsoyad': _nameController.text,
          'uid': userCredential.user!.uid,
        });
        // Kayıt işlemi başarılı, başka bir sayfaya yönlendirme vb. yapabilirsiniz.
      } else {
        print('Auth işlemi başarısız.');
      }
    } catch (e) {
      print('Hata: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false, // Klavye açıldığında alttaki kartın yukarı doğru çıkmasını engeller.
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(26.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 140),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hesap Oluşturun!',
                        style: GoogleFonts.inter(
                          fontSize: 28,
                          color: MyColors.yesil,
                        ),
                      ),
                      Text(
                        'Başlamak için kayıt olun.',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: MyColors.koyugri,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 26),
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
                  SizedBox(height: 16),
                  TextField(
                    controller: _nameController,
                    style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.normal),
                    decoration: InputDecoration(
                      labelText: 'Ad Soyad',
                      labelStyle: GoogleFonts.inter(color: MyColors.koyugri, fontSize: 16),
                      contentPadding: EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: MyColors.acikgri,
                      prefixIcon: Icon(
                        Icons.person_rounded,
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
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _register,
                    child: Text(
                      'Kayıt Ol',
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
                      "Zaten bir hesabınız var mı?",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: MyColors.koyugri,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Burada LoginPage'e yönlendirme işlemini gerçekleştiriyoruz
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()), // LoginPage'e yönlendir
                        );
                      },
                      child: Column(
                        children: [
                          Text(
                            'Giriş Yap',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: MyColors.yesil, // Giriş Yap rengi
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
    );
  }
}
