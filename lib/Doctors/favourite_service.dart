import 'package:flutter/material.dart';

class FavouriteServiceScreen extends StatefulWidget {
  const FavouriteServiceScreen({Key? key}) : super(key: key);

  @override
  _FavouriteServiceScreenState createState() => _FavouriteServiceScreenState();
}

class _FavouriteServiceScreenState extends State<FavouriteServiceScreen> {
  // Selected index for the "Sort By" chips
  int _selectedSortIndex = 0;
  final List<String> _sortOptions = ['A-Z', 'Z-A', 'Rating', 'Price'];

  // Sample services, each with expanded flag
  final List<Map<String, dynamic>> _services = [
    {
      'name': 'Dermato-Endocrinology',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque congue lorem...',
      'isExpanded': false,
    },
    {
      'name': 'Cosmetic Bioengineering',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin id lorem finibus...',
      'isExpanded': false,
    },
    {
      'name': 'Dermato-Genetics',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sit amet fermentum...',
      'isExpanded': false,
    },
    {
      'name': 'Solar Dermatology',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sagittis dolor...',
      'isExpanded': false,
    },
    {
      'name': 'Dermato-Endocrinology',
      'description':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam erat volutpat...',
      'isExpanded': false,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            // ---------- SORT BY + CHIPS ----------
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

            const SizedBox(height: 8),

            // ---------- DOCTORS / SERVICES TOGGLE ----------
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  // Doctors tab
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Typically would navigate back to favourite_doctor.dart
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'Doctors',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Services tab (active)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'Services',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // ---------- EXPANSION LIST ----------
            Expanded(
              child: ListView.builder(
                itemCount: _services.length,
                itemBuilder: (context, index) {
                  return _buildServiceTile(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Renders each collapsible "service" item
  Widget _buildServiceTile(int index) {
    final service = _services[index];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        leading: const Icon(Icons.favorite, color: Colors.red),
        title: Text(
          service['name'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        initiallyExpanded: service['isExpanded'],
        onExpansionChanged: (bool expanded) {
          setState(() {
            _services[index]['isExpanded'] = expanded;
          });
        },
        children: [
          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(service['description']),
          ),
          // “looking doctors” text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'looking doctors',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
