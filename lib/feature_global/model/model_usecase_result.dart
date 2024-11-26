class ModelUseCaseResult<T> {
  T? result;

  String? errorMessage;

  ModelUseCaseResult(this.result, this.errorMessage);
}