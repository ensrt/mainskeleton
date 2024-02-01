import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartoyun/components/colors.dart';
import 'package:kartoyun/components/custom_navbar.dart';
import 'package:kartoyun/kart_pages/kart_oyna.dart';
import 'package:kartoyun/profil_pages/profil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kartoyun/components/custom_background.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late SharedPreferences _prefs;

  List<String> adSoyadList = []; // AdSoyad listesi

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _initPrefs();
    _loadUserInfo();
  }

  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _loadUserInfo() async {
    try {
      // Tüm kullanıcıları çek
      QuerySnapshot allUsersSnapshot =
      await _firestore.collection('Kullanicilar').get();

      List<String> adSoyadList = [];

      // Her bir kullanıcı için adsoyad'ı al ve adSoyadList'e ekle
      if (allUsersSnapshot != null) {
        for (QueryDocumentSnapshot user in allUsersSnapshot.docs) {
          Map<String, dynamic>? userData =
          user.data() as Map<String, dynamic>?;

          if (userData != null && userData['adsoyad'] != null) {
            String adSoyad = userData['adsoyad'];
            adSoyadList.add(adSoyad);
          }
        }
      } else {
        print("Tüm kullanıcılar null, veri alınamadı.");
      }

      // AdSoyadList'i kullanarak kartlar oluşturabilirsiniz
      adSoyadList.forEach((adSoyad) {
        print('AdSoyad: $adSoyad');
      });

      setState(() {
        this.adSoyadList = adSoyadList;
      });
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }

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
                  'Sohbetler',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    color: MyColors.yesil,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: MyColors.arama,
                  ),
                  child: Center(
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 18,
                          color: MyColors.yesil,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'Ara',
                        hintStyle:
                        TextStyle(fontSize: 18, color: MyColors.yesil),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          size: 22.0,
                          color: MyColors.yesil,
                          grade: 5,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              // Firestore'dan çekilen adsoyad'ları listeleyen kartlar
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView.builder(
                    itemCount: adSoyadList.length,
                    itemBuilder: (BuildContext context, int index) {
                      String adSoyad = adSoyadList[index];
                      return Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.person,
                            color: MyColors.yesil,
                            size: 36,
                          ),
                          title: Text(
                            adSoyad,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'adsyad',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
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
