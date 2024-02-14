import 'package:equatable/equatable.dart';

class LocalNotification extends Equatable {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  const LocalNotification({
    required this.id,
    required this.title,
    this.body = '',
    this.payload = '',
  });

  @override
  List<Object?> get props => [id, title, body, payload];
}
