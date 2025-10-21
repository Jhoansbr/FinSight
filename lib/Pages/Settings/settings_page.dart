import 'package:flutter/material.dart';
import '../../services/user_service.dart';
import '../../services/biometric_settings_service.dart';
import '../Login/Login.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isEditingProfile = false;
  bool _transactionsNotifications = true;
  bool _budgetAlerts = true;
  bool _weeklyReports = true;
  bool _biometricAuth = false;
  String _selectedCurrency = 'Peso Colombiano (COP)';
  String _selectedLocation = 'Colombia';

  // Profile data
  final TextEditingController _firstNameController = TextEditingController(text: 'Juan Carlos');
  final TextEditingController _lastNameController = TextEditingController(text: 'Pérez González');
  final TextEditingController _emailController = TextEditingController(text: 'juan.perez@email.com');
  final TextEditingController _phoneController = TextEditingController(text: '+57 300 123 4567');
  final TextEditingController _idController = TextEditingController(text: '12345678');
  final TextEditingController _countryController = TextEditingController(text: 'Colombia');
  final TextEditingController _occupationController = TextEditingController(text: 'Profesional');

  @override
  void initState() {
    super.initState();
    _loadBiometricSettings();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _idController.dispose();
    _countryController.dispose();
    _occupationController.dispose();
    super.dispose();
  }

  Future<void> _loadBiometricSettings() async {
    final isEnabled = await BiometricSettingsService.isBiometricEnabled();
    setState(() {
      _biometricAuth = isEnabled;
    });
  }

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
                    // Mi Perfil
                    _buildProfileCard(),
                    const SizedBox(height: 20),
                    
                    // Notificaciones
                    _buildNotificationsCard(),
                    const SizedBox(height: 20),
                    
                    // Seguridad
                    _buildSecurityCard(),
                    const SizedBox(height: 20),
                    
                    // Preferencias
                    _buildPreferencesCard(),
                    const SizedBox(height: 20),
                    
                    // Datos y Privacidad
                    _buildDataPrivacyCard(),
                    const SizedBox(height: 20),
                    
                    // Acciones de Cuenta
                    _buildAccountActionsCard(),
                    const SizedBox(height: 20),
                    
                    // Información de la Aplicación
                    _buildAppInfoCard(),
                    const SizedBox(height: 100), // Space for FAB
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "settings_fab",
        onPressed: () {
          // Add new setting action
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
            'Ajustes',
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

  // Mi Perfil Card
  Widget _buildProfileCard() {
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
                  Icons.person_outline,
                  color: Color(0xFF2C3E50),
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Mi Perfil',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isEditingProfile = !_isEditingProfile;
                    });
                  },
                  icon: Icon(
                    _isEditingProfile ? Icons.close : Icons.edit_outlined,
                    color: const Color(0xFF2C3E50),
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2196F3),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      'JP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!_isEditingProfile) ...[
                        const Text(
                          'Juan Carlos Pérez González',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'juan.perez@email.com',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F2FD),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Profesional',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF2C3E50),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ] else ...[
                        const Text(
                          'Juan Carlos Pérez González',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'juan.perez@email.com',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F2FD),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Profesional',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF2C3E50),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            if (_isEditingProfile) ...[
              const SizedBox(height: 20),
              // Nombres y Apellidos en dos columnas
              Row(
                children: [
                  Expanded(
                    child: _buildProfileField('Nombres', _firstNameController),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildProfileField('Apellidos', _lastNameController),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Correo electrónico
              _buildProfileFieldWithIcon('Correo electrónico', _emailController, Icons.mail_outline, 'juan.perez@email.com'),
              const SizedBox(height: 16),
              // Teléfono
              _buildProfileFieldWithIcon('Teléfono', _phoneController, Icons.phone_outlined, '+57 300 123 4567'),
              const SizedBox(height: 16),
              // Número de Identificación
              _buildProfileFieldWithIcon('Número de Identificación', _idController, Icons.credit_card_outlined, '12345678'),
              const SizedBox(height: 16),
              // País
              _buildProfileDropdownField('País', _countryController, Icons.public, 'Colombia'),
              const SizedBox(height: 16),
              // Ocupación
              _buildProfileDropdownField('Ocupación', _occupationController, Icons.business, 'Profesional'),
              const SizedBox(height: 24),
              // Botones
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isEditingProfile = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Guardar cambios'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _isEditingProfile = false;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF2C3E50),
                        side: const BorderSide(color: Color(0xFFE0E0E0)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Cancelar'),
                    ),
                  ),
                ],
              ),
            ] else ...[
              const SizedBox(height: 16),
              _buildProfileInfo(Icons.mail_outline, 'juan.perez@email.com'),
              const SizedBox(height: 12),
              _buildProfileInfo(Icons.phone_outlined, '+57 300 123 4567'),
              const SizedBox(height: 12),
              _buildProfileInfo(Icons.credit_card_outlined, '12345678'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF2C3E50),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileFieldWithIcon(String label, TextEditingController controller, IconData icon, String placeholder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF2C3E50),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            prefixIcon: Icon(
              icon,
              color: const Color(0xFF2C3E50),
              size: 20,
            ),
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Color(0xFF9E9E9E),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileDropdownField(String label, TextEditingController controller, IconData icon, String placeholder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: true,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF2C3E50),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            prefixIcon: Icon(
              icon,
              color: const Color(0xFF2C3E50),
              size: 20,
            ),
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF9E9E9E),
              size: 20,
            ),
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Color(0xFF9E9E9E),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF2C3E50),
          size: 20,
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF2C3E50),
          ),
        ),
      ],
    );
  }

  // Notificaciones Card
  Widget _buildNotificationsCard() {
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
                  Icons.notifications_none,
                  color: Color(0xFF2C3E50),
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Notificaciones',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildNotificationItem(
              'Transacciones',
              'Notificaciones de movimientos',
              _transactionsNotifications,
              (value) {
                setState(() {
                  _transactionsNotifications = value;
                });
              },
            ),
            const Divider(height: 1),
            _buildNotificationItem(
              'Alertas de Presupuesto',
              'Cuando te acerques al limite',
              _budgetAlerts,
              (value) {
                setState(() {
                  _budgetAlerts = value;
                });
              },
            ),
            const Divider(height: 1),
            _buildNotificationItem(
              'Reportes Semanales',
              'Resumen de gastos',
              _weeklyReports,
              (value) {
                setState(() {
                  _weeklyReports = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF2196F3),
            inactiveThumbColor: const Color(0xFF9E9E9E),
            inactiveTrackColor: const Color(0xFFE0E0E0),
          ),
        ],
      ),
    );
  }

  // Seguridad Card
  Widget _buildSecurityCard() {
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
                  Icons.security,
                  color: Color(0xFF2C3E50),
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Seguridad',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildNotificationItem(
              'Autenticación Biométrica',
              'Huella dactilar o Face ID',
              _biometricAuth,
              (value) async {
                setState(() {
                  _biometricAuth = value;
                });
                // Guardar la configuración
                await BiometricSettingsService.toggleBiometric(value);
              },
            ),
            const Divider(height: 1),
            _buildButtonItem(
              icon: Icons.lock_outline,
              title: 'Cambiar Contraseña',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  // Preferencias Card
  Widget _buildPreferencesCard() {
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
                  Icons.settings,
                  color: Color(0xFF2C3E50),
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Preferencias',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildDropdownItem(
              title: 'Moneda Principal',
              value: _selectedCurrency,
              onTap: () {
                _showCurrencyDialog();
              },
            ),
            const Divider(height: 1),
            _buildDropdownItem(
              title: 'Ubicación',
              value: _selectedLocation,
              onTap: () {
                _showLocationDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  // Datos y Privacidad Card
  Widget _buildDataPrivacyCard() {
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
            const Text(
              'Datos y Privacidad',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingItem(
              icon: Icons.download_outlined,
              title: 'Exportar mis datos',
              onTap: () {},
            ),
            const Divider(height: 1),
            _buildSettingItem(
              icon: Icons.help_outline,
              title: 'Centro de ayuda',
              onTap: () {},
            ),
            const Divider(height: 1),
            _buildSettingItem(
              icon: Icons.chat_bubble_outline,
              title: 'Contactar soporte',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  // Acciones de Cuenta Card
  Widget _buildAccountActionsCard() {
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
          children: [
            _buildSettingItem(
              icon: Icons.delete_outline,
              title: 'Eliminar cuenta',
              textColor: const Color(0xFFF44336),
              iconColor: const Color(0xFFF44336),
              onTap: () {},
            ),
            const Divider(height: 1),
            _buildSettingItem(
              icon: Icons.logout,
              title: 'Cerrar sesión',
              onTap: () async {
                await UserService.logout();
                if (mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Información de la Aplicación Card
  Widget _buildAppInfoCard() {
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
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/logo.png',
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FinSight',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Versión 2.1.0',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widgets
  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    Color? textColor,
    Color? iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? const Color(0xFF2C3E50),
              size: 20,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? const Color(0xFF2C3E50),
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFF9E9E9E),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownItem({
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE0E0E0)),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF9E9E9E),
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF2C3E50),
              size: 16,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2C3E50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCurrencyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Moneda Principal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCurrencyOption('Peso Colombiano (COP)'),
              _buildCurrencyOption('Dólar Americano (USD)'),
              _buildCurrencyOption('Euro (EUR)'),
              _buildCurrencyOption('Peso Mexicano (MXN)'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCurrencyOption(String currency) {
    return ListTile(
      title: Text(currency),
      onTap: () {
        setState(() {
          _selectedCurrency = currency;
        });
        Navigator.pop(context);
      },
    );
  }

  void _showLocationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ubicación'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLocationOption('Colombia'),
              _buildLocationOption('México'),
              _buildLocationOption('Estados Unidos'),
              _buildLocationOption('España'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLocationOption(String location) {
    return ListTile(
      title: Text(location),
      onTap: () {
        setState(() {
          _selectedLocation = location;
        });
        Navigator.pop(context);
      },
    );
  }
}