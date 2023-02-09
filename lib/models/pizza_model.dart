
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Pizza extends Equatable{
    final String id;
    final String name;
    final Image image;

    const Pizza({ required this.id, required this.name, required this.image});

    @override
    List<Object> get props => [id, name, image];

    static List<Pizza> pizzas = [
      Pizza(
        id: '0',
        name: 'Pepperoni',
        image: Image.asset('assets/images/pepperoni.png')
      ),
      Pizza(
        id: '1',
        name: 'Supreme',
        image: Image.asset('assets/images/supreme.png')
      ),
    ];
}