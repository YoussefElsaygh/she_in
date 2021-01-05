class FormStatus {
  bool isLoading;
  bool success;
  bool fail;

  FormStatus({this.isLoading = false, this.fail = false, this.success = false});

  factory FormStatus.loading() => FormStatus(isLoading: true, fail: false, success: false);

  factory FormStatus.initial() => FormStatus(isLoading: false, fail: false, success: false);

  factory FormStatus.succeeded() => FormStatus(isLoading: false, fail: false, success: true);

  factory FormStatus.failed() => FormStatus(isLoading: false, fail: true, success: false);

  bool operator ==(o) => o.isLoading == isLoading && o.success == success && o.fail == fail;

  @override
  int get hashCode => super.hashCode;

}
