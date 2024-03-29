import 'package:flutter/material.dart';

class ProficiencyCalculator extends StatefulWidget {
  @override
  _ProficiencyCalculatorState createState() => _ProficiencyCalculatorState();
}

class _ProficiencyCalculatorState extends State<ProficiencyCalculator> {
  int topicScore = 0;
  int previousProficiency = 0;
  int topicImportance = 0;
  int topicDifficulty = 0;
  int proficiency = 0;

  void calculateProficiency() {
    setState(() {
      // Calculate proficiency based on input parameters
      // Use floating-point division to get accurate results
      double proficiencyDouble =
          (topicScore * topicImportance - previousProficiency) /
              topicDifficulty;
      proficiency = (proficiencyDouble.round()).clamp(1, 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proficiency Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Topic Score: $topicScore'),
            Slider(
              value: topicScore.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (value) {
                setState(() {
                  topicScore = value.round();
                });
              },
            ),
            Text('Previous Proficiency: $previousProficiency'),
            Slider(
              value: previousProficiency.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (value) {
                setState(() {
                  previousProficiency = value.round();
                });
              },
            ),
            Text('Topic Importance: $topicImportance'),
            Slider(
              value: topicImportance.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (value) {
                setState(() {
                  topicImportance = value.round();
                });
              },
            ),
            Text('Topic Difficulty: $topicDifficulty'),
            Slider(
              value: topicDifficulty.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (value) {
                setState(() {
                  topicDifficulty = value.round();
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateProficiency,
              child: Text('Calculate Proficiency'),
            ),
            SizedBox(height: 20),
            Text('Proficiency: $proficiency'),
          ],
        ),
      ),
    );
  }
}
