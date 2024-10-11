import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/model/user_model.dart';
import '../provider/user_provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitoring Robot Virtual'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari robot...',
                fillColor: Colors.white,
                filled: true,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
        ),
      ),
      body: Consumer<RobotProvider>(
        builder: (context, robotProvider, child) {
          if (robotProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (robotProvider.error != null) {
            return Center(child: Text('Error: ${robotProvider.error}'));
          }

          List<Robot> filteredRobots = robotProvider.robots.where((robot) {
            return robot.namabot.toLowerCase().contains(_searchQuery) ||
                   robot.tipe.toLowerCase().contains(_searchQuery);
          }).toList();

          if (filteredRobots.isEmpty) {
            return const Center(child: Text('Tidak ada data robot.'));
          }

          return RefreshIndicator(
            onRefresh: robotProvider.fetchRobots,
            child: ListView.builder(
              itemCount: filteredRobots.length,
              itemBuilder: (context, index) {
                Robot robot = filteredRobots[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: const Icon(Icons.room, color: Colors.blue),
                    title: Text(robot.namabot),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tipe: ${robot.tipe}'),
                        Text('Chat ID: ${robot.chatid}'),
                        Text('Usage: ${robot.usage}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tambahkan aksi untuk menambah robot jika diperlukan
          // Misalnya, memanggil robotProvider.fetchRobots()
          Provider.of<RobotProvider>(context, listen: false).fetchRobots();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}