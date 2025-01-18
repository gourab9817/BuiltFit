// lib/doctor_info.dart

import 'package:flutter/material.dart';
import 'package:medjoy/Doctors/doctors.dart'; // to access the Doctor model

class DoctorInfoScreen extends StatefulWidget {
  final Doctor doctor;

  const DoctorInfoScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  State<DoctorInfoScreen> createState() => _DoctorInfoScreenState();
}

class _DoctorInfoScreenState extends State<DoctorInfoScreen> {
  // For the bottom nav bar
  int _selectedIndex = 0;

  // Some example experience, focus, schedule
  final String _experienceText = "15 years experience";
  final String _focusText =
      "Focus: The impact of hormonal imbalances on skin,\n"
      "specializing in acne, hirsutism, and autoimmune disorders.";
  final String _scheduleText = "Mon-Sat / 9:00AM - 5:00PM";

  // For "Sort By: A->Z" row at the top
  String _sortChoice = "A->Z";

  @override
  Widget build(BuildContext context) {
    final doc = widget.doctor;
    return Scaffold(
      backgroundColor: Colors.white,

      // APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Doctor Info",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.blue),
            onPressed: () {
              // TODO: handle
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.blue),
            onPressed: () {
              // TODO: handle
            },
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Sort row (similar to doctors.dart)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Text(
                      "Sort By:",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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

                    // same set of icons
                    _buildSortIcon(Icons.sort_by_alpha),
                    _buildSortIcon(Icons.filter_alt_outlined),
                    _buildSortIcon(Icons.star_border),
                    _buildSortIcon(Icons.male),
                    _buildSortIcon(Icons.female),
                  ],
                ),
              ),

              const SizedBox(height: 8),
              // DOCTOR CARD
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      // Top row: doctor image + experience/focus block
                      Row(
                        children: [
                          // Doctor image
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(doc.imageAsset),
                          ),
                          const SizedBox(width: 12),
                          // Experience/focus box
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _experienceText,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _focusText,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      // Doctor name, rating, schedule row
                      Text(
                        "${doc.name}, ${doc.title}",
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
                      // rating, reviews, schedule
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // rating
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  size: 16, color: Colors.orange),
                              const SizedBox(width: 4),
                              Text(doc.rating.toString()),
                            ],
                          ),
                          const SizedBox(width: 12),
                          // reviews
                          Row(
                            children: [
                              const Icon(Icons.people_outline, size: 16),
                              const SizedBox(width: 4),
                              Text(doc.reviews.toString()),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Text(_scheduleText,
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),

                      const SizedBox(height: 8),
                      // SCHEDULE + icons row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                            onPressed: () {
                              // TODO: handle schedule
                            },
                            child: const Text("Schedule"),
                          ),
                          const SizedBox(width: 12),
                          // help icon
                          IconButton(
                            icon: const Icon(Icons.help_outline),
                            color: Colors.blue,
                            onPressed: () {
                              // TODO: handle help
                            },
                          ),
                          // favorite icon
                          IconButton(
                            icon: const Icon(Icons.favorite_border),
                            color: Colors.redAccent,
                            onPressed: () {
                              // TODO: handle favorite
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
              // PROFILE / CAREER / HIGHLIGHTS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed "
                      "do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                      "Ut enim ad minim veniam, quis nostrud exercitation "
                      "ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Career Path",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed "
                      "do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                      "Ut enim ad minim veniam, quis nostrud exercitation "
                      "ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Highlights",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed "
                      "do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                      "Ut enim ad minim veniam, quis nostrud exercitation "
                      "ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),

      // BOTTOM NAV BAR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          // TODO: handle navigation
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

  // Helper for top "sort icons" row
  Widget _buildSortIcon(IconData iconData) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.blue.shade50,
        child: IconButton(
          icon: Icon(iconData, color: Colors.blue, size: 16),
          onPressed: () {
            // TODO: handle sorts
          },
        ),
      ),
    );
  }
}
