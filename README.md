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

## 6/28/22

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

## 6/29/2022

The project is separated into three separate Blocs(`camera_use`, `image_screen`, and `video_screen`). The `camera_use` Bloc holds the `GetModeEvent`, the `image_screen` Bloc holds the `TakePicEvent` and `GetPicEvent`, and the `video_screen` has the `StartCaptureEvent` and `StopCaptureEvent`. 

When the video starts/stops, the `IconButton` changes shape to match the video's State. 

<img src="docs/images/startrecord.png" width=40%>
<img src="docs/images/stoprecord.png" width=40%>

Although the application has three separate Blocs, it calls two Blocs on one screen. For example, for the image screen, the button for getting the camera mode calls the `CameraUseBloc`. 

```dart
 IconButton(
                  onPressed: () {
                    context.read<CameraUseBloc>().add(GetModeEvent());
                    // captureMode = state.captureMode;
                  },
                  icon: Icon(Icons.refresh),
                ),
```

Contrastly, the button for taking the picture calls the `ImageScreenBloc`. 

```dart
   IconButton(
                    iconSize: 200,
                    onPressed: () {
                      context.read<ImageScreenBloc>().add(ImageTakePicEvent());
                    },
                    icon: Icon(
                      Icons.circle_outlined,
                    )),
```

Below is a diagram illustrating the flow of the Bloc structure. Both the Image Screen and the Video Screen Blocs access the Camera Use Bloc. In this way, the Camera Use Bloc connects the two screens together. The Camera Use Bloc accesses the camera's mode so that each of the screens will change depending on the mode of the physical camera.

![flow chart](docs/images/Imagescreen.png)

Although the application calls multiple Blocs in one screen, it successfully performs the functionality as expected and gets the camera's mode.

Here is a test shot taken with the app on the RICOH THETA X at 5.5K resolution.

![test shot](docs/images/test_shot2.jpg)






