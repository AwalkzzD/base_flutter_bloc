abstract class BaseDataSource<K> {
  Future getData<T>(K request);
}
