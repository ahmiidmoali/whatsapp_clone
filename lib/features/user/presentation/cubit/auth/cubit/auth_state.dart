// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final String uid;
  const Authenticated({
    required this.uid,
  });
  @override
  List<Object> get props => [uid];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object> get props => [0];
}
