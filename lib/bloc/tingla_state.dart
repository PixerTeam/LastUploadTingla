abstract class TinglaState {
  const TinglaState();
}

class TinglaLoading extends TinglaState {
  const TinglaLoading();
}

class TinglaCompleted extends TinglaState {
  final response;
  const TinglaCompleted({this.response});
}

class TinglaError extends TinglaState {
  final String message;
  const TinglaError(this.message);
}
