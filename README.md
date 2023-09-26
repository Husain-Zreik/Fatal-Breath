<img src="./readme/titles/title1.svg"/>

<br><br>

<!-- project philosophy -->
<img src="./readme/titles/title2.svg"/>

> "Fatal Breath" - Your Safety Guardian

"Fatal Breath" is an IOT revolutionary application designed to safeguard lives by monitoring and controlling indoor air quality in real-time. Our mission is to protect you and your loved ones from the silent threat of toxic gases, like carbon monoxide (CO), in your living spaces.

With "Fatal Breath," you can ensure a safe environment by easily monitoring gas levels, receiving timely alerts, and taking immediate action when needed. Breathe easy and live with confidence, knowing that "Fatal Breath" has your back.

<br><br>

### Key Features
- **Real-Time Monitoring:** Keep an eye on gas levels in your rooms, ensuring a safe living environment for you and your family.
- **Instant Alerts:** Receive notifications when gas levels exceed safe limits, allowing you to take immediate action.
- **Secure Communication:** Stay connected with your household members through our in-house chat feature.
- **Safety Consultation:** Get expert advice on safety procedures and emergency response through our AI-powered consultation feature.

<br><br>

### User Stories
- As a user, I want to monitor the CO level in the rooms, so I can know the room status.
- As a user, I want to login and edit my profile, so I can enter the app and change my info.
- As a user, I want to request to enter a house and accept invitations, so I can be a member of a house.
- As a user, I want to chat with other users in the same house, so I can check on them if something happens.
- As a user, I want to recieve notifications about the CO level, so I can stay aware about the current status.


### Manager Stories
- As a manager, I want to add or delete my houses and rooms, so I can monitor all my houses at the same time.
- As a manager, I want to invite users to enter my house and accept requests, so I can add members to my house.

<br><br>

<!-- Prototyping -->
<img src="./readme/titles/title3.svg"/>

> We designed Coffee Express using wireframes and mockups, iterating on the design until we reached the ideal layout for easy navigation and a seamless user experience.

### Wireframes
| Login screen  | Register screen |  Landing screen |
| ---| ---| ---|
| ![Landing](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) |

### Mockups
| Home screen  | Menu Screen | Order Screen |
| ---| ---| ---|
| ![Landing](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) |

<br><br>

<!-- Implementation -->
<img src="./readme/titles/title4.svg"/>

> Using the wireframes and mockups as a guide, we implemented the Coffee Express app with the following features:

### User Screens (Mobile)
| Login screen  | Register screen | Landing screen | Loading screen |
| ---| ---| ---| ---|
| ![Landing](https://placehold.co/900x1600) | ![fsdaf](https://placehold.co/900x1600) | ![fsdaf](https://placehold.co/900x1600) | ![fsdaf](https://placehold.co/900x1600) |
| Home screen  | Menu Screen | Order Screen | Checkout Screen |
| ![Landing](https://placehold.co/900x1600) | ![fsdaf](https://placehold.co/900x1600) | ![fsdaf](https://placehold.co/900x1600) | ![fsdaf](https://placehold.co/900x1600) |

### Admin Screens (Web)
| Login screen  | Register screen |  Landing screen |
| ---| ---| ---|
| ![Landing](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) |
| Home screen  | Menu Screen | Order Screen |
| ![Landing](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) | ![fsdaf](./readme/demo/1440x1024.png) |

<br><br>

<!-- Tech stack -->
<img src="./readme/titles/title5.svg"/>

###  Coffee Express is built using the following technologies:

- This project uses the [Flutter app development framework](https://flutter.dev/). Flutter is a cross-platform hybrid app development platform which allows us to use a single codebase for apps on mobile, desktop, and the web.
- For persistent storage (database), the app uses the [Hive](https://hivedb.dev/) package which allows the app to create a custom storage schema and save it to a local database.
- To send local push notifications, the app uses the [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) package which supports Android, iOS, and macOS.
  - 🚨 Currently, notifications aren't working on macOS. This is a known issue that we are working to resolve!
- The app uses the font ["Work Sans"](https://fonts.google.com/specimen/Work+Sans) as its main font, and the design of the app adheres to the material design guidelines.

<br><br>

<!-- How to run -->
<img src="./readme/titles/title6.svg"/>

> To set up Coffee Express locally, follow these steps:

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.
* npm
  ```sh
  npm install npm@latest -g
  ```

### Installation

_Below is an example of how you can instruct your audience on installing and setting up your app. This template doesn't rely on any external dependencies or services._

1. Get a free API Key at [https://example.com](https://example.com)
2. Clone the repo
   ```sh
   git clone https://github.com/your_username_/Project-Name.git
   ```
3. Install NPM packages
   ```sh
   npm install
   ```
4. Enter your API in `config.js`
   ```js
   const API_KEY = 'ENTER YOUR API';
   ```

Now, you should be able to run Coffee Express locally and explore its features.