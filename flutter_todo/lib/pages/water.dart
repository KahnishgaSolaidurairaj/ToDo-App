import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Water extends StatefulWidget {
  const Water({super.key});

  @override
  State<Water> createState() => _WaterState();
}

class _WaterState extends State<Water> {
  late Box waterBox;
  int waterGoal = 8;

  @override
  void initState() {
    super.initState();
    openWaterBox();
  }

  Future<void> openWaterBox() async {
    waterBox = await Hive.openBox('waterBox');
    resetIfNewDay();
    setState(() {}); 
  }

  void resetIfNewDay() {
    DateTime today = DateTime.now();
    String todayStr = "${today.year}-${today.month}-${today.day}";

    String? lastDay = waterBox.get('lastDay');

    if (lastDay != todayStr) {
      waterBox.put('water', 0);
      waterBox.put('lastDay', todayStr);
    }
  }

  void addWater() {
    int current = waterBox.get('water', defaultValue: 0);

    current++;
    waterBox.put('water', current);

    setState(() {});

    if (current == waterGoal) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("You reached today's goal — but keep drinking water!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!Hive.isBoxOpen('waterBox')) {
      return const Center(child: CircularProgressIndicator());
    }

    int current = waterBox.get('water', defaultValue: 0);
    double progress = (current / waterGoal).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: Colors.teal.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$current / $waterGoal cups",
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 30),
  
            Icon(
              Icons.water_drop,
              size: 100,
              color: Colors.blue.withOpacity(0.3 + 0.7 * progress),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: addWater,
              child: const Text("Add Water"),
            ),
          ],
        ),
      ),
    );
  }
}