import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theta_concept_5/blocs/camera_use/camera_use_bloc.dart';

import '../components/recording_button.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraUseBloc, CameraUseState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<CameraUseBloc>().add(GetModeEvent());
                    //  captureMode = state.captureMode;
                  },
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
            RecordingButton()
          ]),
        );
      },
    );
  }
}
