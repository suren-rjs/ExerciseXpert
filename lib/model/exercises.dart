import 'dart:convert';

class Exercise {
  String bodyPart;
  String equipment;
  String gifUrl;
  String id;
  String name;
  String target;

  Exercise({
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
    required this.id,
    required this.name,
    required this.target,
  });

  static List<Exercise> parseExercises(List<dynamic> jsonList) {
    return jsonList.map((exerciseJson) => Exercise.fromJson(exerciseJson)).toList();
  }


  factory Exercise.fromRawJson(String str) => Exercise.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    bodyPart: json["bodyPart"],
    equipment: json["equipment"],
    gifUrl: json["gifUrl"],
    id: json["id"],
    name: json["name"],
    target: json["target"],
  );

  Map<String, dynamic> toJson() => {
    "bodyPart": bodyPart,
    "equipment": equipment,
    "gifUrl": gifUrl,
    "id": id,
    "name": name,
    "target": target,
  };
}
