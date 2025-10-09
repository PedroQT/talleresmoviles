import 'package:flutter/material.dart';

import '../../models/comidas.dart';
import '../../services/comidas_service.dart';

class ComidasDetailView extends StatefulWidget {
  final String idMeal;

  const ComidasDetailView({super.key, required this.idMeal});

  @override
  State<ComidasDetailView> createState() => _ComidasDetailViewState();
}

class _ComidasDetailViewState extends State<ComidasDetailView> {
  // Se crea una instancia de la clase ComidasService
  final ComidasService _comidasService = ComidasService();
  // Se declara una variable de tipo Future que contendrá el detalle de la Comida
  late Future<Comida?> _futureComida;

  @override
  void initState() {
    super.initState();
    // Se llama al método getComidaById de la clase ComidasService
    _futureComida = _comidasService.getComidaById(widget.idMeal);
  }

  // Método para mostrar información de YouTube
  void _showYouTubeInfo(String url) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Video disponible en YouTube: $url'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Comida'),
        backgroundColor: Colors.orange.shade100,
      ),
      //* se usa future builder para construir widgets basados en un Future
      body: FutureBuilder<Comida?>(
        future: _futureComida,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final comida = snapshot.data!; // Se obtiene el detalle de la Comida
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen de la comida
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        comida.strMealThumb,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: const Icon(
                              Icons.restaurant,
                              size: 80,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Nombre de la comida
                  Text(
                    comida.strMeal,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Categoría y área
                  Row(
                    children: [
                      Chip(
                        label: Text(comida.strCategory),
                        backgroundColor: Colors.blue.shade100,
                      ),
                      const SizedBox(width: 8),
                      Chip(
                        label: Text(comida.strArea),
                        backgroundColor: Colors.green.shade100,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Tags si existen
                  if (comida.strTags != null && comida.strTags!.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      children: comida.strTags!.split(',').map((tag) {
                        return Chip(
                          label: Text(tag.trim()),
                          backgroundColor: Colors.orange.shade100,
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 16),

                  // Botón de YouTube si existe
                  if (comida.strYoutube != null && comida.strYoutube!.isNotEmpty)
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () => _showYouTubeInfo(comida.strYoutube!),
                        icon: const Icon(Icons.play_arrow, color: Colors.red),
                        label: const Text('Ver en YouTube'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade50,
                          foregroundColor: Colors.red,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),

                  // Ingredientes
                  const Text(
                    'Ingredientes:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: List.generate(comida.ingredients.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                const Icon(Icons.fiber_manual_record, size: 8),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '${comida.ingredients[index]} - ${comida.measures[index]}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Instrucciones
                  const Text(
                    'Instrucciones:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        comida.strInstructions,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData && snapshot.data == null) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No se encontró la comida',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _futureComida = _comidasService.getComidaById(widget.idMeal);
                      });
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Cargando detalle de la comida...'),
              ],
            ),
          );
        },
      ),
    );
  }
}