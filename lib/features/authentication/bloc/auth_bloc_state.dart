part of 'auth_bloc_bloc.dart';

abstract class AuthBlocState extends Equatable {
  const AuthBlocState();
  
  @override
  List<Object> get props => [];
}

class AuthBlocInitial extends AuthBlocState {}
