part of 'camera_use_bloc.dart';

class CameraUseState extends Equatable {
  final String message;
  final String captureMode;
  final bool isRecording;

  const CameraUseState({
    required this.message,
    this.captureMode = "none",
    this.isRecording = false,
  });

  factory CameraUseState.initial() => const CameraUseState(
        message: 'initial',
      );
  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;

  CameraUseState copyWith({
    String? message,
  }) {
    return CameraUseState(
      message: message ?? this.message,
    );
  }
}
