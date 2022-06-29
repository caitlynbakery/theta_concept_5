import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theta_concept_5/blocs/image_screen/image_screen_bloc.dart';
import 'package:theta_concept_5/blocs/video_screen/video_screen_bloc.dart';
import 'package:theta_concept_5/screens/image_screen.dart';
import 'package:theta_concept_5/screens/refresh_screen.dart';
import 'package:theta_concept_5/screens/video_screen.dart';

import 'blocs/camera_use/camera_use_bloc.dart';
import 'components/recording_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CameraUseBloc>(
            create: (BuildContext context) => CameraUseBloc()),
        BlocProvider(create: (BuildContext context) => ImageScreenBloc()),
        BlocProvider(create: (BuildContext context) => VideoScreenBloc())
      ],
      child: MaterialApp(
        home: BlocBuilder<CameraUseBloc, CameraUseState>(
          builder: (context, state) {
            context.read<CameraUseBloc>().add(GetModeEvent());

            if (state.captureMode == 'image') {
              return const ImageScreen();
            } else if (state.captureMode == 'video') {
              return const VideoScreen();
            } else {
              return const RefreshScreen();
            }
          },
        ),
      ),
    );
  }
}
