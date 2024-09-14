import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyectoagro/models/maquinaria.dart';

// Estados del Cubit
abstract class MaquinariaState {}

class MaquinariaInitial extends MaquinariaState {}

class MaquinariaLoading extends MaquinariaState {}

class MaquinariaLoaded extends MaquinariaState {
  final List<Maquinaria> maquinarias;
  final int total;

  MaquinariaLoaded({required this.maquinarias, required this.total});
}

class MaquinariaEmpty extends MaquinariaState {}

class MaquinariaError extends MaquinariaState {}

class MaquinariaCubit extends Cubit<MaquinariaState> {
  MaquinariaCubit() : super(MaquinariaInitial());

  Future<void> fetchMaquinarias(int page, int pageSize,
      {String search = ''}) async {
    emit(MaquinariaLoading());
    final url =
        Uri.parse('https://controller.agrochofa.cl/api/sgm/maquinarias/public');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body:
            jsonEncode({'page': page, 'pageSize': pageSize, 'search': search}),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        final maquinariasResponse = MaquinariasResponse.fromJson(jsonData);

        if (maquinariasResponse.data.isEmpty) {
          emit(MaquinariaEmpty());
        } else {
          emit(MaquinariaLoaded(
            maquinarias: maquinariasResponse.data,
            total: maquinariasResponse.total,
          ));
        }
      } else {
        emit(MaquinariaError());
      }
    } catch (e) {
      print("Error fetching data: $e");
      emit(MaquinariaError());
    }
  }

  void deleteMaquinaria(String id) {
    if (state is MaquinariaLoaded) {
      final currentState = state as MaquinariaLoaded;
      final updatedList =
          currentState.maquinarias.where((item) => item.id != id).toList();
      emit(MaquinariaLoaded(
          maquinarias: updatedList, total: updatedList.length));
    }
  }
}
