import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';
import 'package:theta_concept_5/blocs/camera_use/camera_use_bloc.dart';

import '../../services/theta_service.dart';

part 'image_screen_event.dart';
part 'image_screen_state.dart';

class ImageScreenBloc extends Bloc<ImageScreenEvent, ImageScreenState> {
  ImageScreenBloc() : super(ImageScreenState.initial()) {
    var chopper = ChopperClient(
        services: [ThetaService.create()], converter: const JsonConverter());
    final thetaService = chopper.getService<ThetaService>();
    on<ImageTakePicEvent>((event, emit) async {
      var response = await thetaService.command({
        'name': 'camera.takePicture',
      });
      emit(ImageScreenState(message: response.bodyString, showImage: false));
    });
    on<ImageGetPictureEvent>((event, emit) async {
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
      emit(ImageScreenState(message: '', showImage: true, fileUrl: fileUrl));
      print(fileUrl);
      print('${state.showImage} bloc');
    });
  }
}
