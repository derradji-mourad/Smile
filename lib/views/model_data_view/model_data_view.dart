import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class DiagnosisFormScreen extends StatefulWidget {
  @override
  _DiagnosisFormScreenState createState() => _DiagnosisFormScreenState();
}

class _DiagnosisFormScreenState extends State<DiagnosisFormScreen> {
  String douleur = 'legere';
  String gonflement = 'non';
  String rougeur = 'non';
  String pus = 'non';
  String fivre = 'non';
  String ganglions = 'non';
  String sensibilite = 'positive';

  String? predictionResult;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predict Diagnosis'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: douleur,
              onChanged: (newValue) {
                setState(() {
                  douleur = newValue!;
                });
              },
              items: ['legere', 'moderee', 'intense'].map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Douleur'),
            ),
            DropdownButtonFormField<String>(
              value: gonflement,
              onChanged: (newValue) {
                setState(() {
                  gonflement = newValue!;
                });
              },
              items: ['oui', 'non'].map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Gonflement'),
            ),
            DropdownButtonFormField<String>(
              value: rougeur,
              onChanged: (newValue) {
                setState(() {
                  rougeur = newValue!;
                });
              },
              items: ['oui', 'non'].map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Rougeur'),
            ),
            DropdownButtonFormField<String>(
              value: pus,
              onChanged: (newValue) {
                setState(() {
                  pus = newValue!;
                });
              },
              items: ['oui', 'non'].map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Pus'),
            ),
            DropdownButtonFormField<String>(
              value: fivre,
              onChanged: (newValue) {
                setState(() {
                  fivre = newValue!;
                });
              },
              items: ['oui', 'non'].map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Fivre'),
            ),
            DropdownButtonFormField<String>(
              value: ganglions,
              onChanged: (newValue) {
                setState(() {
                  ganglions = newValue!;
                });
              },
              items: ['oui', 'non'].map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Ganglions'),
            ),
            DropdownButtonFormField<String>(
              value: sensibilite,
              onChanged: (newValue) {
                setState(() {
                  sensibilite = newValue!;
                });
              },
              items: ['positive', 'negative'].map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Sensibilite'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Map<String, String> inputData = {
                  'douleur': douleur == 'legere'
                      ? '0'
                      : douleur == 'moderee'
                          ? '1'
                          : '2',
                  'gonflement': gonflement == 'oui' ? '1' : '0',
                  'rougeur': rougeur == 'oui' ? '1' : '0',
                  'pus': pus == 'oui' ? '1' : '0',
                  'fivre': fivre == 'oui' ? '1' : '0',
                  'ganglions': ganglions == 'oui' ? '1' : '0',
                  'sensibilite': sensibilite == 'positive' ? '1' : '0',
                };

                predictDiagnosis(inputData);
              },
              child: Text('Predict'),
            ),
            SizedBox(height: 20),
            if (isLoading) CircularProgressIndicator(),
            if (predictionResult != null)
              Text(
                'Diagnosis: $predictionResult',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }

  void predictDiagnosis(Map<String, String> inputData) async {
    setState(() {
      isLoading = true;
      predictionResult = null;
    });

    final url =
        Uri.parse('https://diagnonsis-prediction-api.onrender.com/predict');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(inputData),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        setState(() {
          predictionResult = result['prediction'];
        });
        Fluttertoast.showToast(
          msg: "Diagnosis: ${result['prediction']}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        setState(() {
          predictionResult = 'Error: ${response.reasonPhrase}';
        });
        Fluttertoast.showToast(
          msg: "Error: ${response.reasonPhrase}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      setState(() {
        predictionResult = 'Error: $e';
      });
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
