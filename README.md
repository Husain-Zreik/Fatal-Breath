<img src="./readme/titles/title1.svg"/>

<br><br>

<!-- project philosophy -->
<img src="./readme/titles/title2.svg"/>

> "Fatal Breath" - Your Safety Guardian

>"Fatal Breath" is an IOT revolutionary application designed to safeguard lives by monitoring and controlling indoor air quality in real time. Our mission is to protect you and your loved ones from the silent threat of toxic gases, like carbon monoxide (CO), in your living spaces.

>With "Fatal Breath," you can ensure a safe environment by easily monitoring gas levels, receiving timely alerts, and taking immediate action when needed. Breathe easy and live with confidence, knowing that "Fatal Breath" has your back.

### Key Features
- **Real-Time Monitoring:** Keep an eye on gas levels, ensuring a safe living environment for you and your family.
- **Instant Alerts:** Receive notifications when gas levels exceed safe limits, allowing you to take immediate action.
- **Secure Communication:** Stay connected with your household members through our in-house chat feature.

<br>

### User Stories
- As a user, I want to monitor the CO level in the rooms, so I can know the room status.
- As a user, I want to log in and edit my profile, so I can enter the app and change my info.
- As a user, I want to request to enter a house and accept invitations, so I can be a member of a house.
- As a user, I want to chat with other users in the same house, so I can check on them if something happens.
- As a user, I want to receive notifications about the CO level, so I can stay aware of the current status.

<br/>

### Manager Stories
- As a manager, I want to add or delete my houses and rooms, so I can monitor all my houses at the same time.
- As a manager, I want to invite users to enter my house and accept requests, so I can add members to my house.

<br><br>

<!-- Prototyping -->
<img src="./readme/titles/title3.svg"/>

> We designed Fatal Breath using wireframes and mockups, iterating on the design until we reached the ideal layout for easy navigation and a seamless user experience.

### Wireframes
| Sign Up screen  | Home screen |  Chat screen |
| ---| ---| ---|
| ![Sign UP](./readme/assets/registerScreen.png) | ![Home](./readme/assets/homeScreen.png) | ![Chat](./readme/assets/chatScreen.png) |

### Mockups
| Sign Up screen  | Main Screen | Chat Screen |
| ---| ---| ---|
| ![Sign Up](./readme/mockups/registerScreen.png) | ![Home](./readme/mockups/homeScreen.png) | ![Chat](./readme/mockups/chatScreen.png) |
| Register screens  | Home Screens | Users Screens |
| ![Sign Up](./readme/mockups/part1.gif) | ![Home](./readme/mockups/part2.gif) | ![Chat](./readme/mockups/part3.gif) |

<br><br>

<!-- Implementation -->
<img src="./readme/titles/title4.svg"/>

> Using the wireframes and mockups as a guide, we implemented the Fatal Breath app with the following features:

### Common Screens (Mobile)
| Sign Up | Sign In | Edit Profile |
| ---| ---| ---|
| ![Landing](./readme/implementation/signup.gif) | ![Sign In](./readme/implementation/login.gif) | ![Edit Profile](./readme/implementation/settings.gif) |

<br><be>

| Chatting-System |Notification| Change-Password | 
| ---| ---| ---|
| ![chats](./readme/implementation/chats.gif) | ![notifications](./readme/implementation/notification.gif) | ![Change Password ](./readme/implementation/change_password.gif) |

<br><be>

| Hardware | 
| ---|
| ![Hardware](./readme/implementation/experement.gif) |

<br><br>

### Member Screens
| Monitor CO Level | Manage Houses | Search for Houses | 
| ---| ---| ---|
| ![room monitor](./readme/implementation/room_monitor.gif) | ![Edit houses](./readme/implementation/edit_houses.gif) | ![UX](./readme/implementation/member_E.gif) |

<br><br>

### Manager Screens
| Edit Houses  | Monitor Rooms | Search for Members | 
| ---| ---| ---|
| ![Edit Houses](./readme/implementation/creation.gif) | ![Monitor Rooms](./readme/implementation/manager_houses.gif) | ![Search for Members](./readme/implementation/edit_houses.gif) |

### Advertising Website

 [Click Here to Visit the Website](https://fatal-breath.vercel.app)

| Website Preview | 
| ---|
| ![Website](./readme/implementation/website.gif) |



<br><br>

<!-- Tech stack -->
<img src="./readme/titles/title5.svg"/>

###  Fatal Breath is built using the following technologies:

- **Frontend Development:** <br> The Fatal Breath app is built using [Flutter app development framework](https://flutter.dev/). Flutter enables the development of cross-platform mobile applications with a single codebase, allowing it to run seamlessly on various devices, including mobile, desktop, and web.

- **Backend Development:** <br> For the backend, [Laravel](https://laravel.com) is used. Laravel is a robust PHP framework known for its elegant syntax and powerful features, making it ideal for building efficient and secure server-side applications.

- **Database Management:** <br> The application relies on MySQL for database management. MySQL is a widely used open-source relational database management system that ensures data is stored and retrieved efficiently.

- **Real-time Chat:** <br> To facilitate real-time communication among users, Firebase Realtime Database is integrated. [Firebase](https://firebase.google.com) is a Google-backed platform that offers real-time database capabilities, making it perfect for features like live chatting within the app.

- **Notifications:** <br> Firebase Cloud Messaging (FCM) is used for sending push notifications to users. FCM is a cross-platform messaging solution that ensures reliable message delivery across different devices.

- **Advertising Website:** <br> The advertising website for the Fatal Breath app is developed using [Next.js](https://nextjs.org), a popular React framework for building fast and SEO-friendly web applications. [TypeScript](https://www.typescriptlang.org) is used to enhance the website's development, providing static typing and better tooling support.

- **User Interface:** <br> The app's user interface adheres to a responsive and modern design using [Tailwind CSS](https://tailwindcss.com). Tailwind CSS is a utility-first CSS framework that simplifies the styling process while maintaining a highly customizable design.

- **Hardware Integration:** <br> Fatal Breath includes hardware integration with an [ESP8266 microchip](https://www.espressif.com/en/products/socs/esp8266) connected to an MQ2 sensor. This setup enables the monitoring of CO levels within rooms and provides real-time data to the app.

- **Font:** <br> The primary font used in the app is ["Poppins"](https://fonts.google.com/specimen/Poppins), known for its readability and versatility.

<br><br>

<!-- How to run -->
<img src="./readme/titles/title6.svg"/>

> To set up Coffee Express locally, follow these steps:

### Prerequisites

- Flutter SDK: Install the Flutter SDK to build and run the mobile application.

- Arduino IDE: You'll need the Arduino IDE to upload code to the ESP8266 microchip.

- ESP8266 (Hardware): Ensure you have the ESP8266 microchip connected to an MQ2 sensor for monitoring CO levels.

### Installation

_Below is an example of how you can instruct your audience on installing and setting up your app. This template doesn't rely on any external dependencies or services._

1. Clone the repo

    ```sh
    git clone https://github.com/Hu-zk/Fatal-Breath.git
    ```

2. Install Laravel dependencies by navigating to the Laravel project directory:

   ```sh
   cd laravel-backend
   composer install
   ```

3. Set up your Laravel environment and configure the .env file with your database settings.

   Run Laravel migrations to set up the database:

   ```sh
   php artisan migrate
   ```

4. Navigate to the Flutter app directory:

   ```sh
   Navigate to the Flutter app directory:
   ```

5. Install Flutter dependencies and run the Flutter app on your emulator or connected device:

   ```sh
   flutter pub get
   flutter run
   ```

### Hardware Setup (Go to the simulation section to simulate hardware functionality)

-  ESP8266 Hardware Setup:

1. Plug your Arduino to your laptop/mac

2. Install [Arduino IDE](https://docs.arduino.cc/software/ide-v2/tutorials/getting-started/ide-v2-downloading-and-installing)(You can use alternative aurduino IDE's)

3. Upload the Arduino code located in the esp8266 directory to your ESP8266 microchip using the Arduino IDE.

4. Connect the ESP8266 to the MQ2 sensor and other required components as per your hardware configuration.

<br>

Now, you should be able to run **Fatal Breath** locally and explore its features
