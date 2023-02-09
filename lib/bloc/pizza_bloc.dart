import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/pizza_model.dart';

part 'pizza_state.dart';
part 'pizza_event.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  PizzaBloc() : super(PizzaInitial()){

    // When the app starts it triggers PizzaInitial
    // and then it triggers the LoadPizzaCounter event
    // which triggers the PizzaLoading state
      on<LoadPizzaCounter>((event, emit) async {
        await Future<void>.delayed(const Duration(seconds: 1));
        emit(PizzaLoaded(pizzas: Pizza.pizzas));
      });

      // It takes the pizza state from loaded, adds the new pizza
      // and then it triggers the PizzaLoaded state
      on<AddPizza>((event, emit) {
        if(state is PizzaLoaded) {
          final state = this.state as PizzaLoaded;
          emit(PizzaLoaded(pizzas: [...state.pizzas, event.pizza]));
        }
      });
      // Takes the prev list from loaded, removes the pizza and returns it
      on<RemovePizza>((event, emit) {
        if(state is PizzaLoaded) {
          final state = this.state as PizzaLoaded;
          emit(PizzaLoaded(pizzas: List.from(state.pizzas)..remove(event.pizza)));
        }
      });
  }
}