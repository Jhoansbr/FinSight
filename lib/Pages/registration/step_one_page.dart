import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../../core/widgets/navigation_buttons.dart';
import '../../../core/widgets/progress_bar.dart';
import '../../../core/widgets/secure_privacy_box.dart';
import '../../Pages/Login/Login.dart';
import 'step_two_page.dart';

class StepOnePage extends StatelessWidget {
  const StepOnePage({super.key});

  @override
  Widget build(BuildContext context) {
    final nombreCtrl = TextEditingController();
    final apellidoCtrl = TextEditingController();
    final idCtrl = TextEditingController();

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
                  Image.asset(
                    "assets/images/logo.png",
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "FinSight",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),

                  const ProgressBar(step: 1, totalSteps: 4),

                  const SizedBox(height: 8),
                  const Text(
                    "Datos básicos de identificación",
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
                            "Información Personal",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                label: "Nombres",
                                hint: "Juan Carlos",
                                icon: Icons.person_outline,
                                controller: nombreCtrl,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildTextField(
                                label: "Apellidos",
                                hint: "Pérez González",
                                icon: Icons.person_outline,
                                controller: apellidoCtrl,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          label: "Número de Identificación",
                          hint: "12345678",
                          icon: Icons.badge_outlined,
                          controller: idCtrl,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Cédula, DNI, pasaporte u otro documento de identidad",
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),

                        const SizedBox(height: 24),

                        NavigationButtons(
                          showPrevious: true,
                          onPrevious: () {},
                          onNext: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const StepTwoPage(),
                              ),
                            );
                          },
                          // 🔹 Cambiamos el color del botón principal a verde
                          primaryColor: const Color(0xFF22C55E),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

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
                            color: Color(0xFF22C55E), // 🟢 Verde
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
              borderSide:
              const BorderSide(color: Color(0xFF22C55E), width: 1.2), // 🟢 Verde
            ),
          ),
        ),
      ],
    );
  }
}
