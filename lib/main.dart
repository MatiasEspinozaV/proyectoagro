import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectoagro/bloc/BlocBuilder.dart';
import 'package:proyectoagro/bloc/maquinaria_cb.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prueba Maquinarias',
      home: BlocProvider(
        create: (context) => MaquinariaCubit(),
        child: MaquinariaPage(),
      ),
    );
  }
}