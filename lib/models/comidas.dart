/// Modelo para representar una Comida con sus datos principales
class Comida {
  String idMeal;
  String strMeal;
  String? strMealAlternate;
  String strCategory;
  String strArea;
  String strInstructions;
  String strMealThumb;
  String? strTags;
  String? strYoutube;
  List<String> ingredients;
  List<String> measures;

  // Constructor de la clase Comida con los atributos requeridos
  // esto se hace para que al crear una instancia de Comida, estos atributos sean obligatorios
  // se usa en el fromJson que es un metodo que convierte un JSON en una instancia de Comida
  Comida({
    required this.idMeal,
    required this.strMeal,
    this.strMealAlternate,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    this.strTags,
    this.strYoutube,
    required this.ingredients,
    required this.measures,
  });

  // Factory porque es un método que retorna una nueva instancia de la clase
  // este metodo se usa para convertir un JSON en una instancia de Comida
  factory Comida.fromJson(Map<String, dynamic> json) {
    // Procesar ingredientes - extraer solo los que no están vacíos
    List<String> ingredients = [];
    List<String> measures = [];
    
    for (int i = 1; i <= 20; i++) {
      String? ingredient = json['strIngredient$i'];
      String? measure = json['strMeasure$i'];
      
      if (ingredient != null && ingredient.isNotEmpty && ingredient.trim().isNotEmpty) {
        ingredients.add(ingredient);
        measures.add(measure ?? '');
      }
    }

    return Comida(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealAlternate: json['strMealAlternate'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strInstructions: json['strInstructions'],
      strMealThumb: json['strMealThumb'],
      strTags: json['strTags'],
      strYoutube: json['strYoutube'],
      ingredients: ingredients,
      measures: measures,
    );
  }
}

/// Modelo para representar la respuesta completa de la API
class ComidaResponse {
  List<Comida>? meals;

  ComidaResponse({this.meals});

  factory ComidaResponse.fromJson(Map<String, dynamic> json) {
    return ComidaResponse(
      meals: json['meals'] != null
          ? List<Comida>.from(json['meals'].map((meal) => Comida.fromJson(meal)))
          : null,
    );
  }
}