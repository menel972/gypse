/// Represents the possible states of the login process.
enum LoginState {
  /// The initial state before any action is taken.
  uninitialized,

  /// The state when the login process is in progress.
  loading,

  /// The state when the user is not authenticated.
  unauthenticated,

  /// The state when the user is authenticated.
  authenticated,
}

/// Represents the state status of an operation.
enum StateStatus {
  /// The initial state.
  initial,

  /// The state when the operation is reloading.
  reloading,

  /// The state when the operation is paused.
  pause,

  /// The state when the operation is resumed.
  resume,

  /// The state when the operation times out.
  timeOut,

  /// The state when the operation is loading.
  loading,

  /// The state when the operation is partially loading.
  partialLoading,

  /// The state when the operation is finished.
  finish,

  /// The state when the operation is successful.
  success,

  /// The state when the operation encounters an error.
  error,
}
