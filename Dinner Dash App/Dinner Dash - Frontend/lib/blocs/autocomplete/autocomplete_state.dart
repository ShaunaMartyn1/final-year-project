part of 'autocomplete_bloc.dart';

abstract class AutocompleteState extends Equatable {
  const AutocompleteState();
  
  @override
  List<Object> get props => [];
}

final class AutocompleteLoading extends AutocompleteState {}

final class AutocompleteLoaded extends AutocompleteState {
  final List<PlaceAutocomplete> autocomplete;

  const AutocompleteLoaded({required this.autocomplete});

  @override
  List<Object> get props => [autocomplete];
}

final class AutocompleteError extends AutocompleteState {

  final String message;

  const AutocompleteError(this.message);

  @override
  List<Object> get props => [message];
}

