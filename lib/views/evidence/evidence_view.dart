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
  bool hasToken = false;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final userData = await _authService.getUserData();
    final tokenPresent = await _authService.hasToken();
    setState(() {
      name = userData['name'];
      email = userData['email'];
      hasToken = tokenPresent;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nombre: ${name ?? "No disponible"}'),
            Text('Email: ${email ?? "No disponible"}'),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Estado de sesión: '),
                hasToken
                    ? const Text('token presente', style: TextStyle(color: Colors.green))
                    : const Text('sin token', style: TextStyle(color: Colors.red)),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: hasToken ? _logout : null,
              child: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
