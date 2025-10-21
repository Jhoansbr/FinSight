class Usuario {
  final int id;
  final String nombre;
  final String apellido;
  final String pais;
  final String telefono;
  final String ocupacion;
  final String correo;
  final String contrasena;
  final DateTime? fechaRegistro;

  Usuario({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.pais,
    required this.telefono,
    required this.ocupacion,
    required this.correo,
    required this.contrasena,
    this.fechaRegistro,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      apellido: json['apellido'] ?? '',
      pais: json['pais'] ?? '',
      telefono: json['telefono'] ?? '',
      ocupacion: json['ocupacion'] ?? '',
      correo: json['correo'] ?? '',
      contrasena: json['contrasena'] ?? '',
      fechaRegistro: json['fechaRegistro'] != null 
          ? DateTime.parse(json['fechaRegistro']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'pais': pais,
      'telefono': telefono,
      'ocupacion': ocupacion,
      'correo': correo,
      'contrasena': contrasena,
      'fechaRegistro': fechaRegistro?.toIso8601String(),
    };
  }

  String get nombreCompleto => '$nombre $apellido';
}
