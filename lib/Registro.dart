import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  _RegistroScreenState createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Países
  List<String> _paises = [];
  String? _paisSeleccionado;

  // Ocupaciones
  final List<String> _ocupaciones = [
    "Estudiante",
    "Empleado",
    "Independiente",
    "Empresario",
    "Otro"
  ];
  String? _ocupacionSeleccionada;

  bool aceptaTerminos = false;
  bool recibeEmails = false;

  @override
  void initState() {
    super.initState();
    _cargarPaises();
  }

  Future<void> _cargarPaises() async {
    try {
      final response = await http.get(Uri.parse(
          "https://restcountries.com/v3.1/all?fields=name")); // solo nombres

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        setState(() {
          _paises = data
              .map((pais) => pais["name"]?["common"]?.toString())
              .where((nombre) => nombre != null)
              .cast<String>()
              .toList();

          _paises.sort((a, b) => a.compareTo(b));
        });
      } else {
        print("Error en la API: ${response.statusCode}");
      }
    } catch (e) {
      print("Error cargando países: $e");
    }
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cuenta creada con éxito ✅")),
      );
    }
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: const Text("Registro"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Indicador de pasos
          Padding(
            padding: const EdgeInsets.all(16),
            child: LinearProgressIndicator(
              value: (_currentPage + 1) / 3,
              backgroundColor: Colors.grey.shade300,
              color: Colors.green,
              minHeight: 6,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // Contenido con scroll
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                // Página 1
                SingleChildScrollView(
                  child: _buildCard(
                    child: Column(
                      children: [
                        const Icon(Icons.person,
                            size: 60, color: Colors.green),
                        const SizedBox(height: 10),
                        _buildInput("Nombres", Icons.person),
                        const SizedBox(height: 10),
                        _buildInput("Apellidos", Icons.person_outline),
                        const SizedBox(height: 10),
                        _buildInput("Número de Identificación", Icons.badge),
                      ],
                    ),
                  ),
                ),

                // Página 2
                SingleChildScrollView(
                  child: _buildCard(
                    child: Column(
                      children: [
                        const Icon(Icons.contact_phone,
                            size: 60, color: Colors.green),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "País",
                            prefixIcon: const Icon(Icons.public),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          isExpanded: true, // ✅ evita overflow en textos largos
                          value: _paisSeleccionado,
                          items: _paises.isEmpty
                              ? [
                                  const DropdownMenuItem(
                                      value: null,
                                      child: Text("Cargando..."))
                                ]
                              : _paises
                                  .map((pais) => DropdownMenuItem(
                                      value: pais, child: Text(pais)))
                                  .toList(),
                          onChanged: (value) {
                            setState(() {
                              _paisSeleccionado = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        _buildInput("Número de teléfono", Icons.phone),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "Ocupación",
                            prefixIcon: const Icon(Icons.work),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          isExpanded: true,
                          value: _ocupacionSeleccionada,
                          items: _ocupaciones
                              .map((ocupacion) => DropdownMenuItem(
                                  value: ocupacion, child: Text(ocupacion)))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _ocupacionSeleccionada = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Página 3
                SingleChildScrollView(
                  child: _buildCard(
                    child: Column(
                      children: [
                        const Icon(Icons.lock,
                            size: 60, color: Colors.green),
                        const SizedBox(height: 10),
                        _buildInput("Correo electrónico", Icons.email),
                        const SizedBox(height: 10),
                        _buildInput("Contraseña", Icons.lock,
                            isPassword: true),
                        const SizedBox(height: 10),
                        _buildInput("Confirmar contraseña", Icons.lock,
                            isPassword: true),
                        const SizedBox(height: 10),
                        CheckboxListTile(
                          value: aceptaTerminos,
                          onChanged: (v) =>
                              setState(() => aceptaTerminos = v ?? false),
                          title: const Text(
                              "Acepto los Términos de Servicio y la Política de Privacidad"),
                        ),
                        CheckboxListTile(
                          value: recibeEmails,
                          onChanged: (v) =>
                              setState(() => recibeEmails = v ?? false),
                          title: const Text("Quiero recibir novedades por email"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Botón siguiente
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                  _currentPage < 2 ? "Siguiente" : "Crear cuenta",
                  style: const TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(String label, IconData icon, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
