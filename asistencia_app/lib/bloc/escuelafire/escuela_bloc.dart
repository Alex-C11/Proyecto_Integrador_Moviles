import 'dart:async';
import 'package:asistencia_app/modelo/EscuelaModeloFire.dart';
import 'package:asistencia_app/repository/EscuelaFireRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'escuela_event.dart';
part 'escuela_state.dart';

class EscuelaBlocFire extends Bloc<EscuelaEvent, EscuelaState> {

  late final EscuelaFireRepository _escuelaRepository;

  EscuelaBlocFire(this._escuelaRepository) : super(EscuelaInitialState()) {
    on<EscuelaEvent>((event, emit) async{
      // TODO: implement event handler
      if(event is ListarEscuelaEvent){
        emit(EscuelaLoadingState());
        try{
          List<EscuelaModeloFire> escuelaList=await _escuelaRepository.getEscuela();
          emit(EscuelaLoadedState(escuelaList));
        } catch(e){
          emit(EscuelaError(e as Error));
        }
      }else if(event is CreateEscuelaEvent){
        try{
          await _escuelaRepository.crearEscuela(event.escuela);
          emit(EscuelaLoadingState());
          List<EscuelaModeloFire> escuelaList=await _escuelaRepository.getEscuela();
          emit(EscuelaLoadedState(escuelaList));
        } catch(e){
          emit(EscuelaError(e as Error));
        }
      }else if(event is UpdateEscuelaEvent){
        try{
          await _escuelaRepository.actualizarEscuela(event.escuela.id, event.escuela);
          emit(EscuelaLoadingState());
          List<EscuelaModeloFire> escuelaList=await _escuelaRepository.getEscuela();
          emit(EscuelaLoadedState(escuelaList));
        } catch(e){
          emit(EscuelaError(e as Error));
        }
      }else if(event is DeleteEscuelaEvent){
        try{
          await _escuelaRepository.eliminarEscuela(event.escuela.id);
          emit(EscuelaLoadingState());
          List<EscuelaModeloFire> escuelaList=await _escuelaRepository.getEscuela();
          emit(EscuelaLoadedState(escuelaList));
        } catch(e){
          emit(EscuelaError(e as Error));
        }
      }
    });
  }
}
