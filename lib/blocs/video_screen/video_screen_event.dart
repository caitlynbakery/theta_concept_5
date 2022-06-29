part of 'video_screen_bloc.dart';

abstract class VideoScreenEvent extends Equatable {
  const VideoScreenEvent();

  @override
  List<Object> get props => [];
}

class StartCaptureEvent extends VideoScreenEvent {}

class StopCaptureEvent extends VideoScreenEvent {}
