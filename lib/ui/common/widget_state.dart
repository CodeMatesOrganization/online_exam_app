import 'package:equatable/equatable.dart';

sealed class ComponentState<T> {}

class Loading<T> extends ComponentState<T> with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class ComponentError<T> extends ComponentState<T> with EquatableMixin {
  final Object? error;
  ComponentError(this.error);

  @override
  List<Object?> get props => [error];
}

class Loaded<T> extends ComponentState<T> with EquatableMixin {
  final T? data;
  Loaded(this.data);

  @override
  List<Object?> get props => [data];
}

class Idle<T> extends ComponentState<T> with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class Disabled<T> extends ComponentState<T> with EquatableMixin {
  @override
  List<Object?> get props => [];
}