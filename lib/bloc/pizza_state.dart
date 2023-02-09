part of 'pizza_bloc.dart';


abstract class PizzaState extends Equatable {
  const PizzaState();

  @override
  List<Object> get props => [];
}

// Literately the same as the initial state
class PizzaInitial extends PizzaState {}

// To display the pizzas in the UI
class PizzaLoaded extends PizzaState {
  final List<Pizza> pizzas;
  const PizzaLoaded({required this.pizzas});
  @override
  List<Object> get props => [pizzas];
}
