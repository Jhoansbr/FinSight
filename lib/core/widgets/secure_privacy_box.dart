import 'package:flutter/material.dart';

class SecurePrivacyBox extends StatelessWidget {
  const SecurePrivacyBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(12),
        color: Colors.green.shade50,
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lock_outline, color: Colors.green),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "100% Seguro y Privado\nNunca compartimos tus datos. Encriptación de nivel bancario garantizada.",
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
