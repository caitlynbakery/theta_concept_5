import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'camera_state_event.dart';
part 'camera_state_state.dart';

class CameraStateBloc extends Bloc<CameraStateEvent, CameraStateState> {
  CameraStateBloc() : super(CameraStateInitial()) {
    on<CameraStateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
