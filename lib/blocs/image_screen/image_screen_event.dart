part of 'image_screen_bloc.dart';

abstract class ImageScreenEvent extends Equatable {
  const ImageScreenEvent();

  @override
  List<Object> get props => [];
}

class ImageTakePicEvent extends ImageScreenEvent {}

class ImageGetPictureEvent extends ImageScreenEvent {}
