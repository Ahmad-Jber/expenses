class LoadedModel<T> {
  late bool isLoading=true;
  T response;
  LoadedModel(this.isLoading, {required this.response});
}