class Robot {
  final String tipe;
  final String namabot;
  final String chatid;
  final String usage;

  Robot({
    required this.tipe,
    required this.namabot,
    required this.chatid,
    required this.usage,
  });

  factory Robot.fromJson(Map<String, dynamic> json) {
    return Robot(
      tipe: json['tipe'] as String,
      namabot: json['namabot'] as String,
      chatid: json['chatid'] as String,
      usage: json['usage'] as String,
    );
  }
}

