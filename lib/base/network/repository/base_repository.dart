import 'package:base_flutter_bloc/base/network/data_source/base_data_source.dart';
import 'package:flutter/foundation.dart';

abstract class BaseRepository {
  @protected
  final BaseDataSource dataSource;

  BaseRepository(this.dataSource);
}
