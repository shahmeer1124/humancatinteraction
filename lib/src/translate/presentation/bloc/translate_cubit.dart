import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'translate_state.dart';

class TranslateCubit extends Cubit<TranslateState> {
  TranslateCubit()
      : super(const TranslateState(state: TranslateStates.initial));

  void startListening() {
    emit(const TranslateState(state: TranslateStates.listening));
  }

  void stopListening() {
    emit(const TranslateState(state: TranslateStates.stop));
  }
}
