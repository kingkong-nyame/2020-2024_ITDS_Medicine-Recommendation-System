import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  final List<Map<String, String>> teamMembers = [
    {
      'name': 'Nti Gyimah Emmanuel',
      'role': 'Final Year Information Technology Student',
      'institution': 'University of Energy and Natural Resources',
      'image': 'assets/images/emmanuel.jpg',
    },
    {
      'name': 'Anane Busia Lawrence',
      'role': 'Final Year Information Technology Student',
      'institution': 'University of Energy and Natural Resources',
      'image': 'assets/images/busia.jpg',
    },
    {
      'name': 'Agyei Samuel',
      'role': 'Final Year Information Technology Student',
      'institution': 'University of Energy and Natural Resources',
      'image': 'assets/images/samuel.jpg',
    },
    {
      'name': 'Prudence Akosua Adjaklo',
      'role': 'Final Year Information Technology Student',
      'institution': 'University of Energy and Natural Resources',
      'image': 'assets/images/Prudence.jpg',
    },
    {
      'name': 'Gyabaah Abraham',
      'role': 'Final Year Information Technology Student',
      'institution': 'University of Energy and Natural Resources',
      'image': 'assets/images/Remix.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
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
          // Content
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 16.0),
                _buildCard(
                  title: 'Disease Prediction App',
                  content:
                  Text('This app helps users predict potential diseases based on their symptoms. It leverages a machine learning model trained on a dataset of symptoms and diseases to provide accurate predictions.'),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Features:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                _buildCard(
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FeatureItem(text: 'Predict diseases based on symptoms'),
                      FeatureItem(text: 'Get detailed descriptions of diseases'),
                      FeatureItem(text: 'Receive precautions, medications, diet, and workout recommendations'),
                      FeatureItem(text: 'Easy-to-use interface'),
                      FeatureItem(text: 'Secure and confidential user data handling'),
                      FeatureItem(text: 'Regular updates with new features and improvements'),
                      FeatureItem(text: 'User-friendly design with responsive UI'),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Developed By:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Column(
                  children: teamMembers.map((member) {
                    return Card(
                      elevation: 4.0,
                      shadowColor: Colors.grey.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage(member['image']!),
                              onBackgroundImageError: (_, __) =>
                                  AssetImage('assets/images/placeholder.jpg'),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    member['name']!,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    member['role']!,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    member['institution']!,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({String? title, required Widget content}) {
    return Card(
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
            if (title != null)
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (title != null) SizedBox(height: 8.0),
            content,
          ],
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String text;

  FeatureItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        '• $text',
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}
