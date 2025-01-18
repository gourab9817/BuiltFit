// lib/Doctors/doctors.dart

import 'package:flutter/material.dart';
import 'package:medjoy/Doctors/doctor_info.dart';
import 'package:medjoy/route/routes.dart'; // For named routes

// A model for doctor data
class Doctor {
  final String name;
  final String title;      // e.g. "Ph.D.", "M.D." etc.
  final String specialty;
  final String imageAsset;
  final double rating;
  final int reviews;

  const Doctor({
    required this.name,
    required this.title,
    required this.specialty,
    required this.imageAsset,
    required this.rating,
    required this.reviews,
  });
}

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({Key? key}) : super(key: key);

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  // Sample doctors list
  final List<Doctor> _doctors = const [
    Doctor(
      name: "Dr. Alexander Bennett",
      title: "Ph.D.",
      specialty: "Dermato-Genetics",
      imageAsset: "assets/doctor1.png",
      rating: 4.5,
      reviews: 40,
    ),
    Doctor(
      name: "Dr. Michael Davidson",
      title: "M.D.",
      specialty: "Solar Dermatology",
      imageAsset: "assets/doctor2.png",
      rating: 4.7,
      reviews: 60,
    ),
    Doctor(
      name: "Dr. Olivia Turner",
      title: "M.D.",
      specialty: "Dermato-Endocrinology",
      imageAsset: "assets/doctor3.png",
      rating: 4.9,
      reviews: 80,
    ),
    Doctor(
      name: "Dr. Sophia Martinez",
      title: "Ph.D.",
      specialty: "Cosmetic Bioengineering",
      imageAsset: "assets/doctor4.png",
      rating: 4.3,
      reviews: 90,
    ),
  ];

  // For the bottom nav bar
  int _selectedIndex = 0;

  // For sort—example choice is "A->Z" by default
  String _sortChoice = "A->Z";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // APP BAR with back arrow, title, icons
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "Doctors",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.blue),
            onPressed: () {
              // TODO: handle profile icon
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.blue),
            onPressed: () {
              // TODO: handle more icon
            },
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            // ---------- SORT ROW ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Text(
                    "Sort By:",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(width: 8),
                  // The actual "A->Z" choice
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _sortChoice,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // The row of sort/filter icons
                  _buildSortIcon(Icons.sort_by_alpha),
                  _buildSortIcon(Icons.filter_alt_outlined),
                  _buildSortIcon(Icons.star_border), // star = favorite screen
                  _buildSortIcon(Icons.male),        // male = male doctors
                  _buildSortIcon(Icons.female),      // female = female doctors
                ],
              ),
            ),

            const SizedBox(height: 8),

            // ---------- MAIN LIST OF DOCTORS ----------
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _doctors.length,
                itemBuilder: (context, index) {
                  final doc = _doctors[index];
                  return _buildDoctorCard(doc);
                },
              ),
            ),
          ],
        ),
      ),

      // ---------- BOTTOM NAV BAR ----------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          // TODO: handle actual navigation if needed
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Helper to build the row of sort icons
  Widget _buildSortIcon(IconData iconData) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.blue.shade50,
        child: IconButton(
          icon: Icon(iconData, color: Colors.blue, size: 16),
          onPressed: () {
            if (iconData == Icons.star_border) {
              // Go to the general favourites
              Navigator.pushNamed(context, Routes.favouriteDoctor);

            } else if (iconData == Icons.male) {
              // Go to the favourite male doctors
              Navigator.pushNamed(context, Routes.favouriteMaleDoctor);

            } else if (iconData == Icons.female) {
              // Go to the favourite female doctors
              Navigator.pushNamed(context, Routes.favouriteFemaleDoctor);

            } else {
              // TODO: handle other sorts/filters if needed
            }
          },
        ),
      ),
    );
  }

  // BUILD DOCTOR CARD
  Widget _buildDoctorCard(Doctor doc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // DOCTOR IMAGE
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(doc.imageAsset),
          ),
          const SizedBox(width: 12),
          // DOCTOR INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${doc.name}, ${doc.title}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  doc.specialty,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 8),

                // Info + rating + reviews + heart
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      onPressed: () {
                        // Navigate to doctor info screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DoctorInfoScreen(doctor: doc),
                          ),
                        );
                      },
                      child: const Text("Info"),
                    ),
                    const SizedBox(width: 8),

                    // rating
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text(
                          doc.rating.toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),

                    // reviews
                    Row(
                      children: [
                        const Icon(Icons.people_outline, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          doc.reviews.toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),

                    const SizedBox(width: 16),
                    // Heart icon (currently no navigation)
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      color: Colors.redAccent,
                      onPressed: () {
                        // Optional: handle "like" or toggle favorite
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
