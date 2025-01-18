// lib/Doctors/favourite_doctor.dart

import 'package:flutter/material.dart';
import 'package:medjoy/route/routes.dart'; // <-- So we can call Routes.favouriteService

class FavouriteDoctorScreen extends StatefulWidget {
  const FavouriteDoctorScreen({Key? key}) : super(key: key);

  @override
  _FavouriteDoctorScreenState createState() => _FavouriteDoctorScreenState();
}

class _FavouriteDoctorScreenState extends State<FavouriteDoctorScreen> {
  // Selected index for the "Sort By" chips
  int _selectedSortIndex = 0;
  final List<String> _sortOptions = ['A-Z', 'Z-A', 'Rating', 'Price'];

  // Toggle between the Doctors tab and the Services tab
  bool _isDoctorTab = true;

  // Sample doctors
  final List<Map<String, dynamic>> _doctors = [
    {
      'image': 'https://via.placeholder.com/150',
      'name': 'Dr. Olivia Turner, M.D.',
      'title': 'Dermato-Endocrinology',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'name': 'Dr. Alexander Bennett, Ph.D.',
      'title': 'Dermato-Genetics',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'name': 'Dr. Sophia Martinez, Ph.D.',
      'title': 'Cosmetic Bioengineering',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'name': 'Dr. Michael Davidson, M.D.',
      'title': 'Solar Dermatology',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ------------------ APP BAR -------------------
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Favorite',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // More actions
            },
          ),
        ],
      ),

      // ------------------ BOTTOM NAV BAR -------------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Bookings',
          ),
        ],
      ),

      // ------------------ BODY -------------------
      body: Column(
        children: [
          // ---------- SORT BY + CHIPS ----------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Text(
                  'Sort By',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(_sortOptions.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(_sortOptions[index]),
                            selected: _selectedSortIndex == index,
                            selectedColor: Colors.blue,
                            labelStyle: TextStyle(
                              color: _selectedSortIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            onSelected: (bool selected) {
                              setState(() {
                                _selectedSortIndex =
                                    selected ? index : _selectedSortIndex;
                              });
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ---------- TOGGLE: DOCTORS / SERVICES ----------
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // Doctors Tab
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isDoctorTab = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _isDoctorTab ? Colors.white : Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Doctors',
                          style: TextStyle(
                            color: _isDoctorTab ? Colors.blue : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Services Tab
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isDoctorTab = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: !_isDoctorTab ? Colors.white : Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Services',
                          style: TextStyle(
                            color: !_isDoctorTab ? Colors.blue : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // ---------- TAB CONTENT ----------
          Expanded(
            child:
                _isDoctorTab ? _buildDoctorList() : _buildServicePlaceholder(),
          ),
        ],
      ),
    );
  }

  // ------------ DOCTOR LIST ------------
  Widget _buildDoctorList() {
    return ListView.builder(
      itemCount: _doctors.length,
      itemBuilder: (context, index) {
        final doc = _doctors[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(doc['image']),
              ),
              const SizedBox(width: 16),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Professional Doctor',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doc['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      doc['title'],
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              // Heart icon & Make Appointment
              IconButton(
                onPressed: () {
                  // Favorite
                },
                icon: const Icon(Icons.favorite),
                color: Colors.red,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Make Appointment
                },
                child: const Text('Make Appointment'),
              ),
            ],
          ),
        );
      },
    );
  }

  // ------------ SERVICES PLACEHOLDER ------------
  Widget _buildServicePlaceholder() {
    // Instead of building the services list here, we just show a button
    // that can push the user to the favourite_service.dart screen.
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Navigate to actual services screen
          Navigator.pushNamed(
            context,
            Routes.favouriteService,
          );
        },
        child: const Text('Go to Services'),
      ),
    );
  }
}

