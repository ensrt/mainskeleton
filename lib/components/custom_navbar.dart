import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kartoyun/components/colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange; // Yeni eklenen satır

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabChange, // Yeni eklenen satır
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.acikyesil,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: GNav(
          backgroundColor: MyColors.acikyesil,
          color: MyColors.yesil,
          gap: 8,
          padding: EdgeInsets.all(16),
          activeColor: Colors.black,
          tabBackgroundColor: MyColors.acikyesil,
          selectedIndex: selectedIndex, // Yeni eklenen satır
          tabs: [
            GButton(
              icon: Icons.message_outlined,
              text: "Sohbetler",
              onPressed: () => onTabChange(0), // Yeni eklenen satır
            ),
            GButton(
              icon: Icons.games,
              text: "Kart Oyna",
              onPressed: () => onTabChange(1), // Yeni eklenen satır
            ),
            GButton(
              icon: Icons.person_rounded,
              text: "Profil",
              onPressed: () => onTabChange(2), // Yeni eklenen satır
            ),
          ],
        ),
      ),
    );
  }
}
