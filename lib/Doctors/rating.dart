import 'package:flutter/material.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  // Selected index for the "Sort By" chips
  int _selectedSortIndex = 0;

  // Sort options shown as chips
  final List<String> _sortOptions = ['A-Z', 'Z-A', 'Rating', 'Price'];

  // Sample list of doctors
  final List<Map<String, dynamic>> _doctors = [
    {
      'image': 'https://via.placeholder.com/150', // replace with real asset or URL
      'rating': 5.0,
      'name': 'Dr. Olivia Turner, M.D.',
      'title': 'Dermato-Endocrinology',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'rating': 5.0,
      'name': 'Dr. Alexander Bennett, Ph.D.',
      'title': 'Dermato-Genetics',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'rating': 4.9,
      'name': 'Dr. Sophia Martinez, Ph.D.',
      'title': 'Cosmetic Bioengineering',
    },
    {
      'image': 'https://via.placeholder.com/150',
      'rating': 4.8,
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
          'Rating',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            // ---------- SORT BY ROW ----------
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

            // ---------- DOCTOR LIST ----------
            Column(
              children: _doctors.map((doc) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      // Doctor & Rating Row
                      Row(
                        children: [
                          // Doctor Avatar
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(doc['image']),
                          ),
                          const SizedBox(width: 16),
                          // Doctor Info
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
                          // Rating
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  doc['rating'].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Info Button + Icons Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              // Info button action
                            },
                            child: const Text('Info'),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Favorite
                                },
                                icon: const Icon(Icons.favorite_border),
                                color: Colors.red,
                              ),
                              IconButton(
                                onPressed: () {
                                  // Message
                                },
                                icon: const Icon(Icons.message_outlined),
                                color: Colors.blue,
                              ),
                              IconButton(
                                onPressed: () {
                                  // Share
                                },
                                icon: const Icon(Icons.share),
                                color: Colors.blue,
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
