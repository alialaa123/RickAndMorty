
# Rick and Morty

This application displays a list of Rick and Morty characters with a filter option for character status. Users can select any character to view detailed information in the next screen.

### Project Overview
This project is a demonstration of modern iOS development practices, leveraging MVVM architecture, Clean Architecture, and SwiftUI for building a scalable and maintainable application. 

one of the Task requirements is to mix view using UIKit `Tableview` for listing and `swiftUI` for any components.

The project also incorporates advanced patterns such as Repository Pattern, Dependency Injection, Coordinator Pattern, and Combine Framework for reactive programming.

### Architecture
##### - MVVM Architecture
###### The project follows the Model-View-ViewModel (MVVM) pattern to separate the UI logic from the business logic. Aslo project adheres to **Clean Architecture** principles to ensure a clear separation of concerns: **Domain Layer**, **Data Layer**, **Network Layer**

### Patterns in use
##### - Repository Pattern, Dependency Injection (DI), Coordinator Pattern
###### Using different pattern each for purpose like creating decoupling between Dependency, or manage navigation and flow control

##### - Concurrency with Actor and Sendable
###### The project leverages Swift's modern concurrency features, including Sendable, to ensure thread-safe data handling and improve performance.

### Key Feature
#### - Generic Components
For reusability, less redundant code

#### - Protocol-Oriented
The use of protocols ensures clear, decoupled, and testable code, making it easier to mock dependencies and write unit tests.

#### - Swift Concurrency
The project utilizes modern Swift concurrency features such as `async/await`, `Actors`, and `Sendable` to handle asynchronous tasks safely and efficiently, ensuring thread-safe data handling.

## # Network Layer
The network layer is built using Swift's new concurrency model, relying on `Actors` for the `networkClient:`. By declaring the `networkClient` as an actor, the project ensures that only one task can access its state at a time, preventing data races and ensuring thread safety.

Most protocols are marked with `Sendable` ensuring that objects implementing these protocols follow rules for immutability or thread safety. This makes shared state safer across concurrent domains.

## # Unit Testing
The project includes comprehensive unit tests for both the Network Layer and Data Layer:

#### Network Layer Tests:

- Ensure that API requests and responses are handled correctly, including error cases and edge scenarios.

#### Data Layer Tests:

- Validate data transformation, persistence, and retrieval logic, ensuring consistency and reliability.

These tests are written using XCTest and leverage mocking to isolate dependencies, ensuring that the tests are reliable and focused on specific functionality.


## # Technologies and Tools

**SwiftUI:** For building declarative and modern UIs.

**Combine:** For reactive programming and data binding.

**async/await:** To handle asynchronous tasks in a clean and readable way.

**actor/sendable:** For modern Swift concurrency features, ensuring efficient and safe state management.

**Dependency Injection:** For managing dependencies in a clean and testable way.

**Coordinator Pattern:** For navigation management.

**Clean Architecture:** For separation of concerns and scalability, with centralized business logic in the `Domain Layer`.
