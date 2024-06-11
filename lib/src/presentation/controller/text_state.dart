enum TextStatus { initial, success, error }

class TextState {
  final TextStatus status;
  String? strData;

  TextState({this.status = TextStatus.initial, this.strData});

  TextState copyWith({TextStatus? status, String? strData}) {
    return TextState(
        status: status ?? this.status, strData: strData ?? this.strData);
  }
}
