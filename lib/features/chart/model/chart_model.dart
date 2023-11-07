import 'dart:convert';

class Chart {
  final String objectid;
  final String id;
  final List<dynamic> moneys;

  Chart({
    required this.objectid,
    required this.id,
    required this.moneys,
  });

  Map<String, dynamic> toMap() {
    return {
      'moneys': moneys,
      'objectid': objectid,
      'id': id,
    };
  }

  factory Chart.fromMap(Map<String, dynamic> map) {
    return Chart(
      moneys: List<Map<String, dynamic>>.from(
        map['moneys']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
      objectid: map['_id'] ?? '',
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Chart.fromJson(String source) => Chart.fromMap(json.decode(source));

  Chart copyWith({
    List<dynamic>? moneys,
    String? objectid,
    String? id,
  }) {
    return Chart(
      moneys: moneys ?? this.moneys,
      objectid: objectid ?? this.objectid,
      id: id ?? this.id,
    );
  }
}
