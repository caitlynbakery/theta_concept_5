import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/camera_use/camera_use_bloc.dart';

class RefreshScreen extends StatelessWidget {
  const RefreshScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraUseBloc, CameraUseState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  context.read<CameraUseBloc>().add(GetModeEvent());
                },
                child: Text('Refresh'),
              ),
              const Center(
                  child: SizedBox(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(
                        strokeWidth: 8,
                      ))),
            ],
          ),
        );
      },
    );
  }
}
