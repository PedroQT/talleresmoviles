import 'package:go_router/go_router.dart';
import 'package:parqueadero_2025_g2/views/categoria_fb/categoria_fb_form_view.dart';
import 'package:parqueadero_2025_g2/views/categoria_fb/categoria_fb_list_view.dart';
import 'package:parqueadero_2025_g2/views/ciclo_vida/ciclo_vida_screen.dart';
import 'package:parqueadero_2025_g2/views/paso_parametros/detalle_screen.dart';
import 'package:parqueadero_2025_g2/views/paso_parametros/paso_parametros_screen.dart';

import '../views/comidas/comidas_detail_view.dart';
import '../views/comidas/comidas_list_view.dart';
import '../views/future/future_view.dart';
import '../views/home/home_screen.dart';
import '../views/isolate/isolate_view.dart';
import '../views/pokemons/pokemon_detail_view.dart';
import '../views/pokemons/pokemon_list_view.dart';
import '../views/evidence/evidence_view.dart';
import '../views/login/login_view.dart';
import '../views/login/register_view.dart';
import '../views/universidades/universidades_list_view.dart';
import '../views/universidades/universidad_form_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(), // Usa HomeView
    ),
    // Rutas para el paso de parámetros
    GoRoute(
      path: '/paso_parametros',
      name: 'paso_parametros',
      builder: (context, state) => const PasoParametrosScreen(),
    ),

    // !Ruta para el detalle con parámetros
    GoRoute(
      path:
          '/detalle/:parametro/:metodo', //la ruta recibe dos parametros los " : " indican que son parametros
      builder: (context, state) {
        //*se capturan los parametros recibidos
        // declarando las variables parametro y metodo
        // es final porque no se van a modificar
        final parametro = state.pathParameters['parametro']!;
        final metodo = state.pathParameters['metodo']!;
        return DetalleScreen(parametro: parametro, metodoNavegacion: metodo);
      },
    ),
    //!Ruta para el ciclo de vida
    GoRoute(
      path: '/ciclo_vida',
      builder: (context, state) => const CicloVidaScreen(),
    ),
    //!Ruta para FUTURE
    GoRoute(
      path: '/future',
      name: 'future',
      builder: (context, state) => const FutureView(),
    ),
    //!Ruta para ISOLATE
    GoRoute(
      path: '/isolate',
      name: 'isolate',
      builder: (context, state) => const IsolateView(),
    ),
    //!Ruta para POKEMON
    GoRoute(
      path: '/pokemon',
      name: 'pokemon',
      builder: (context, state) => const PokemonListView(),
    ),
    //!Ruta para detalle de pokemones
    GoRoute(
      path: '/pokemon/:name', // se recibe el nombre del pokemon como parametro
      name: 'pokemon_detail',
      builder: (context, state) {
        final name =
            state.pathParameters['name']!; // se captura el nombre del pokemon.
        return PokemonDetailView(name: name);
      },
    ),
    //!Ruta para COMIDAS
    GoRoute(
      path: '/comidas',
      name: 'comidas',
      builder: (context, state) => const ComidasListView(),
    ),
    //!Ruta para detalle de comidas
    GoRoute(
      path: '/comida/:idMeal', // se recibe el id de la comida como parametro
      name: 'comida_detail',
      builder: (context, state) {
        final idMeal =
            state.pathParameters['idMeal']!; // se captura el id de la comida.
        return ComidasDetailView(idMeal: idMeal);
      },
    ),
    // Ruta para evidencia de sesión
    GoRoute(
      path: '/evidence',
      name: 'evidence',
      builder: (context, state) => const EvidenceView(),
    ),
    // Ruta para login
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginView(),
    ),
    // Ruta para registro
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(
    path: '/categoriasFirebase',
    name: 'categoriasFirebase',
    builder: (_, __) => const CategoriaFbListView(),
    ),
    GoRoute(
    path: '/categoriasfb/create',
    name: 'categoriasfb.create',
    builder: (context, state) => const CategoriaFbFormView(),
    ),
    GoRoute(
    path: '/categoriasfb/edit/:id',
    name: 'categorias.edit',
    builder: (context, state) {
    final id = state.pathParameters['id']!;
    return CategoriaFbFormView(id: id);
    },
    ),
    // Rutas para Universidades
    GoRoute(
      path: '/universidades',
      name: 'universidades',
      builder: (context, state) => const UniversidadesListView(),
    ),
    GoRoute(
      path: '/universidades/create',
      name: 'universidades.create',
      builder: (context, state) => const UniversidadFormView(),
    ),
    GoRoute(
      path: '/universidades/edit/:id',
      name: 'universidades.edit',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return UniversidadFormView(id: id);
      },
    ),
  ],
);
