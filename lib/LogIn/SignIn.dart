// lib/LogIn/SignIn.dart

import 'package:flutter/material.dart';
import 'package:medjoy/Auth/auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // For Sign In
  final TextEditingController _signInEmailController = TextEditingController();
  final TextEditingController _signInPasswordController = TextEditingController();
  bool _signInObscureText = true;

  // For Sign Up
  final TextEditingController _signUpEmailController = TextEditingController();
  final TextEditingController _signUpPasswordController = TextEditingController();
  final TextEditingController _signUpConfirmPasswordController =
      TextEditingController();
  bool _signUpObscureText = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _signInEmailController.dispose();
    _signInPasswordController.dispose();
    _signUpEmailController.dispose();
    _signUpPasswordController.dispose();
    _signUpConfirmPasswordController.dispose();
    super.dispose();
  }

  // Sign in functionality
  Future<void> _handleSignIn() async {
    final email = _signInEmailController.text.trim();
    final password = _signInPasswordController.text.trim();

    if (email.isEmpty) {
      print('Please enter an email');
      return;
    }
    if (password.isEmpty) {
      print('Please enter a password');
      return;
    }

    try {
      await AuthService.signIn(email: email, password: password);
      print('Signed in with email: $email');

      // Navigate to Home screen
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print('Sign in failed: $e');
      // Optionally show a dialog/snackbar
    }
  }

  // Sign up functionality
  Future<void> _handleSignUp() async {
    final email = _signUpEmailController.text.trim();
    final password = _signUpPasswordController.text.trim();
    final confirmPassword = _signUpConfirmPasswordController.text.trim();

    if (email.isEmpty) {
      print('Please enter an email');
      return;
    }
    if (password.isEmpty) {
      print('Please enter a password');
      return;
    }
    if (password != confirmPassword) {
      print('Passwords do not match!');
      return;
    }

    try {
      // Create account
      await AuthService.signUp(email: email, password: password);
      print('Signed up with email: $email');

      // Optional: sign in automatically
      await AuthService.signIn(email: email, password: password);

      // Navigate to Home screen
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print('Sign up failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We use a Stack so we can place the gradient background and the card on top
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF3F7CFF), // Top color (blue-ish)
                  Color(0xFFFF9966), // Bottom color (orange-ish)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // The main content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // App title at the top
                  const Center(
                    child: Text(
                      'MedJoy',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // White card with tabs
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            // Tab Bar (Sign In / Sign Up)
                            TabBar(
                              controller: _tabController,
                              indicatorColor: Colors.blue,
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey,
                              labelStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              tabs: const [
                                Tab(text: 'Sign In'),
                                Tab(text: 'Sign Up'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Tab Bar View
                            SizedBox(
                              height: 500, // Adjust as needed
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  // Sign In Tab
                                  _buildSignInTab(),
                                  // Sign Up Tab
                                  _buildSignUpTab(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Sign In Tab UI
  Widget _buildSignInTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            "Let's get started by filling out the form below.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          // Email field
          TextField(
            controller: _signInEmailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          // Password field
          TextField(
            controller: _signInPasswordController,
            obscureText: _signInObscureText,
            decoration: InputDecoration(
              labelText: 'Password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _signInObscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _signInObscureText = !_signInObscureText;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Sign In button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB), // Blue
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _handleSignIn,
              child: const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Forgot password
          GestureDetector(
            onTap: () {
              // TODO: Handle forgot password action
              print('Forgot Password Tapped');
            },
            child: const Text(
              'Forgot Password',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Or sign up with
          const Text(
            'Or sign up with',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),

          // The updated row (no overflow!)
          Row(
            children: [
              Expanded(
                child: _buildSocialButton(
                  icon: Icons.g_mobiledata,
                  text: 'Continue with Google',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSocialButton(
                  icon: Icons.apple,
                  text: 'Continue with Apple',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Sign Up Tab UI
  Widget _buildSignUpTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            "Create your account",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          // Email field
          TextField(
            controller: _signUpEmailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          // Password field
          TextField(
            controller: _signUpPasswordController,
            obscureText: _signUpObscureText,
            decoration: InputDecoration(
              labelText: 'Password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _signUpObscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _signUpObscureText = !_signUpObscureText;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Confirm password
          TextField(
            controller: _signUpConfirmPasswordController,
            obscureText: _signUpObscureText,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _signUpObscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _signUpObscureText = !_signUpObscureText;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Sign Up button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB), // Blue
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _handleSignUp,
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Or sign up with
          const Text(
            'Or sign up with',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),

          // The updated row (no overflow!)
          Row(
            children: [
              Expanded(
                child: _buildSocialButton(
                  icon: Icons.g_mobiledata,
                  text: 'Continue with Google',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSocialButton(
                  icon: Icons.apple,
                  text: 'Continue with Apple',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Social button widget
  Widget _buildSocialButton({required IconData icon, required String text}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
      ),
      icon: Icon(icon),
      onPressed: () {
        // TODO: Handle social sign-in
        print('$text pressed');
      },
      label: Text(text),
    );
  }
}
