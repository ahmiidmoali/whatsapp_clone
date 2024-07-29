import 'package:whatsapp_clone/features/user/data/data_sources/remote/user_remote_data_source.dart';
import 'package:whatsapp_clone/features/user/domain/entities/contact_entity.dart';
import 'package:whatsapp_clone/features/user/domain/entities/user_entitiy.dart';
import 'package:whatsapp_clone/features/user/domain/repository/user_repository.dart';

class UserRepositoryImp extends UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImp({required this.remoteDataSource});
  @override
  Future<void> createUser(UserEntity user) => remoteDataSource.createUser(user);

  @override
  Stream<List<UserEntity>> getAllUsers() => remoteDataSource.getAllUsers();

  @override
  Future<String> getCurrentUID() => remoteDataSource.getCurrentUID();

  @override
  Future<List<ContactEntity>> getDeviceNumber() =>
      remoteDataSource.getDeviceNumber();

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) =>
      remoteDataSource.getSingleUser(uid);

  @override
  Future<bool> isSignIn() => remoteDataSource.isSignIn();

  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) =>
      remoteDataSource.signInWithPhoneNumber(smsPinCode);

  @override
  Future<void> signOut() => remoteDataSource.signOut();

  @override
  Future<void> updateUser(UserEntity user) => remoteDataSource.updateUser(user);

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) =>
      remoteDataSource.verifyPhoneNumber(phoneNumber);
}
