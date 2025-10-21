import 'package:flutter/material.dart';

class MovementsPage extends StatefulWidget {
  const MovementsPage({super.key});

  @override
  State<MovementsPage> createState() => _MovementsPageState();
}

class _MovementsPageState extends State<MovementsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Transacciones',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  Container(
                    height: 36,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2C6ED5),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      ),
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text(
                        'Nueva',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Financial Summary Cards
                    _buildSummaryCards(),
                    const SizedBox(height: 20),
                    
                    // AI Analysis Card
                    _buildAIAnalysisCard(),
                    const SizedBox(height: 20),
                    
                    // Search and Filter
                    _buildSearchAndFilter(),
                    const SizedBox(height: 20),
                    
                    // Transaction List
                    _buildTransactionList(),
                    const SizedBox(height: 100), // Espacio para el FAB
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF4CAF50),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard('Balance', '\$4,856', '96', const Color(0xFF4CAF50)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildSummaryCard('Ingresos', '\$5,450', '96', const Color(0xFF4CAF50)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildSummaryCard('Gastos', '\$593', '04', const Color(0xFFF44336)),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String amount, String cents, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF666666),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  amount,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 1),
              Text(
                cents,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAIAnalysisCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.psychology,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Análisis IA',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Nuevo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'He categorizado automáticamente el 85% de tus transacciones. Detecté un patrón: gastas más en alimentación los fines de semana.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Column(
      children: [
        // Search Bar
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Buscar transacciones...',
              hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
              prefixIcon: Icon(Icons.search, color: Color(0xFF9E9E9E)),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Filter Dropdowns
        Row(
          children: [
            Expanded(
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Todas las categorías',
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.keyboard_arrow_down, color: Color(0xFF9E9E9E)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Todos',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down, color: Color(0xFF9E9E9E)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTransactionList() {
    final transactions = [
      {
        'title': 'Netflix Suscrip...',
        'date': '16/6/2024',
        'amount': '\$12.99',
        'amountColor': const Color(0xFFF44336),
        'category': 'Entretenimiento',
        'categoryColor': const Color(0xFFE1BEE7),
        'icon': Icons.play_circle,
        'iconColor': const Color(0xFF9C27B0),
        'status': 'Recurrente',
        'statusColor': const Color(0xFFE0E0E0),
        'isIncome': false, // Gasto - flecha hacia abajo
      },
      {
        'title': 'Transferencia - Juan Pérez',
        'date': '15/6/2024',
        'amount': '+\$150',
        'amountColor': const Color(0xFF4CAF50),
        'category': 'Transferencias',
        'categoryColor': const Color(0xFFB2DFDB),
        'icon': Icons.swap_horiz,
        'iconColor': const Color(0xFF009688),
        'isIncome': true, // Ingreso - flecha hacia arriba
      },
      {
        'title': 'Gasolina Shell',
        'date': '14/6/2024',
        'amount': '\$65',
        'amountColor': const Color(0xFFF44336),
        'category': 'Transporte',
        'categoryColor': const Color(0xFFBBDEFB),
        'icon': Icons.directions_car,
        'iconColor': const Color(0xFF2196F3),
        'location': 'Estación Shell Av. Principal',
        'isIncome': false, // Gasto - flecha hacia abajo
      },
      {
        'title': 'Compra en lin...',
        'date': '13/6/2024',
        'amount': '\$240.75',
        'amountColor': const Color(0xFFF44336),
        'category': 'Compras',
        'categoryColor': const Color(0xFFF8BBD9),
        'icon': Icons.shopping_cart,
        'iconColor': const Color(0xFFE91E63),
        'status': 'Pendiente',
        'statusColor': const Color(0xFFE0E0E0),
        'isIncome': false, // Gasto - flecha hacia abajo
      },
      {
        'title': 'Café & Co',
        'date': '13/6/2024',
        'amount': '\$8.5',
        'amountColor': const Color(0xFFF44336),
        'category': 'Alimentación',
        'categoryColor': const Color(0xFFFFF3E0),
        'icon': Icons.restaurant,
        'iconColor': const Color(0xFFFF9800),
        'location': 'Plaza de Armas',
        'isIncome': false, // Gasto - flecha hacia abajo
      },
      {
        'title': 'Pago de luz',
        'date': '12/6/2024',
        'amount': '\$85.3',
        'amountColor': const Color(0xFFF44336),
        'category': 'Servicios',
        'categoryColor': const Color(0xFFE0E0E0),
        'icon': Icons.home,
        'iconColor': const Color(0xFF9E9E9E),
        'status': 'Recurrente',
        'statusColor': const Color(0xFFE0E0E0),
        'isIncome': false, // Gasto - flecha hacia abajo
      },
    ];

    return Column(
      children: transactions.map((transaction) => _buildTransactionCard(transaction)).toList(),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icono de la transacción
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: transaction['iconColor'],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              transaction['icon'],
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          // Información de la transacción
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction['date'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF666666),
                  ),
                ),
                if (transaction['location'] != null) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 12, color: Color(0xFF666666)),
                      const SizedBox(width: 4),
                      Text(
                        transaction['location'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: transaction['categoryColor'],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        transaction['category'],
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.psychology, size: 12, color: Color(0xFF666666)),
                          const SizedBox(width: 4),
                          const Text(
                            'IA',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF333333),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Monto y estado
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (transaction['status'] != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: transaction['statusColor'],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    transaction['status'],
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
              ],
              Text(
                transaction['amount'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: transaction['amountColor'],
                ),
              ),
              const SizedBox(height: 4),
              Icon(
                transaction['isIncome'] ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: transaction['amountColor'],
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
