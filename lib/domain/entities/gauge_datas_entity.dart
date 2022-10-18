import 'package:equatable/equatable.dart';

class GaugeDatasEntity extends Equatable {
  final List<Map<String, dynamic>> data;
  final String legende;
  final int goodAnswers;
  final int badAnswers;

  const GaugeDatasEntity({
    required this.data,
    required this.legende,
    required this.goodAnswers,
    required this.badAnswers,
  });

  @override
  List<Object?> get props => [data, legende, goodAnswers, badAnswers];
}
