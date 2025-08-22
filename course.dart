import 'package:flutter/material.dart';

void main() {
  runApp(CourseDashboardApp());
}

class CourseDashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CourseDashboard(),
    );
  }
}

class CourseDashboard extends StatefulWidget {
  @override
  _CourseDashboardState createState() => _CourseDashboardState();
}

class _CourseDashboardState extends State<CourseDashboard> {
  int _selectedIndex = 0;
  final List<String> _tabNames = ['Home', 'Courses', 'Profile'];
  bool _isButtonExpanded = false;
  String _selectedCategory = 'Science';
  final List<String> _categories = ['Science', 'Arts', 'Technology', 'Business', 'Health'];

  final List<Map<String, dynamic>> _courses = [
    {
      'name': 'Mobile App Development',
      'instructor': 'Dr. Smith',
      'icon': Icons.phone_iphone,
    },
    {
      'name': 'Web Programming',
      'instructor': 'Prof. Johnson',
      'icon': Icons.web,
    },
    {
      'name': 'Data Structures',
      'instructor': 'Dr. Williams',
      'icon': Icons.data_usage,
    },
    {
      'name': 'Database Systems',
      'instructor': 'Prof. Brown',
      'icon': Icons.storage,
    },
    {
      'name': 'UI/UX Design',
      'instructor': 'Dr. Davis',
      'icon': Icons.design_services,
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Exit'),
          content: Text('Are you sure you want to exit the app?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // In a real app, you might want to close the app
                // SystemNavigator.pop();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _toggleButtonSize() {
    setState(() {
      _isButtonExpanded = !_isButtonExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _showExitDialog,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Active Tab: ${_tabNames[_selectedIndex]}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            
            if (_selectedIndex == 1) // Courses tab
              Expanded(
                child: ListView.builder(
                  itemCount: _courses.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(_courses[index]['icon']),
                      title: Text(_courses[index]['name']),
                      subtitle: Text('Instructor: ${_courses[index]['instructor']}'),
                    );
                  },
                ),
              ),
            
            if (_selectedIndex == 0) // Home tab
              Column(
                children: [
                  // Course Selection Dropdown
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      items: _categories.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Course Category',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Text(
                    'Selected Category: $_selectedCategory',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  
                  // Animated Action Button
                  GestureDetector(
                    onTap: _toggleButtonSize,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: _isButtonExpanded ? 200 : 150,
                      height: _isButtonExpanded ? 200 : 150,
                      child: ElevatedButton(
                        onPressed: _toggleButtonSize,
                        child: Text(
                          'Enroll in Course',
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            
            if (_selectedIndex == 2) // Profile tab
              Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://example.com/profile.jpg'), // Replace with actual URL
                  ),
                  SizedBox(height: 20),
                  Text('Student Name: John Doe'),
                  Text('Email: john.doe@university.edu'),
                  Text('Major: Computer Science'),
                ],
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
    );
  }
}