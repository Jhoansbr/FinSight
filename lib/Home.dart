import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0072ff), Color(0xFF00c6ff)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(Icons.account_balance_wallet,
                  color: Colors.green, size: 50),
            ),
            const SizedBox(height: 20),
            // Título
            const Text(
              "FinSight",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              "Visión inteligente para tus finanzas",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 40),
            // Botones
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                _buildMenuButton(Icons.bar_chart, "Análisis Inteligente"),
                _buildMenuButton(Icons.flag, "Metas Automáticas"),
                _buildMenuButton(Icons.security, "Alertas IA"),
                _buildMenuButton(Icons.visibility, "Visión Financiera"),
              ],
            ),
            const SizedBox(height: 40),
            const Text("Versión 2.1.0",
                style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(IconData icon, String text) {
    return SizedBox(
      width: 140,
      height: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
        ),
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: Colors.green),
            const SizedBox(height: 8),
            Text(text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
