# emotune
## Emotion Recognition App

The Emotion Recognition App is a Flutter-based mobile application that utilizes machine learning to classify a user's emotions based on images taken from the front or back camera. It incorporates a pre-trained machine learning model that accurately identifies emotions like happy, sad, angry, and more. The app also has a music player feature that plays songs tailored to the user's detected emotion, enhancing their experience.

## Features

1. **Emotion Recognition**: The app captures images using the device's front or back camera and sends them to the machine learning model. The model classifies the user's emotions with an accuracy of approximately 67%, providing real-time emotion detection.

2. **Music Recommendation**: Based on the detected emotion, the app retrieves a curated list of songs from the Firebase backend that match the user's emotion. Users can listen to these songs to enhance their mood.

3. **Music Player**: The app includes a built-in music player that allows users to listen to their favourite songs, including the recommended tracks based on their emotions.

4. **User Authentication**: To personalize the experience, users can sign up or log in to the app using Firebase authentication. This allows the app to remember user preferences and song history.

5. **Offline Mode**: The app stores some songs locally to enable offline playback, ensuring that users can enjoy their favourite tracks even without an internet connection.

## Installation and Setup

To install and run the Emotion Recognition App, follow these steps:

1. Clone the GitHub repository to your local machine.

```
git clone https://github.com/Kartik-Chaurasiya/Emotune.git
```

2. Open the project in a compatible Flutter IDE (such as Android Studio or Visual Studio Code).

3. Set up the Flutter environment and install the required dependencies using `flutter pub get`.

4. Ensure you have a Firebase project set up with authentication and a database to store song recommendations.

5. Download the pre-trained machine learning model (stored as a `.pkl` file) and place it in the appropriate directory in the Flutter project.

6. Update the Firebase configuration in the app to connect to your Firebase project.

7. Run the app on your desired device or emulator using `flutter run`.

## Contributing

We welcome contributions to enhance the Emotion Recognition App. If you encounter any bugs, have feature requests, or want to improve the model's accuracy, feel free to open an issue or submit a pull request.

## Research Paper

The development of this app was supported by our research paper titled "Emotion Recognition Using Machine Learning and Its Application in Music Recommendation," which you can find [here](https://www.ijrar.org/papers/IJRAR21B1343.pdf). The paper details the methodology used, the performance of the machine learning model, and the results obtained during the development of the app.


---

Thank you for exploring the Emotion Recognition App! We hope you enjoy the music recommendations and find the emotion detection capabilities intriguing. If you have any questions or feedback, don't hesitate to reach out. Happy emoting and music listening!
