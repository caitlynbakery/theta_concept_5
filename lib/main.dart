import 'package:flutter/material.dart';

import 'blocs/camera_use/camera_use_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraUseBloc(),
      child: MaterialApp(
        home: BlocBuilder<CameraUseBloc, CameraUseState>(
          builder: (context, state) {
            context.read<CameraUseBloc>().add(GetModeEvent());

            var captureMode = state.captureMode;

            if (captureMode == 'image') {
              return Scaffold(
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {},
                        child: Text('Get Mode'),
                      ),
                      MaterialButton(onPressed: () {}, child: Text('Take Pic')),
                    ]),
              );
            } else if (captureMode == 'video') {
              return Scaffold(
                body: Column(children: [
                  MaterialButton(
                    onPressed: () {},
                    child: Text('Take Video'),
                  )
                ]),
              );
            } else {
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
                    Center(
                        child: SizedBox(
                            width: 200,
                            height: 200,
                            child: CircularProgressIndicator(
                              strokeWidth: 8,
                            ))),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
