class SceneState {
  double width;
  double height;
  SceneState({required this.width, required this.height});

  SceneState copyWith({double? width, double? height}) {
    return SceneState(
        width: width ?? this.width, height: height ?? this.height);
  }
}
