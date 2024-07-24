import 'package:base_flutter_bloc/base/network/api_client/base_client.dart';
import 'package:base_flutter_bloc/base/network/repository/base_repository.dart';
import 'package:flutter/foundation.dart';

abstract class RemoteRepository extends BaseRepository {
  RemoteRepository(BaseClient super.remoteDataSource);

  @override
  @protected
  BaseClient get dataSource => super.dataSource as BaseClient;
}
