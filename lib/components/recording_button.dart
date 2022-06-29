import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/camera_use/camera_use_bloc.dart';

class RecordingButton extends StatelessWidget {
  const RecordingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraUseBloc, CameraUseState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // !state.isRecording
            //     ? IconButton(
            //         onPressed: () {
            //           context.read<CameraUseBloc>().add(StartCaptureEvent());
            //           print('state from button ${state.isRecording}');
            //         },
            //         icon: Icon(Icons.circle),
            //       )
            //     : IconButton(
            //         icon: Icon(Icons.square),
            //         onPressed: () {
            //           context.read<CameraUseBloc>().add(StopCaptureEvent());
            //           print(state.isRecording);
            //         },
            //       ),
            IconButton(
              iconSize: 100,
              color: Color.fromARGB(255, 226, 109, 101),
              onPressed: () {
                context.read<CameraUseBloc>().add(StartCaptureEvent());
                print('state from button ${state.isRecording}');
              },
              icon: Icon(Icons.circle_outlined),
            ),
            IconButton(
              iconSize: 100,
              color: Color.fromARGB(255, 226, 109, 101),
              icon: Icon(Icons.square_rounded),
              onPressed: () {
                context.read<CameraUseBloc>().add(StopCaptureEvent());
                print(state.isRecording);
              },
            ),
          ],
        );
      },
    );
  }
}
