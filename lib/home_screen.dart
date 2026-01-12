import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import 'drawer_menu.dart'; // keep this file in lib/

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String statusText = 'Press SOS';
  bool _sending = false;

  /// 🔴 REAL SOS LOGIC
  Future<void> sendSOS() async {
    if (_sending) return; // prevent spam taps
    _sending = true;

    setState(() {
      statusText = 'Getting live location...';
    });

    // 1️⃣ Check GPS
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        statusText = 'Location service OFF';
        _sending = false;
      });
      return;
    }

    // 2️⃣ Permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        statusText = 'Location permission permanently denied';
        _sending = false;
      });
      return;
    }

    // 3️⃣ Get fresh GPS location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      forceAndroidLocationManager: true,
    );

    // 4️⃣ Send to Firestore
    await FirebaseFirestore.instance.collection('sos_alerts').add({
      'latitude': position.latitude,
      'longitude': position.longitude,
      'timestamp': FieldValue.serverTimestamp(),
      'status': 'active',
    });

    setState(() {
      statusText =
          'SOS SENT\nLat: ${position.latitude}\nLng: ${position.longitude}';
      _sending = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('SOS sent with live location'),
        backgroundColor: Colors.red,
      ),
    );

    debugPrint('SOS SENT WITH LIVE LOCATION');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Smart Ambulance',
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_hospital, size: 64, color: Colors.red),
            const SizedBox(height: 16),

            Text(
              statusText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 30),

            /// 🔴 SOS BUTTON
            GestureDetector(
              onTap: sendSOS,
              child: Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.45),
                      blurRadius: 30,
                      spreadRadius: 12,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'SOS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Press only in real emergency',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),

      /// 🔻 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Booking'),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_taxi),
            label: 'Ambulance',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
