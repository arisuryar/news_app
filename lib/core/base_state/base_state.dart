enum StatusState { initial, loading, failed, loaded }

class BaseState<T> {
  StatusState state;
  T? data;
  dynamic message;

  BaseState({
    this.state = StatusState.initial,
    this.data,
    this.message,
  });

  BaseState<T> copyWith({
    StatusState? state,
    T? data,
    dynamic message,
  }) {
    return BaseState<T>(
      state: state ?? this.state,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }
}
