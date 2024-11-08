import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  final String headline;
  final String description;
  final DateTime time;

  NotesModel({
    required this.description,
    required this.headline,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      "headline": headline,
      "description": description,
      "createdAt": time.toIso8601String(),
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      description: map["description"] ?? "",
      headline: map["headline"] ?? "",
      time: map["createdAt"] is Timestamp
          ? (map["createdAt"] as Timestamp).toDate() // Convert Timestamp to DateTime
          : map["createdAt"] != null
          ? DateTime.parse(map["createdAt"])      // Parse if it's a String
          : DateTime.now(),
    );
  }
}
