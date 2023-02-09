import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_pizza/bloc/pizza_bloc.dart';

import 'models/pizza_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );

    // Takes the bloc and trigger the initial which trigger the loaded state
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PizzaBloc()..add(LoadPizzaCounter()),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Pizza',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen(),
        ));
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Pizza'),
          centerTitle: true,
          backgroundColor: Colors.purple[800],
        ),
        body: Center(child:
            BlocBuilder<PizzaBloc, PizzaState>(builder: (context, state) {
          if (state is PizzaInitial) {
            return const CircularProgressIndicator();
          }
          if (state is PizzaLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${state.pizzas.length}',
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          for (int index = 0;
                              index < state.pizzas.length;
                              index++)
                            Positioned(
                                left: Random.secure().nextInt(250).toDouble(),
                                top: Random.secure().nextInt(250).toDouble(),
                                child: SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: state.pizzas[index].image,
                                ))
                        ]))
              ],
            );
          } else {
            return const Text('Error');
          }
        },
        )),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                context.read<PizzaBloc>().add(AddPizza(pizza: Pizza.pizzas[0]));
              },
              backgroundColor: Colors.purple[800],
              child: const Icon(Icons.local_pizza),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () {
                BlocProvider.of<PizzaBloc>(context).add(RemovePizza(pizza: Pizza.pizzas[0]));
              },
              backgroundColor: Colors.purple[800],
              child: const Icon(Icons.remove),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () {
                context.read<PizzaBloc>().add(AddPizza(pizza: Pizza.pizzas[1]));
              },
              backgroundColor: Colors.purple[800],
              child: const Icon(Icons.local_pizza_outlined),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () {
                BlocProvider.of<PizzaBloc>(context).add(RemovePizza(pizza: Pizza.pizzas[1]));
              },
              backgroundColor: Colors.purple[800],
              child: const Icon(Icons.remove),
            ),
          ]
        ),);
  }
}
