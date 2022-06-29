import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/camera_use/camera_use_bloc.dart';
import '../components/image_response.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({
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
                    // captureMode = state.captureMode;
                  },
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    iconSize: 200,
                    onPressed: () {
                      context.read<CameraUseBloc>().add(TakePicEvent());
                    },
                    icon: Icon(
                      Icons.circle_outlined,
                    )),
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      context.read<CameraUseBloc>().add(GetPictureEvent());
                      print('image screen ${state.showImage}');
                    },
                    icon: Icon(Icons.image))
              ],
            ),
            ImageResponse(),
          ]),
        );
      },
    );
  }
}
