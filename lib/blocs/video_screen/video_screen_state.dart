part of 'video_screen_bloc.dart';

class VideoScreenState extends Equatable {
  final bool isRecording;
  final String message;
  const VideoScreenState({
    required this.message,
    required this.isRecording,
  });

  factory VideoScreenState.initial() =>
      VideoScreenState(message: '', isRecording: false);
  @override
  List<Object> get props => [isRecording, message];

  VideoScreenState copyWith({
    bool? isRecording,
    String? message,
  }) {
    return VideoScreenState(
      isRecording: isRecording ?? this.isRecording,
      message: message ?? this.message,
    );
  }

  @override
  bool get stringify => true;
}
