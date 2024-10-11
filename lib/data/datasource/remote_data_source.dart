
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class RobotService {
  final String url = 'https://main.robotahli.id/html/usage?list=1';

  Future<List<Robot>> fetchRobots() async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        String body = response.body.trim();

        // Periksa apakah respon adalah array JSON
        if (body.startsWith('[') && body.endsWith(']')) {
          List<dynamic> data = json.decode(body);
          List<Robot> robots = data.map((item) => Robot.fromJson(item)).toList();
          return robots;
        } else {
          // Jika bukan array, tambahkan tanda kurung siku
          body = '[$body]';
          List<dynamic> data = json.decode(body);
          List<Robot> robots = data.map((item) => Robot.fromJson(item)).toList();
          return robots;
        }
      } else {
        throw Exception('Gagal memuat data robots. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching robots: $e');
    }
  }
}
