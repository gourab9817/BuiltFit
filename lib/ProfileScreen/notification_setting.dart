import 'package:flutter/material.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({Key? key}) : super(key: key);

  @override
  _NotificationSettingScreenState createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  // Example toggles
  bool _generalNotification = true;
  bool _sound = true;
  bool _soundCall = true;
  bool _vibrate = false;
  bool _specialOffers = false;
  bool _payments = true;
  bool _promoDiscount = false;
  bool _cashback = true;

  // For the bottom nav
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ---------------- APP BAR ----------------
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Notification Setting',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      // ---------------- BOTTOM NAV ----------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          // TODO: handle actual navigation if needed
        },
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

      // ---------------- BODY ----------------
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSwitchItem(
              title: 'General Notification',
              value: _generalNotification,
              onChanged: (val) {
                setState(() => _generalNotification = val);
              },
            ),
            _buildSwitchItem(
              title: 'Sound',
              value: _sound,
              onChanged: (val) {
                setState(() => _sound = val);
              },
            ),
            _buildSwitchItem(
              title: 'Sound Call',
              value: _soundCall,
              onChanged: (val) {
                setState(() => _soundCall = val);
              },
            ),
            _buildSwitchItem(
              title: 'Vibrate',
              value: _vibrate,
              onChanged: (val) {
                setState(() => _vibrate = val);
              },
            ),
            _buildSwitchItem(
              title: 'Special Offers',
              value: _specialOffers,
              onChanged: (val) {
                setState(() => _specialOffers = val);
              },
            ),
            _buildSwitchItem(
              title: 'Payments',
              value: _payments,
              onChanged: (val) {
                setState(() => _payments = val);
              },
            ),
            _buildSwitchItem(
              title: 'Promo And Discount',
              value: _promoDiscount,
              onChanged: (val) {
                setState(() => _promoDiscount = val);
              },
            ),
            _buildSwitchItem(
              title: 'Cashback',
              value: _cashback,
              onChanged: (val) {
                setState(() => _cashback = val);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper for each row item with the text and switch
  Widget _buildSwitchItem({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(title),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blue,
        ),
      ),
    );
  }
}
