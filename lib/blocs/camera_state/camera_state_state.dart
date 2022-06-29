// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'camera_state_bloc.dart';

class CameraStateState extends Equatable {
  final bool isRecording;

  const CameraStateState({
    required this.isRecording,
  });

  factory CameraStateState.initial() => CameraStateState(isRecording: false);

  @override
  List<Object> get props => [isRecording];

  CameraStateState copyWith({
    bool? isRecording,
  }) {
    return CameraStateState(
      isRecording: isRecording ?? this.isRecording,
    );
  }

  @override
  bool get stringify => true;
}
