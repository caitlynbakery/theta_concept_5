import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';

import '../../services/theta_service.dart';

part 'camera_use_event.dart';
part 'camera_use_state.dart';

class CameraUseBloc extends Bloc<CameraUseEvent, CameraUseState> {
  CameraUseBloc() : super(CameraUseState.initial()) {
    var chopper = ChopperClient(
        services: [ThetaService.create()], converter: const JsonConverter());
    final thetaService = chopper.getService<ThetaService>();
    on<GetModeEvent>((event, emit) async {
      var response = await thetaService.command({
        'name': 'camera.getOptions',
        'parameters': {
          'optionNames': ['captureMode']
        }
      });
      var convertResponse = jsonDecode(response.bodyString);
      var captureMode = convertResponse['results']['options']['captureMode'];
      emit(CameraUseState(
        message: response.bodyString,
        captureMode: captureMode,
      ));
      print(captureMode);
      // TODO: implement event handler
    });

    on<StartCaptureEvent>((event, emit) async {
      emit(CameraUseState(
        message: '',
        isRecording: true,
      ));
      var response =
          await thetaService.command({'name': 'camera.startCapture'});
      emit(CameraUseState(
        message: response.bodyString,
        isRecording: true,
      ));
      print("State from bloc ${state.isRecording}");
      print(response.bodyString);
    });
    on<StopCaptureEvent>((event, emit) async {
      emit(CameraUseState(
        message: '',
        isRecording: false,
      ));
      var response = await thetaService.command({'name': 'camera.stopCapture'});
      emit(CameraUseState(
        message: response.bodyString,
        isRecording: false,
      ));
      print(response.bodyString);
    });
  }
}
