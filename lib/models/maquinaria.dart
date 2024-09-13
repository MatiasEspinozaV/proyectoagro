class Maquinaria {
  final String id;
  final String code;
  final String brand;
  final String model;
  final String category;
  final String status;
  final double hours;

  Maquinaria({
    required this.id,
    required this.code,
    required this.brand,
    required this.model,
    required this.category,
    required this.status,
    required this.hours,
  });

  factory Maquinaria.fromJson(Map<String, dynamic> json) {
    return Maquinaria(
      id: json['_id'],
      code: json['code'],
      brand: json['brand'],
      model: json['model'],
      category: json['category'],
      status: json['status'],
      hours: json['hours']?.toDouble() ?? 0.0,
    );
  }
}

class MaquinariasResponse {
  final List<Maquinaria> data;
  final int total;

  MaquinariasResponse({
    required this.data,
    required this.total,
  });

  factory MaquinariasResponse.fromJson(Map<String, dynamic> json) {
    return MaquinariasResponse(
      data: (json['data'] as List)
          .map((item) => Maquinaria.fromJson(item))
          .toList(),
      total: json['total'] ?? 0,
    );
  }
}
