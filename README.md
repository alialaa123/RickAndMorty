
# Rick and Morty

This Application about showing list of RickAndMorty's characters with filter option for characters status, then user can select any character to show the next view for character details.

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
#### - Generic Components: 
For reusability, less reduntent code

#### - Protocol-Oriented 
For clear, decoupled, testability

#### - Swift new concurrency
Using async/ await, actors with sendable to making safer shared state, thread safe data handling.

### # Network Layer
In this project, I build Network layer based on new concurrency of swift, rely on `Actors` for `networkClient:` make it safer for multiple tasks that can hit simultaneously as NetworkClient declared as actor is puts it in isolation, ensure that only one task can access their state at a time, preventing data races.

Mark most of protocols with `Sendable` that ensure that object that implement this protocol follow the rules that the data is either immutable or thread-safe and safer for shared state across concurrent domains 


### Technologies and Tools

**SwiftUI:** For building declarative and modern UIs.

**Combine:** For reactive programming and data binding.

**async/await:** To handle asynchronous tasks in a clean and readable way.

**actor/sendable:** For modern Swift concurrency features to ensure efficient, safe

**Dependency Injection:** For managing dependencies.

**Coordinator Pattern:** For navigation management.

**Clean Architecture:** For separation of concerns and scalability, using centeralization for Bussines logic `Domain`.
