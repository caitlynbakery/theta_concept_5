import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theta_concept_5/blocs/image_screen/image_screen_bloc.dart';

import '../blocs/camera_use/camera_use_bloc.dart';

class ImageResponse extends StatelessWidget {
  const ImageResponse({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageScreenBloc, ImageScreenState>(
      builder: (context, state) {
        return Expanded(
            child: context.watch<ImageScreenBloc>().state.showImage &&
                    context.watch<ImageScreenBloc>().state.fileUrl.isNotEmpty
                ? InkWell(
                    child: Image.network('${state.fileUrl}?type=thumb'),
                  )
                : Text('response goes here '));
      },
    );
  }
}
