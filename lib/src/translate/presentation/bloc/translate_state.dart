part of 'translate_cubit.dart';

enum TranslateStates { initial, listening, stop }

class TranslateState extends Equatable {
  const TranslateState({required this.state});
  final TranslateStates state;
  @override
  List<Object?> get props => [state];
}
