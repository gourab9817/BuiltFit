// lib/Doctors/favourite_female_doctor.dart

import 'package:flutter/material.dart';

class FavouriteFemaleDoctorScreen extends StatefulWidget {
  const FavouriteFemaleDoctorScreen({Key? key}) : super(key: key);

  @override
  _FavouriteFemaleDoctorScreenState createState() =>
      _FavouriteFemaleDoctorScreenState();
}

class _FavouriteFemaleDoctorScreenState
    extends State<FavouriteFemaleDoctorScreen> {
  // Sort chip index
  int _selectedSortIndex = 0;
  final List<String> _sortOptions = ['A-Z', 'Z-A', 'Filter', 'Star', '♂', '♀'];

  // Sample female doctors
  final List<Map<String, String>> _femaleDoctors = [
    {
      'image': 'https://via.placeholder.com/150',
      'name': 'Dr. Olivia Turner, M.D.',
      'specialty': 'Dermato-Endocrinology',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'name': 'Dr. Sophia Martinez, Ph.D.',
      'specialty': 'Cosmetic Bioengineering',
    },
    // Repeat if you'd like more items in the list
    {
      'image': 'https://via.placeholder.com/150',
      'name': 'Dr. Olivia Turner, M.D.',
      'specialty': 'Dermato-Endocrinology',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'name': 'Dr. Sophia Martinez, Ph.D.',
      'specialty': 'Cosmetic Bioengineering',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ---------- APP BAR ----------
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Female',
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
              // handle search
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // handle more
            },
          ),
        ],
      ),

      // ---------- BOTTOM NAV ----------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
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

      // ---------- BODY ----------
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            // Sort row
            Row(
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
                          padding: const EdgeInsets.only(right: 8.0),
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

            const SizedBox(height: 16),

            // FEMALE DOCTOR CARDS
            Column(
              children: _femaleDoctors.map((doc) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      // Row with avatar + info
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(doc['image']!),
                          ),
                          const SizedBox(width: 16),
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
                                  doc['name']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  doc['specialty']!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Info button + icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              // Info
                            },
                            child: const Text('Info'),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.star_border),
                                color: Colors.orange,
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.message_outlined),
                                color: Colors.blue,
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.favorite_border),
                                color: Colors.redAccent,
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.share),
                                color: Colors.blue,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
