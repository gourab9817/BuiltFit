// lib/Home/Home.dart
import 'package:flutter/material.dart';
import 'package:medjoy/route/routes.dart'; // so we can call Routes.doctors etc.

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String userName = "John Doe";
  final String greetingText = "Hi, WelcomeBack";
  int _selectedIndex = 0; // For bottom nav bar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ---------- TOP USER + ICONS ----------
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              color: const Color(0xFFF3F7FE),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: const AssetImage('assets/logo.png'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          greetingText,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_none),
                    color: Colors.black54,
                    onPressed: () {
                      debugPrint("Notifications tapped");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings_outlined),
                    color: Colors.black54,
                    onPressed: () {
                      debugPrint("Settings tapped");
                    },
                  ),
                ],
              ),
            ),

            // ---------- DOCTORS / FAVORITE + SEARCH ----------
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to the Doctors screen
                      Navigator.pushNamed(context, Routes.doctors);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.person_outline, color: Colors.blueAccent),
                        SizedBox(width: 5),
                        Text(
                          "Doctors",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  GestureDetector(
                    onTap: () {
                      debugPrint("Favorite tapped");
                      // You could navigate to a favorite screen if needed
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.favorite_border, color: Colors.redAccent),
                        SizedBox(width: 5),
                        Text(
                          "Favorite",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.search),
                    color: Colors.black54,
                    onPressed: () {
                      debugPrint("Search tapped");
                    },
                  ),
                ],
              ),
            ),

            // ---------- HORIZONTAL LIST OF DAYS ----------
            SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  _buildDayItem("9", "MON", false),
                  _buildDayItem("10", "TUE", false),
                  _buildDayItem("11", "WED", true),
                  _buildDayItem("12", "THU", false),
                  _buildDayItem("13", "FRI", false),
                  _buildDayItem("14", "SAT", false),
                ],
              ),
            ),

            // ---------- SCHEDULE CARD ----------
            _buildScheduleCard(),

            // ---------- LIST OF DOCTORS ----------
            Expanded(
              child: ListView(
                children: [
                  _buildDoctorListItem(
                    image: 'assets/logo.png',
                    name: 'Dr. Olivia Turner, M.D.',
                    specialty: 'Dermato-Endocrinology',
                    rating: 5.0,
                    reviews: 60,
                  ),
                  _buildDoctorListItem(
                    image: 'assets/logo.png',
                    name: 'Dr. Alexander Bennett, Ph.D.',
                    specialty: 'Dermato-Genetics',
                    rating: 4.5,
                    reviews: 40,
                  ),
                  _buildDoctorListItem(
                    image: 'assets/logo.png',
                    name: 'Dr. Sophia Martinez, Ph.D.',
                    specialty: 'Cosmetic Bioengineering',
                    rating: 4.3,
                    reviews: 90,
                  ),
                  _buildDoctorListItem(
                    image: 'assets/logo.png',
                    name: 'Dr. Michael Davidson, M.D.',
                    specialty: 'Nano-Dermatology',
                    rating: 4.8,
                    reviews: 90,
                  ),
                ],
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
          // When the user taps "Profile" (the 4th item, index=3):
          if (index == 3) {
            Navigator.pushNamed(context, Routes.profile);
          }
        },
        selectedItemColor: Colors.blueAccent,
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

  // -------------- BUILD DAY ITEM --------------
  Widget _buildDayItem(String dayNum, String dayText, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 50,
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF4F73F9) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: selected ? Colors.transparent : Colors.grey.shade300,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dayNum,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            dayText,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // -------------- SCHEDULE CARD --------------
  Widget _buildScheduleCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EEFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            "11 Wednesday - Today",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              SizedBox(width: 35, child: Text("9 AM")),
              Expanded(child: Divider(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 35, child: Text("10 AM")),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Dr. Olivia Turner, M.D.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Treatment and prevention of skin and photodermatitis.",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              SizedBox(width: 35, child: Text("11 AM")),
              Expanded(child: Divider(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              SizedBox(width: 35, child: Text("12 AM")),
              Expanded(child: Divider(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  // -------------- DOCTOR LIST ITEM --------------
  Widget _buildDoctorListItem({
    required String image,
    required String name,
    required String specialty,
    required double rating,
    required int reviews,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage(image),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  specialty,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star,
                        size: 16, color: Colors.orangeAccent),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "$reviews",
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.help_outline),
            color: Colors.blueAccent,
            onPressed: () {
              debugPrint("Help tapped for $name");
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            color: Colors.redAccent,
            onPressed: () {
              debugPrint("Favorite tapped for $name");
            },
          ),
        ],
      ),
    );
  }
}
