import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/comidas.dart';

//! el comidas service es el encargado de hacer las peticiones a la api
class ComidasService {
  // ! URL base de la API de comidas
  //String apiUrl = 'https://www.themealdb.com/api/json/v1/1';
  String apiUrl = dotenv.env['COMIDAS_API_URL']!;
  // ! Método para obtener la lista de comidas por búsqueda
  // * se crea una instancia del modelo Comida, se hace una petición http a la url de la api y se obtiene la respuesta
  // * si el estado de la respuesta es 200 se decodifica la respuesta y se obtiene la lista de comidas

  Future<List<Comida>> getComidasBySearch(String searchTerm) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/search.php?s=$searchTerm'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        final ComidaResponse comidaResponse = ComidaResponse.fromJson(data);
        
        // Si meals es null o está vacío, retornar lista vacía
        if (comidaResponse.meals == null || comidaResponse.meals!.isEmpty) {
          return [];
        }
        
        return comidaResponse.meals!;
      } else {
        throw Exception('Error al obtener la lista de comidas. Código: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error en getComidasBySearch: $e');
      }
      throw Exception('Error al conectar con la API de comidas: $e');
    }
  }

  // Método para obtener el detalle de una comida por ID
  Future<Comida?> getComidaById(String id) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/lookup.php?i=$id'));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        final ComidaResponse comidaResponse = ComidaResponse.fromJson(data);
        
        // Si meals es null o está vacío, retornar null
        if (comidaResponse.meals == null || comidaResponse.meals!.isEmpty) {
          return null;
        }
        
        return comidaResponse.meals!.first; // retorna el detalle de la comida
      } else {
        throw Exception('Error al obtener el detalle de la comida. Código: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error en getComidaById: $e');
      }
      throw Exception('Error al conectar con la API de comidas: $e');
    }
  }

  // Método para obtener comidas por categoría
  Future<List<Comida>> getComidasByCategory(String category) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/filter.php?c=$category'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        final ComidaResponse comidaResponse = ComidaResponse.fromJson(data);
        
        // Si meals es null o está vacío, retornar lista vacía
        if (comidaResponse.meals == null || comidaResponse.meals!.isEmpty) {
          return [];
        }
        
        return comidaResponse.meals!;
      } else {
        throw Exception('Error al obtener comidas por categoría. Código: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error en getComidasByCategory: $e');
      }
      throw Exception('Error al conectar con la API de comidas: $e');
    }
  }

  // Método por defecto para obtener comidas de Arrabiata (como especificaste en el ejemplo)
  Future<List<Comida>> getArrabiataComidas() async {
    return getComidasBySearch('Arrabiata');
  }
}