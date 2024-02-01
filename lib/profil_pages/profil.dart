import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartoyun/components/colors.dart';
import 'package:kartoyun/components/custom_background.dart';
import 'package:kartoyun/components/custom_navbar.dart';
import 'package:kartoyun/home_page.dart';
import 'package:kartoyun/kart_pages/kart_oyna.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {

  int _selectedIndex = 2;


  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });

              if (index == 1) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => KartOynama(), // Hedef sayfanızı belirtin
                    transitionDuration: Duration(seconds: 0), // Geçiş süresini ayarlayın
                  ),
                );

              } else if (index == 0) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => HomePage(), // Hedef sayfanızı belirtin
                    transitionDuration: Duration(seconds: 0), // Geçiş süresini ayarlayın
                  ),
                );
              }
              // Diğer durumlar için gerekirse eklemeler yapabilirsiniz
            },
          ),
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'Profil',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    color: MyColors.yesil,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
