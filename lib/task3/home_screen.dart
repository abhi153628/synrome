import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(mainAxisAlignment: MainAxisAlignment.center,children: [Center(child: Text('THIS IS HOMEPAGE',style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold,fontSize: 30),))],),);
  }
}