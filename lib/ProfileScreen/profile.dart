import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // For the bottom nav bar
  int _selectedIndex = 2; // e.g. 'Profile' tab is index 2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // -------------- APP BAR --------------
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      // -------------- BOTTOM NAV --------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          // TODO: handle actual nav if needed
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
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

      // -------------- BODY --------------
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          children: [
            // ---------- PROFILE HEADER ----------
            const SizedBox(height: 16),
            // Circle avatar + name
            Center(
              child: Column(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/passport_photo.png'),
                    // or NetworkImage('https://via.placeholder.com/150') etc.
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ---------- PROFILE MENU ----------
            Expanded(
              child: ListView(
                children: [
                  // Profile
                  _buildProfileItem(
                    icon: Icons.person,
                    text: 'Profile',
                    onTap: () {
                      // TODO: Navigate to Edit Profile or similar
                    },
                  ),
                  // Favorite
                  _buildProfileItem(
                    icon: Icons.favorite,
                    text: 'Favorite',
                    onTap: () {
                      // TODO: navigate to Favorites
                    },
                  ),
                  // Payment Method
                  _buildProfileItem(
                    icon: Icons.payment,
                    text: 'Payment Method',
                    onTap: () {
                      // TODO: navigate to Payment Method
                    },
                  ),
                  // Privacy Policy
                  _buildProfileItem(
                    icon: Icons.lock,
                    text: 'Privacy Policy',
                    onTap: () {
                      // TODO: navigate to Privacy Policy
                    },
                  ),
                  // Settings
                  _buildProfileItem(
                    icon: Icons.settings,
                    text: 'Settings',
                    onTap: () {
                      // TODO: navigate to Settings
                    },
                  ),
                  // Help
                  _buildProfileItem(
                    icon: Icons.help_outline,
                    text: 'Help',
                    onTap: () {
                      // TODO: navigate to Help screen
                    },
                  ),
                  // Logout
                  _buildProfileItem(
                    icon: Icons.logout,
                    text: 'Logout',
                    onTap: () {
                      // TODO: handle logout
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build each profile menu row
  Widget _buildProfileItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(text),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
