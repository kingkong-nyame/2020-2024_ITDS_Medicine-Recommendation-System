import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:medicine_recommendation/screen/about_screen.dart';
import 'package:medicine_recommendation/screen/contact_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _symptomsController = TextEditingController();
  String _predictedDisease = '';
  String _description = '';
  String _precautions = '';
  List<dynamic> _medications = [];
  List<dynamic> _diet = [];
  List<dynamic> _workout = [];
  bool _isLoading = false;
  String _errorMessage = '';
  List<Map<String, String>> _history = [];

  Future<void> _predictDisease() async {
    String symptoms = _symptomsController.text.trim();
    if (symptoms.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter symptoms';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final url = 'https://832b-156-0-140-46.ngrok-free.app/predict'; // Replace with your ngrok URL
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'symptoms': symptoms});

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _predictedDisease = data['predicted_disease'];
          _description = data['description'];
          _precautions = data['precautions'];
          _medications = data['medications'];
          _diet = data['diet'];
          _workout = data['workout'];
          _history.add({
            'symptoms': symptoms,
            'predictedDisease': _predictedDisease,
          });
          _symptomsController.clear();
        });
        _showSuccessDialog();
      } else {
        throw Exception('Failed to predict disease');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error predicting disease. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Success'),
        content: Text('Disease prediction completed successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _clearSymptoms() {
    setState(() {
      _symptomsController.clear();
      _predictedDisease = '';
      _description = '';
      _precautions = '';
      _medications = [];
      _diet = [];
      _workout = [];
      _errorMessage = '';
    });
  }

  void _navigateToAboutScreen() {
    Navigator.of(context).pushNamed('/about'); // Navigate to '/about' route
  }

  void _navigateToContactScreen() {
    Navigator.of(context).pushNamed('/contact'); // Navigate to '/contact' route
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disease Prediction'),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          TextButton(
            onPressed: _navigateToAboutScreen,
            child: Text(
              'About',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: _navigateToContactScreen,
            child: Text(
              'Contact',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _symptomsController,
                  decoration: InputDecoration(
                    labelText: 'Enter Symptoms (comma separated)',
                    border: OutlineInputBorder(),
                    fillColor: Colors.white.withOpacity(0.9),
                    filled: true,
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: _predictDisease,
                      child: Text('Predict Disease'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        textStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _clearSymptoms,
                      child: Text('Clear'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        textStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                if (_isLoading)
                  Center(child: CircularProgressIndicator()),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                if (_predictedDisease.isNotEmpty)
                  _buildPredictionResult(),
                if (_history.isNotEmpty)
                  _buildHistory(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPredictionResult() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSectionTitle('Predicted Disease:'),
          _buildSectionContent(_predictedDisease),
          _buildSectionTitle('Description:'),
          _buildSectionContent(_description),
          _buildSectionTitle('Precautions:'),
          _buildSectionContent(_precautions),
          _buildSectionTitle('Medications:'),
          _buildSectionContent(_medications.join(", ")),
          _buildSectionTitle('Recommended Diet:'),
          _buildSectionContent(_diet.join(", ")),
          _buildSectionTitle('Workout Recommendations:'),
          _buildSectionContent(_workout.join(", ")),
        ],
      ),
    );
  }

  Widget _buildHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20.0),
        _buildSectionTitle('Prediction History:'),
        ..._history.map((entry) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text('Symptoms: ${entry['symptoms']}, Predicted Disease: ${entry['predictedDisease']}'),
        )),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.blueAccent),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}
