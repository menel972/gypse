///## Gypse custom [Exception]
///
///```
///final String? code;
///final String? message;
///```
class GypseException implements Exception {
  final String? code;
  final String? message;

  ///### Gypse custom [Exception]
  ///#### `GypseException` constructor
  GypseException({this.code, this.message});
}
