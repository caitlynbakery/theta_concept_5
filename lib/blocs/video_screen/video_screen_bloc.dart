import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';

import '../../services/theta_service.dart';

part 'video_screen_event.dart';
part 'video_screen_state.dart';

class VideoScreenBloc extends Bloc<VideoScreenEvent, VideoScreenState> {
  VideoScreenBloc() : super(VideoScreenState.initial()) {
    var chopper = ChopperClient(
        services: [ThetaService.create()], converter: const JsonConverter());
    final thetaService = chopper.getService<ThetaService>();
    on<StartCaptureEvent>((event, emit) async {
      emit(VideoScreenState(
        message: '',
        isRecording: true,
      ));
      var response =
          await thetaService.command({'name': 'camera.startCapture'});
      emit(VideoScreenState(
        message: response.bodyString,
        isRecording: true,
      ));
      print("State from bloc ${state.isRecording}");
      print(response.bodyString);
    });
    on<StopCaptureEvent>((event, emit) async {
      emit(VideoScreenState(
        message: '',
        isRecording: false,
      ));
      var response = await thetaService.command({'name': 'camera.stopCapture'});
      emit(VideoScreenState(
        message: response.bodyString,
        isRecording: false,
      ));
      print(response.bodyString);
    });
  }
}
