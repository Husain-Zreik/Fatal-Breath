<img src="./readme/assets/titles/title1.svg"/>

<div align="center">

> Hello world! This is the project’s summary that describes the project plain, simple, and limited to the space available.

**[PROJECT PHILOSOPHY](https://github.com/tahataha005/solaro#-project-philosophy) • [PROTOTYPING](https://github.com/tahataha005/solaro#-prototyping) • [TECH STACK](https://github.com/tahataha005/solaro#-tech-stack) • [IMPLEMENTATION](https://github.com/tahataha005/solaro#-impplementation) • [HOW TO RUN?](https://github.com/tahataha005/solaro#-how-to-run)**

</div>

<br><br>

<img src="./readme/assets/titles/title2.svg"/>
<div align="left">

> Solaro is an IOT app that tracks solar systems charging, energy usage of individual connected items, and overall consumption.
>
> The app can control the items using arduino, and interact with the user when something wrong happens such as consumption peaks.

### User Stories

-   As a user, I want to view charging and energy usage of my solar system

-   As a user, I want to view items consumption which are connected to my solar system

-   As a user, I want to be informed about anything wrong in my system

### Controller Stories

-   As a controller, I want to add and drop items to and from my system

-   As a controller, I want to be able to control items connected to my solar system

<br><br>

<img src="./readme/assets/titles/title3.svg"/>

> This design was planned before on [excalidraw](https://excalidraw.com/), then moved to Figma app for the fine details and animations.

> Here is a breif diagram of the app's architecture.

<img src="./readme/assets/Plan.png"/>

<br>

> Note that i didn't use any styling library or theme, all from scratch and using pure css modules

| Log in                                                                                             | Sign up                                                                                              | Landing                                                                                              | Notifications                                                                                                    |
| -------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| ![Log in](https://github.com/tahataha005/solaro/blob/readme/readme/assets/mockups/Log-in-page.svg) | ![Sign up](https://github.com/tahataha005/solaro/blob/readme/readme/assets/mockups/Sign-up-page.svg) | ![Landing](https://github.com/tahataha005/solaro/blob/readme/readme/assets/mockups/Landing-page.svg) | ![Notifications](https://github.com/tahataha005/solaro/blob/readme/readme/assets/mockups/Notifications-page.svg) |

| Main                                                                                           | View Item                                                                                                | Add Item                                                                                               | All Items                                                                                                |
| ---------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------- |
| ![Main](https://github.com/tahataha005/solaro/blob/readme/readme/assets/mockups/Home-page.svg) | ![View Item](https://github.com/tahataha005/solaro/blob/readme/readme/assets/mockups/Item-view-page.svg) | ![Add Item](https://github.com/tahataha005/solaro/blob/readme/readme/assets/mockups/Add-Item-page.svg) | ![All Items](https://github.com/tahataha005/solaro/blob/readme/readme/assets/mockups/All-Items-page.svg) |

<br><br>

<img src="./readme/assets/titles/title4.svg"/>

Here's a brief high-level overview of the tech stack the Well app uses:

-   This project uses the [Flutter app development framework](https://flutter.dev/). Flutter is a cross-platform hybrid app development platform which allows us to use a single codebase for apps on mobile, desktop, and the web.

-   The app uses [Node.js](https://nodejs.org/en/) for the backend. Node.js is a JavaScript runtime environment that allow running JavaScript code outside of a browser. Node.js is designed to build scalable network applications. Using [Express.js](https://expressjs.com/) which is a web application framework for Node.js. It provides a robust set of features to develop web and mobile applications.

-   For trusted database foundation, the app uses the [MongoDB Atlas](https://www.mongodb.com/atlas/database) that enables you to work with data the way you want – easily and effortlessly.

-   For notifications, the app uses [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging) which is a cross-platform messaging solution that lets you reliably deliver messages at no cost.

-   To send local push notifications, the app uses the [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) package which supports Android, iOS, and macOS.

-   For live data exchange, the app uses [Socket.io](https://socket.io/) which is a library that enables real-time, bidirectional and event-based communication between the client and the server.

-   To schedule server tasks, the app uses [node-cron](https://www.npmjs.com/package/node-cron) which is a simple cron-like and not-cron-like job scheduler for Node.

-   Concerning arduino, I used [PlatformIO](https://platformio.org/) which is an open source ecosystem for IoT development. It includes a cross-platform build system, a library manager that integrates with the most popular embedded development platforms, and a full-featured online IDE with debugging and unit testing.

-   To connect the arduino to the server, I used [ESP8266](https://www.espressif.com/en/products/socs/esp8266) which is a low-cost Wi-Fi microchip with full TCP/IP stack and microcontroller capability produced by Shanghai-based Chinese manufacturer, Espressif Systems.

-   The app uses the font ["Inter"](https://fonts.google.com/specimen/Inter) as its main font, and the design of the app adheres to the material design guidelines.

<br><br>

<img src="./readme/assets/titles/title5.svg"/>

> Using the above mentioned tech stacks and the wireframes built with figma from the user sotries we have, the implementation of the app is shown as below, these are screenshots from the real app

<br>

| Log in                                                                                             | Sign up                                                                                              | Log in Flow                                                                                            | Adding Systems                                                                                                 |
| -------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------- |
| ![Log in](https://github.com/tahataha005/solaro/blob/main/readme/assets/implementation/Log-in.JPG) | ![Sign up](https://github.com/tahataha005/solaro/blob/main/readme/assets/implementation/Sign-up.JPG) | ![Log In Flow](https://github.com/tahataha005/solaro/blob/main/readme/assets/implementation/Login.gif) | ![Adding systems](https://github.com/tahataha005/solaro/blob/main/readme/assets/implementation/Add-system.gif) |

| Add Item                                                                                               | Main Page                                                                                           | Statistics                                                                                                 | All Items                                                                                           |
| ------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| ![Add Item](https://github.com/tahataha005/solaro/blob/main/readme/assets/implementation/Add-item.gif) | ![Main Page](https://github.com/tahataha005/solaro/blob/main/readme/assets/implementation/Main.gif) | ![Statistics](https://github.com/tahataha005/solaro/blob/main/readme/assets/implementation/Statistics.gif) | ![View Item](https://github.com/tahataha005/solaro/blob/main/readme/assets/implementation/Item.gif) |

| Navigation                                                                                                    | Warning State                                                                                              | Notifications                                                                                                           | Drawer                                                                                             |
| ------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| ![Navigation](https://github.com/tahataha005/solaro/blob/main/readme/assets/implementation/Notifications.gif) | ![Warning State](https://github.com/tahataha005/solaro/blob/main/readme/assets/implementation/Warning.gif) | ![Notifications](https://github.com/tahataha005/solaro/blob/main/readme/assets/implementation/Recieve-notification.gif) | ![Drawer](https://github.com/tahataha005/solaro/blob/main/readme/assets/implementation/Drawer.gif) |

| Dark Mode                                                                                                   | Main Page - dark                                                                                                | Landing Page - dark                                                                                                   | Notifications - dark                                                                                                  |
| ----------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| ![Dark Mode](https://github.com/tahataha005/solaro/blob/main/readme/assets/implementation/Set-darkMode.gif) | ![Main Page -dark ](https://github.com/tahataha005/solaro/blob/main/readme/assets/implementation/Main-dark.gif) | ![Landing Page - dark](https://github.com/tahataha005/solaro/blob/main/readme/assets/implementation/Landing-view.gif) | ![Notifications -dark](https://github.com/tahataha005/solaro/blob/main/readme/assets/implementation/Landing-dark.gif) |

| All Items                                                                                                | Flexibility                                                                                             | Validation                                                                                                 |
| -------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| ![All Items](https://github.com/tahataha005/solaro/blob/main/readme/assets/implementation/All-items.gif) | ![Flexibility](https://github.com/tahataha005/solaro/blob/main/readme/assets/implementation/AppBar.gif) | ![Validation](https://github.com/tahataha005/solaro/blob/main/readme/assets/implementation/Validation.gif) |

<br><br>

<img src="./readme/assets/titles/title6.svg"/>

> This is an example of how you may give instructions on setting up your project locally.
> To get a local copy up and running follow these simple example steps.

### Prerequisites

-   npm
    ```sh
    npm install npm@latest -g
    ```
-   ESP8266 (Hardware)

### Installation

1. Clone the repo

    ```sh
    git clone https://github.com/tahataha005/solaro.git
    ```

2. Install [Node.js](https://nodejs.org/en/)

3. Go to nodejs-server directory
    ```sh
    cd nodejs-server
    ```
4. Install npm packages
    ```sh
    npm install
    ```
5. Run the server
    ```sh
    nodemon .
    ```
6. Install [Flutter SDK](https://docs.flutter.dev/get-started/install?gclid=Cj0KCQiAveebBhD_ARIsAFaAvrEXbca0gKEuW9ROxwC86eiEtJUUO5tm-AIIzds41AXpzsjkbESCw2EaAsTwEALw_wcB&gclsrc=aw.ds)

7. Go to flutter_app directory
    ```sh
    cd flutter_app
    ```
8. Install pub packages
    ```sh
    flutter pub get
    ```
9. Run flutter_app
    ```sh
    flutter run
    ```

### Hardware Setup (Go to sumulation section to simulate hardware functionality)

-   Uploading code

1. Plug your arduino to your laptop/mac

2. Install [Arduino IDE](https://docs.arduino.cc/software/ide-v2/tutorials/getting-started/ide-v2-downloading-and-installing)(You can use alternative aurduino IDE's)

3. Upload the code found in arduino directory

<br><br>

-   Configuration

1. Connect the arduino to the solar panel and the battery

2. Connect the arduino to the computer

3. In arduino/src/main.cpp, change the following variables to match your setup

    ```c
    const char* userId = "your_user_id";

    const char* systemId =  "your_system_id";
    uint8_t systemConsumptionPin = "pin_number";
    uint8_t systemChargingPin = "pin_number";

    const char* itemId =    "your_item_id";
    double idealConsumption = "#";
    uint8_t itemConsumptionPin = "pin_number";
    uint8_t itemControlPin = "pin_number";
    ```

4. Upload the code to the arduino

### Hardware Simulation

1. Go to simulator directory in arduino

    ```sh
    cd simulator
    ```

2. Change solar and item ids constants in index.js

    ```sh
    const system_id = "_Insert id here_"
    const item_id = "_Insert id here_"
    ```

3. Run server
    ```sh
    nodemon .
    ```

When applied successfully, fake data will be sent to flutter app.
