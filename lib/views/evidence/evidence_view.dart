import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../services/auth_service.dart';
import 'package:go_router/go_router.dart';

class EvidenceView extends StatefulWidget {
  const EvidenceView({Key? key}) : super(key: key);

  @override
  State<EvidenceView> createState() => _EvidenceViewState();
}

class _EvidenceViewState extends State<EvidenceView> {
  String? name;
  String? email;
  String? token;
  bool hasToken = false;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final userData = await _authService.getUserData();
    final tokenValue = await const FlutterSecureStorage().read(key: 'access_token');
    setState(() {
      name = userData['name'];
      email = userData['email'];
      token = tokenValue;
      hasToken = tokenValue != null && tokenValue.isNotEmpty;
    });
  }

  Future<void> _logout() async {
    await _authService.logout();
    setState(() {
      name = null;
      email = null;
      hasToken = false;
    });
    if (mounted) {
      // Usar GoRouter para redirigir al login de forma segura
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Evidencia de sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('SharedPreferences', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 8),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: Text('Nombre'),
                        subtitle: Text(name ?? 'No disponible'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: Text('Email'),
                        subtitle: Text(email ?? 'No disponible'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('SecureStorage', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 8),
                      ListTile(
                        leading: const Icon(Icons.vpn_key),
                        title: Text('Token JWT'),
                        subtitle: Text(token ?? 'No disponible', style: const TextStyle(fontSize: 12)),
                        trailing: hasToken
                            ? const Icon(Icons.check_circle, color: Colors.green)
                            : const Icon(Icons.cancel, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: hasToken ? _logout : null,
                child: const Text('Cerrar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
