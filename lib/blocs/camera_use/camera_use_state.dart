part of 'camera_use_bloc.dart';

class CameraUseState extends Equatable {
  final String message;
  final String captureMode;
  final bool isRecording;
  final bool showImage;
  final String fileUrl;

  const CameraUseState(
      {required this.message,
      this.captureMode = "none",
      this.isRecording = false,
      required this.showImage,
      this.fileUrl = ""});

  factory CameraUseState.initial() =>
      const CameraUseState(message: 'initial', showImage: false);
  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;

  CameraUseState copyWith({
    String? message,
  }) {
    return CameraUseState(
        message: message ?? this.message, showImage: showImage);
  }
}
