import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theta_concept_5/blocs/video_screen/video_screen_bloc.dart';

import '../blocs/camera_use/camera_use_bloc.dart';

class RecordingButton extends StatelessWidget {
  const RecordingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoScreenBloc, VideoScreenState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            !state.isRecording
                ? IconButton(
                    iconSize: 100,
                    color: Color.fromARGB(255, 226, 109, 101),
                    onPressed: () {
                      context.read<VideoScreenBloc>().add(StartCaptureEvent());
                      print('state from button ${state.isRecording}');
                    },
                    icon: Icon(Icons.circle),
                  )
                : IconButton(
                    iconSize: 100,
                    color: Color.fromARGB(255, 226, 109, 101),
                    icon: Icon(Icons.square),
                    onPressed: () {
                      context.read<VideoScreenBloc>().add(StopCaptureEvent());
                      print(state.isRecording);
                    },
                  ),
          ],
        );
      },
    );
  }
}
