import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Tag extends Equatable {
  const Tag({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}
