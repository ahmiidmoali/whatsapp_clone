part of 'get_single_user_cubit.dart';

sealed class GetSingleUserState extends Equatable {
  const GetSingleUserState();

  @override
  List<Object> get props => [];
}

final class GetSingleUserInitial extends GetSingleUserState {
  @override
  List<Object> get props => [];
}

class GetSingleUserLoading extends GetSingleUserState {
  @override
  List<Object> get props => [];
}

class GetSingleUserLoaded extends GetSingleUserState {
  final UserEntity singleUser;
  const GetSingleUserLoaded({required this.singleUser});
  @override
  List<Object> get props => [singleUser];
}

class GetSingleUserFailed extends GetSingleUserState {
  @override
  List<Object> get props => [];
}