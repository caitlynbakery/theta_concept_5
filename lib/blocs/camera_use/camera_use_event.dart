part of 'camera_use_bloc.dart';

abstract class CameraUseEvent extends Equatable {
  const CameraUseEvent();

  @override
  List<Object> get props => [];
}

class GetModeEvent extends CameraUseEvent {}

class StartCaptureEvent extends CameraUseEvent {}

class StopCaptureEvent extends CameraUseEvent {}
