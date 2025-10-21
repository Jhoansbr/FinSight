import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            
            // Content with all sections
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Column(
                  children: [
                    // Análisis Inteligente
                    _buildAIInsightsCard(),
                    const SizedBox(height: 20),
                    
                    // Tendencias y Predicciones
                    _buildTrendsCard(),
                    const SizedBox(height: 20),
                    
                    // Análisis por Categorías
                    _buildCategoryAnalysisCard(),
                    const SizedBox(height: 20),
                    
                    // Presupuesto vs Real
                    _buildBudgetVsRealCard(),
                    const SizedBox(height: 100), // Space for FAB
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new analysis action
        },
        backgroundColor: const Color(0xFF4CAF50),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: const Row(
        children: [
          Text(
            'Análisis',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
        ],
      ),
    );
  }

  // Presupuesto vs Real Card
  Widget _buildBudgetVsRealCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1976D2),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.circle,
                      color: Colors.white,
                      size: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Presupuesto vs Real',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildBudgetCategory('Alimentación', 1200, 1400, 86, const Color(0xFFFF9800)),
            const SizedBox(height: 16),
            _buildBudgetCategory('Transporte', 800, 900, 89, const Color(0xFFFF9800)),
            const SizedBox(height: 16),
            _buildBudgetCategory('Entretenimiento', 400, 500, 80, const Color(0xFFFF9800)),
            const SizedBox(height: 16),
            _buildBudgetCategory('Servicios', 600, 650, 92, const Color(0xFFF44336)),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetCategory(String category, int actual, int budget, int percentage, Color percentageColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            Text(
              '\$$actual / \$$budget',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF9E9E9E),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color(0xFFE0E0E0),
          ),
          child: Row(
            children: [
              Expanded(
                flex: actual,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFF1976D2),
                  ),
                ),
              ),
              Expanded(
                flex: budget - actual,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFE3F2FD),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '$percentage%',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: percentageColor,
            ),
          ),
        ),
      ],
    );
  }


  // Análisis Inteligente Card
  Widget _buildAIInsightsCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.psychology,
                  color: Color(0xFF4CAF50),
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Análisis Inteligente',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Insights generados por IA',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            _buildInsightCard(
              'Patrón de Gasto Detectado',
              'Alto impacto',
              'Gastas 40% más los fines de semana, principalmente en entretenimiento y alimentación.',
              'Considera preparar comidas en casa los fines de semana para ahorrar \$120/mes.',
              const Color(0xFFF44336),
              Icons.bar_chart,
            ),
            const SizedBox(height: 16),
            _buildInsightCard(
              'Gasto Inusual Detectado',
              'Impacto medio',
              'Tu gasto en transporte aumentó 25% este mes vs promedio histórico.',
              'Revisa si hubo viajes adicionales o considera opciones más económicas.',
              const Color(0xFFFF9800),
              Icons.warning,
            ),
            const SizedBox(height: 16),
            _buildInsightCard(
              'Oportunidad de Ahorro',
              'Bajo impacto',
              'Tienes 3 suscripciones inactivas que suman \$35/mes',
              'Cancela Netflix, Spotify Premium y Adobe CC para ahorrar \$420/año.',
              const Color(0xFF4CAF50),
              Icons.attach_money,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightCard(String title, String impact, String description, String suggestion, Color borderColor, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: borderColor, width: 4),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: borderColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: borderColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  impact,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF2C3E50),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.lightbulb_outline,
                color: Color(0xFFFFC107),
                size: 16,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  suggestion,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Tendencias y Predicciones Card
  Widget _buildTrendsCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.trending_up,
                  color: Color(0xFF2196F3),
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Tendencias y Predicciones',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          const style = TextStyle(
                            color: Color(0xFF2C3E50),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          );
                          Widget text;
                          switch (value.toInt()) {
                            case 0:
                              text = const Text('Feb', style: style);
                              break;
                            case 1:
                              text = const Text('Mar', style: style);
                              break;
                            case 2:
                              text = const Text('Abr', style: style);
                              break;
                            case 3:
                              text = const Text('May', style: style);
                              break;
                            case 4:
                              text = const Text('Jun', style: style);
                              break;
                            case 5:
                              text = const Text('Jul', style: style);
                              break;
                            case 6:
                              text = const Text('Ago', style: style);
                              break;
                            default:
                              text = const Text('', style: style);
                              break;
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 16,
                            child: text,
                          );
                        },
                        reservedSize: 38,
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 3.2),
                        const FlSpot(1, 2.8),
                        const FlSpot(2, 2.5),
                        const FlSpot(3, 3.1),
                        const FlSpot(4, 3.4),
                      ],
                      isCurved: true,
                      color: const Color(0xFF4CAF50),
                      barWidth: 3,
                      belowBarData: BarAreaData(
                        show: true,
                        color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                      ),
                    ),
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 3.2),
                        const FlSpot(1, 2.8),
                        const FlSpot(2, 2.5),
                        const FlSpot(3, 3.1),
                        const FlSpot(4, 3.4),
                        const FlSpot(5, 3.2),
                        const FlSpot(6, 3.0),
                      ],
                      isCurved: true,
                      color: const Color(0xFF2196F3),
                      barWidth: 2,
                      dashArray: [5, 5],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem('Gastos reales', const Color(0xFF4CAF50), true),
                const SizedBox(width: 20),
                _buildLegendItem('Predicción IA', const Color(0xFF2196F3), false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, bool isFilled) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: isFilled ? color : Colors.transparent,
            border: Border.all(color: color, width: 2),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF2C3E50),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Análisis por Categorías Card
  Widget _buildCategoryAnalysisCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.history,
                  color: Color(0xFF9C27B0),
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Análisis por Categorías',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildCategoryAnalysis('Alimentación', 11.1, 1200, 1350, true),
            const SizedBox(height: 16),
            _buildCategoryAnalysis('Transporte', 11.1, 800, 720, true),
            const SizedBox(height: 16),
            _buildCategoryAnalysis('Entretenimiento', 14.9, 400, 470, false),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryAnalysis(String category, double percentage, int actual, int previous, bool isIncrease) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              Row(
                children: [
                  Icon(
                    isIncrease ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: isIncrease ? const Color(0xFF4CAF50) : const Color(0xFFF44336),
                    size: 16,
                  ),
                  Text(
                    '$percentage%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isIncrease ? const Color(0xFF4CAF50) : const Color(0xFFF44336),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Actual: \$$actual',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF2C3E50),
                ),
              ),
              Text(
                'Anterior: \$$previous',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9E9E9E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}





