import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartoyun/components/colors.dart';
import 'package:kartoyun/components/custom_background.dart';
import 'package:kartoyun/components/custom_navbar.dart';
import 'package:kartoyun/home_page.dart';
import 'package:kartoyun/profil_pages/profil.dart';

class KartOynama extends StatefulWidget {
  const KartOynama({Key? key}) : super(key: key);

  @override
  _KartOynamaState createState() => _KartOynamaState();
}

class _KartOynamaState extends State<KartOynama> {
  int _selectedIndex = 1;

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

              if (index == 0) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => HomePage(), // Hedef sayfanızı belirtin
                    transitionDuration: Duration(seconds: 0), // Geçiş süresini ayarlayın
                  ),
                );

              } else if (index == 2) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => Profil(), // Hedef sayfanızı belirtin
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
                  'Kişi Seç',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    color: MyColors.yesil,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Sayfanızın geri kalan içeriğini ekleyin
            ],
          ),
        ),
      ),
    );
  }
}
