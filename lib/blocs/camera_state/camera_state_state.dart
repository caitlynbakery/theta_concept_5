part of 'camera_state_bloc.dart';

abstract class CameraStateState extends Equatable {
  const CameraStateState();
  
  @override
  List<Object> get props => [];
}

class CameraStateInitial extends CameraStateState {}
