import 'package:equatable/equatable.dart';

class BaseEquatable extends Equatable {
  @override
  List<Object?> get props => [];

  @override
  // ignore: no_runtimetype_tostring
  String toString() => runtimeType.toString();
}