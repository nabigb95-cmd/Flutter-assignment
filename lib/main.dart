// main.dart
// Flutter single-file app for "My Profile App"
// Replace the placeholder name, image asset, and contact details with your own.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Profile App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: WelcomeScreen(onToggleTheme: () => setState(() => _isDark = !_isDark), isDark: _isDark),
      routes: {
        ProfileScreen.routeName: (_) => ProfileScreen(),
        AboutScreen.routeName: (_) => AboutScreen(),
      },
    );
  }
}

// -----------------------------
// SAMPLE USER MODEL + JSON
// -----------------------------
class UserProfile {
  final String name;
  final String profession;
  final String bio;
  final String email;
  final String phone;
  final String location;

  UserProfile({required this.name, required this.profession, required this.bio, required this.email, required this.phone, required this.location});

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    name: json['name'],
    profession: json['profession'],
    bio: json['bio'],
    email: json['email'],
    phone: json['phone'],
    location: json['location'],
  );
}

final sampleJson = {
  "name": "Abdur Rehman",
  "profession": "Flutter Developer",
  "bio": "Enthusiastic Flutter dev building beautiful, responsive UIs. Loves learning and sharing knowledge.",
  "email": "nabi95@gmail.com",
  "phone": "+92 3554422095", 
  "location": "Gilgit, Pakistan" 
  // image: "assets/images/my pic.jpg"
}; 

final sampleUser = UserProfile.fromJson(sampleJson);

// -----------------------------
// Welcome Screen
// -----------------------------
class WelcomeScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;
  WelcomeScreen({required this.onToggleTheme, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.indigo.shade400, Colors.blueAccent.shade200],
              ),
            ),
          ),
          // Centered title
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Welcome to My Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [Shadow(blurRadius: 6, color: Colors.black26, offset: Offset(0, 2))],
                    )),
                SizedBox(height: 12),
                Text('Built with Flutter', style: TextStyle(color: Colors.white70, fontSize: 18)),
              ],
            ),
          ),
          // Theme toggle on top-right
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: IconButton(
                  icon: Icon(isDark ? Icons.wb_sunny : Icons.nights_stay, color: Colors.white),
                  onPressed: onToggleTheme,
                  tooltip: 'Toggle theme',
                ),
              ),
            ),
          ),
          // Bottom button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: media.height * 0.06),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 36, vertical: 14), shape: StadiumBorder()),
                child: Text('View Profile', style: TextStyle(fontSize: 18)),
                onPressed: () => Navigator.pushNamed(context, ProfileScreen.routeName),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------
// Profile Screen
// -----------------------------
class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final user = sampleUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile picture + name
            Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/profile.jpg'),  
                ),
                SizedBox(height: 12),
                Text(user.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text(user.profession, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(user.bio, textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Contact Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Contact', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text(user.email),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(user.phone),
                    ),
                    ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text(user.location),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 18),

            // Social icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.linked_camera), // placeholder; replace with proper social icons or images
                  tooltip: 'LinkedIn',
                  onPressed: () => _showSnack(context, 'Open LinkedIn'),
                ),
                IconButton(
                  icon: Icon(Icons.code),
                  tooltip: 'GitHub',
                  onPressed: () => _showSnack(context, 'Open GitHub'),
                ),
                IconButton(
                  icon: Icon(Icons.chat_bubble),
                  tooltip: 'Twitter',
                  onPressed: () => _showSnack(context, 'Open Twitter'),
                ),
              ],
            ),

            SizedBox(height: 30),

            // A card showing a short info or actions
            Card(
              child: ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('More about me'),
                subtitle: Text('Tap the FAB to open About Me page'),
              ),
            ),

            SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person),
        onPressed: () => Navigator.pushNamed(context, AboutScreen.routeName),
        tooltip: 'About Me',
      ),
    );
  }

  void _showSnack(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

// -----------------------------
// About Screen
// -----------------------------
class AboutScreen extends StatelessWidget {
  static const routeName = '/about';

  @override
  Widget build(BuildContext context) {
    final skills = ['Dart', 'Flutter', 'UI Design', 'Git', 'REST APIs', 'Firebase'];
    final hobbies = ['Reading', 'Gaming', 'Traveling', 'Photography'];

    return Scaffold(
      appBar: AppBar(
        title: Text('About Me'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text('Education', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,                                   
                children: [
                  Text('Bachelor of Science in Computer Science', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text('University KIU — 2023-2027')
                ],
              ),
            ),
          ),

          SizedBox(height: 12),
          Text('Skills', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 6,
                children: skills.map((s) => Chip(label: Text(s))).toList(),
              ),
            ),
          ),

          SizedBox(height: 12),
          Text('Hobbies', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: hobbies.map((h) => Padding(padding: EdgeInsets.symmetric(vertical: 6), child: Text('• $h'))).toList(),
              ),
            ),
          ),

          SizedBox(height: 20),
          Center(
            child: ElevatedButton.icon(
              icon: Icon(Icons.arrow_back_ios),
              label: Text('Back to Profile'),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}

/*
INSTRUCTIONS & ASSETS

1) Add an image at: /assets/profile.jpg and list the assets in pubspec.yaml:

flutter:
  assets:
    - assets/profile.jpg

2) If you want to use a custom font, add it and update pubspec.yaml accordingly.

3) To run:
   - flutter create my_profile_app
   - Replace lib/main.dart with this file
   - Add the asset and pubspec entries
   - flutter pub get
   - flutter run
s
4) Optional extras (bonus):
   - Replace IconButton placeholders with FontAwesome icons (add font_awesome_flutter package)
   - Persist sampleJson to a local file or load from assets/user.json
*/
