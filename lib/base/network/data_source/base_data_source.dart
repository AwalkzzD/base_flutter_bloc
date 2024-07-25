abstract class BaseDataSource<K> {
  Future makeRequest<T>(K request);
}
