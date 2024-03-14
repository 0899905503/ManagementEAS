 

// final authRepositoryProvider = Provider((ref) => AuthRepositoryImpl(ref.read));

// class AuthRepositoryImpl implements AuthRepository {
//   AuthRepositoryImpl(this._reader);

//   final Reader _reader;

//   late final AuthDataSource _dataSource = _reader(authDataSourceProvider);

//   @override
//   Future<Result<AppUser>> signIn() {
//     return Result.guardFuture(
//         () async => AppUser.from(await _dataSource.signIn()));
//   }

//   @override
//   Future<Result<void>> signOut() {
//     return Result.guardFuture(_dataSource.signOut);
//   }
// }
