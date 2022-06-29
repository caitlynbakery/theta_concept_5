# THETA X Concept 5

This project focuses on getting the captureMode as soon as the application builds. The objective is to change the application's button to either picture or video mode depending on the camera's initial state. 

For example, if the camera is on picture mode, the screen should look like this: 
<img src="docs/images/imagemode.png" width=50%>

If the camera is on video mode, the screen changes to this:
<img src="docs/images/videomode.png" width=50%>

In order to implement this feature, the `GetModeEvent` runs under the `BlocBuilder` in the main file. Every time the project builds, the application gets the mode of the camera. 

```dart
child: MaterialApp(
        home: BlocBuilder<CameraUseBloc, CameraUseState>(
          builder: (context, state) {
            context.read<CameraUseBloc>().add(GetModeEvent());}))
```

Next, if the mode is equal to `image`, the application will display the `ImageScreen`. Alternatively, if the mode is equal to `video`, the application will display the `VideoScreen`. Else, there is a `RefreshScreen`.

```dart
 if (state.captureMode == 'image') {
              return const ImageScreen();
            } else if (state.captureMode == 'video') {
              return const VideoScreen();
            } else {
              return const RefreshScreen();
            }
```

## Issues

An IconButton displays the last thumbnail for an image. The variable inside of the State called `showImage` is set to true inside of the `GetPictureEvent`. If the `showImage` variable is true and there is a `fileUrl`, the application is intended to display the thumbnail image.

```dart
   return Expanded(
            child: context.watch<CameraUseBloc>().state.showImage &&
                    context.watch<CameraUseBloc>().state.fileUrl.isNotEmpty
                ? InkWell(
                    child: Image.network('${state.fileUrl}?type=thumb'),
                  )
                : Text('response goes here '));
```

However, this was not the case as the `GetModeEvent` runs after the code rebuilds. The `GetModeEvent` overrides the state and emits `showImage` as false. Thus, when the IconButton is expected to display the image, the application just displays the Text. 

The current solution is to check if `showImage` is true within the `GetModeEvent` and then run the code to get the `fileUrl`. Next, emit the State with `showImage` set to true and the `fileUrl`. Although this solution showed the thumbnail image, the code is lengthy and not the best implementation of Bloc structure. 

```dart
 on<GetModeEvent>((event, emit) async {
      var response = await thetaService.command({
        'name': 'camera.getOptions',
        'parameters': {
          'optionNames': ['captureMode']
        }
      });
    ...
    if (state.showImage) {
       ...
        var fileUrl = convertResponse['results']['entries'][0]['fileUrl'];
        emit(CameraUseState(
            message: response.bodyString,
            captureMode: captureMode,
            fileUrl: fileUrl,
            showImage: true));
```

![thumbnail](docs/images/thumbnail.gif)