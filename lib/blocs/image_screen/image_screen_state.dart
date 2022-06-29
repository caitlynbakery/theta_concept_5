// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'image_screen_bloc.dart';

class ImageScreenState extends Equatable {
  final String message;

  final bool showImage;
  final String fileUrl;

  const ImageScreenState({
    required this.message,
    required this.showImage,
    this.fileUrl = "",
  });

  factory ImageScreenState.initial() =>
      ImageScreenState(message: "", showImage: false);

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;

  ImageScreenState copyWith({
    String? message,
    bool? showImage,
    String? fileUrl,
  }) {
    return ImageScreenState(
      message: message ?? this.message,
      showImage: showImage ?? this.showImage,
      fileUrl: fileUrl ?? this.fileUrl,
    );
  }
}
