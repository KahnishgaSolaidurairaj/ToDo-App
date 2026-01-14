import 'package:flutter/material.dart';
import '../pages/general.dart';
import '../pages/academic.dart';
import '../pages/water.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do"),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(text: "General"),
            Tab(text: "Academic"),
            Tab(text: "Water"),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          General(),
          Academic(),
          Water(),
        ],
      ),
    );
  }
}
