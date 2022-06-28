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
      if (state.showImage) {
        var responsesecond = await thetaService.command({
          'name': 'camera.listFiles',
          'parameters': {
            'fileType': 'image',
            'startPosition': 0,
            'entryCount': 1,
            'maxThumbSize': 0
          }
        });
        var convertResponse = jsonDecode(responsesecond.bodyString);
        var fileUrl = convertResponse['results']['entries'][0]['fileUrl'];
        emit(CameraUseState(
            message: response.bodyString,
            captureMode: captureMode,
            fileUrl: fileUrl,
            showImage: true));
      } else {
        emit(CameraUseState(
            message: response.bodyString,
            captureMode: captureMode,
            showImage: false));
      }

      print(captureMode);
      // TODO: implement event handler
    });
    on<TakePicEvent>((event, emit) async {
      var response = await thetaService.command({
        'name': 'camera.takePicture',
      });
      emit(CameraUseState(message: response.bodyString, showImage: false));
    });

    on<StartCaptureEvent>((event, emit) async {
      emit(CameraUseState(message: '', isRecording: true, showImage: false));
      var response =
          await thetaService.command({'name': 'camera.startCapture'});
      emit(CameraUseState(
          message: response.bodyString, isRecording: true, showImage: false));
      print("State from bloc ${state.isRecording}");
      print(response.bodyString);
    });
    on<StopCaptureEvent>((event, emit) async {
      emit(CameraUseState(message: '', isRecording: false, showImage: false));
      var response = await thetaService.command({'name': 'camera.stopCapture'});
      emit(CameraUseState(
          message: response.bodyString, isRecording: false, showImage: false));
      print(response.bodyString);
    });
    on<GetPictureEvent>((event, emit) async {
      var response = await thetaService.command({
        'name': 'camera.listFiles',
        'parameters': {
          'fileType': 'image',
          'startPosition': 0,
          'entryCount': 1,
          'maxThumbSize': 0
        }
      });
      var convertResponse = jsonDecode(response.bodyString);
      var fileUrl = convertResponse['results']['entries'][0]['fileUrl'];
      emit(CameraUseState(message: '', showImage: true, fileUrl: fileUrl));
      print(fileUrl);
      print('${state.showImage} bloc');
    });
  }
}
