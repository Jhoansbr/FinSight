import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../core/widgets/navigation_buttons.dart';
import '../../../core/widgets/progress_bar.dart';
import '../../Pages/Login/Login.dart';
import 'step_three_page.dart';

class StepTwoPage extends StatefulWidget {
  const StepTwoPage({super.key});

  @override
  State<StepTwoPage> createState() => _StepTwoPageState();
}

class _StepTwoPageState extends State<StepTwoPage> {
  final telefonoCtrl = TextEditingController();
  final ocupacionCtrl = TextEditingController();

  List<String> _paises = [];
  String? _paisSeleccionado;
  bool _cargandoPaises = true;

  @override
  void initState() {
    super.initState();
    _cargarPaises();
  }

  Future<void> _cargarPaises() async {
    try {
      final response = await http.get(
        Uri.parse("https://restcountries.com/v3.1/all?fields=name"),
      );

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        setState(() {
          _paises = data
              .map((pais) => pais["name"]?["common"]?.toString())
              .where((nombre) => nombre != null)
              .cast<String>()
              .toList();
          _paises.sort((a, b) => a.compareTo(b));
          _cargandoPaises = false;
        });
      } else {
        throw Exception("Error al obtener países: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => _cargandoPaises = false);
      debugPrint("Error cargando países: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Image.asset("assets/images/logo.png", width: 80, height: 80),
                  const SizedBox(height: 12),
                  const Text(
                    "FinSight",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),

                  const ProgressBar(step: 2, totalSteps: 4),

                  const SizedBox(height: 8),
                  const Text(
                    "Información de contacto y ocupación",
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),

                  // --- Tarjeta del formulario ---
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            "Información de Contacto",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Dropdown dinámico de países
                        const Text(
                          "País",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),

                        _cargandoPaises
                            ? Container(
                          alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F6F8),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: const CircularProgressIndicator(
                            color: Color(0xFF3B82F6),
                            strokeWidth: 2,
                          ),
                        )
                            : DropdownButtonFormField<String>(
                          value: _paisSeleccionado,
                          hint: const Text("Selecciona un país"),
                          isExpanded: true,
                          items: _paises
                              .map(
                                (pais) => DropdownMenuItem<String>(
                              value: pais,
                              child: Text(pais),
                            ),
                          )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _paisSeleccionado = value;
                            });
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.flag_outlined,
                                color: Colors.black45),
                            filled: true,
                            fillColor: const Color(0xFFF4F6F8),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color(0xFF3B82F6), width: 1.2),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
                        _buildTextField(
                          label: "Número de teléfono",
                          hint: "+57 300 123 4567",
                          icon: Icons.phone_outlined,
                          controller: telefonoCtrl,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          label: "Ocupación",
                          hint: "Ingeniero de Software",
                          icon: Icons.work_outline,
                          controller: ocupacionCtrl,
                        ),

                        const SizedBox(height: 24),

                        // --- Botones dentro de la tarjeta ---
                        NavigationButtons(
                          showPrevious: true,
                          onPrevious: () {
                            Navigator.pop(context);
                          },
                          onNext: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const StepThreePage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // --- Texto con solo "Iniciar sesión" clickeable ---
                  const SizedBox(height: 20),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "¿Ya tienes una cuenta? ",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: "Iniciar sesión",
                          style: const TextStyle(
                            color: Color(0xFF3B82F6),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Colors.black45),
            filled: true,
            fillColor: const Color(0xFFF4F6F8),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFF3B82F6),
                width: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
