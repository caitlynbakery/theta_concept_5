import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/image_use/camera_use_bloc.dart';

class ImageResponse extends StatelessWidget {
  const ImageResponse({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraUseBloc, CameraUseState>(
      builder: (context, state) {
        return Expanded(
            child: context.watch<CameraUseBloc>().state.showImage &&
                    context.watch<CameraUseBloc>().state.fileUrl.isNotEmpty
                ? InkWell(
                    child: Image.network('${state.fileUrl}?type=thumb'),
                  )
                : Text('response goes here '));
      },
    );
  }
}