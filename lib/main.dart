

import 'package:flutter/material.dart';
import 'dod_swip_design.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3D YouTube Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      // home:  heroAnimation(),
      // home:  FuturisticScrollableHome(),
      // home:  HomePage(),
      // home:  CosmicParallaxCarousel(),
      // home:  GalacticOrbitalCarousel(),
      home:  DotIntroPage(),
    );
  }
}

//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Glassmorphism UI',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: const Color(0xFF0F1923),
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const GlassMorphismUI(),
//         '/gallery': (context) => const GalleryPage(),
//         '/booking': (context) => const BookingPage(),
//         '/map': (context) => const MapPage(),
//         '/profile': (context) => const ProfilePage(),
//       },
//       // Add this as fallback for any undefined routes
//       onUnknownRoute: (settings) {
//         return MaterialPageRoute(
//           builder: (context) => const GlassMorphismUI(),
//         );
//       },
//     );
//   }
// }