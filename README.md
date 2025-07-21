# SadakVision - Road Condition Mapper

SadakVision is a mobile application built with Flutter that allows users to capture images of road deformities like potholes and cracks. These images are then processed by a deep learning model to identify and locate the deformities, which are then displayed on a map with a corresponding safety rating.

## Key Features

*   **Image Capture:** Easily capture images of road conditions using the in-app camera.
*   **Deformity Detection:** Utilizes a deep learning model to accurately detect various road deformities such as potholes and cracks.
*   **Interactive Map:** View the location of reported road deformities on an interactive Google Map.
*   **Safety Rating:** Each reported issue is assigned a safety rating, helping to prioritize repairs and inform other users.
*   **User Authentication:** Secure user authentication is handled by Auth0.

## Technologies Used

*   **Flutter:** The application's front-end is built using the Flutter framework for a cross-platform experience.
*   **Google Maps:** Used to display the location of road deformities.
*   **Ultralytics:** The deep learning model for object detection is powered by Ultralytics.
*   **Auth0:** Handles user authentication and management.

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

*   Flutter SDK
*   Dart

### Installation

1.  **Clone the repo**
    ```sh
    git clone https://github.com/mukulboro/road-condition-detection-mobile-app.git
    ```
2.  **Install packages**
    ```sh
    flutter pub get
    ```
3.  **Set up API Keys**
    *   You will need to add your own API keys for Google Maps and Auth0 in the relevant configuration files.
4.  **Run the app**
    ```sh
    flutter run
    ```
