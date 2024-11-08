import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Us',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 16.0),
                Card(
                  elevation: 4.0,
                  shadowColor: Colors.grey.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'We Are Always Ready To Help',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'This app helps users predict potential diseases based on their symptoms.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'It leverages a machine learning model trained on a dataset of symptoms and diseases to provide accurate predictions.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(Icons.phone, color: Colors.blueAccent),
                            SizedBox(width: 8.0),
                            Text(
                              '0596848548',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(Icons.email, color: Colors.blueAccent),
                            SizedBox(width: 8.0),
                            Text(
                              'medicine34@gmail.com',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Get in Touch',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                _buildTextField(label: 'Your Name', icon: Icons.person),
                SizedBox(height: 16.0),
                _buildTextField(label: 'Your Email', icon: Icons.email),
                SizedBox(height: 16.0),
                _buildTextField(
                  label: 'Your Message',
                  icon: Icons.message,
                  maxLines: 5,
                ),
                SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle message sending logic
                    },
                    child: Text('Send Message'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 12.0,
                      ),
                      textStyle: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
      ),
    );
  }
}
