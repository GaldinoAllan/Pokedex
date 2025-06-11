# Pokédex iOS App
<img widht=200 height=200 src="https://github.com/user-attachments/assets/2c033333-99c3-49a7-817b-576cbd795dee">

A modern iOS application built with SwiftUI that allows users to browse and explore Pokémon data from the PokéAPI. The app demonstrates Clean Architecture principles, modern iOS development practices, and provides a smooth user experience for Pokémon enthusiasts.

## ✨ Features

### Core Functionality
- **Pokémon List**: Browse through a comprehensive list of Pokémon with pagination
- **Search**: Real-time search functionality to find specific Pokémon by name
- **Sorting**: Toggle between sorting by Pokédex number or alphabetical order
- **Pokémon Details**: Detailed view showing comprehensive information about each Pokémon
- **Offline-Ready**: Robust error handling with retry functionality

### User Interface
- **Modern SwiftUI Design**: Clean, intuitive interface following iOS design guidelines
- **Smooth Animations**: Seamless transitions between screens
- **Custom Type Colors**: Each Pokémon type has its distinctive color scheme
- **Loading States**: Custom loading and error states with retry functionality

## 🏗️ Architecture & Implementation Approach

This project implements **Clean Architecture** principles to create a maintainable and testable codebase. Here's how I structured and implemented the solution:

### My Architecture Decisions

The implementation of Clean Architecture provides clear separation of concerns and makes the code highly testable. The architecture is divided into three main layers:

**1. Domain Layer (Business Logic)**
- Contains the core entities (`Pokemon`, `PokemonDetails`) that represent the business concepts
- Use Cases (`PokedexUseCase`, `PokemonDetailsUseCase`) encapsulate the business rules
- Protocols define contracts between layers

**2. Data Layer (External Dependencies)**
- Repository implementations handle data fetching from the PokéAPI
- Response models map directly to the API structure
- HTTP client abstraction allows for easy testing and potential API changes

**3. Presentation Layer (UI Logic)**
- ViewModels manage UI state and coordinate between Views and Use Cases
- SwiftUI Views handle the user interface presentation
- Router manages navigation flow throughout the app

### Key Implementation Patterns

**MVVM with SwiftUI**: Each screen has its dedicated ViewModel that manages state and business logic, keeping Views focused purely on UI presentation.

**Repository Pattern**: Abstracts data access behind protocols, making it easy to test and potentially swap data sources.

**Dependency Injection**: All dependencies are injected through initializers, following the Dependency Inversion Principle.

**State Management**: Custom `UIState<T>` enum manages the different states (idle, loading, success, failure) that async operations can have.

## 📸 Screenshots

### 📱 Launch Screen

![LaunchScreenPokedex](https://github.com/user-attachments/assets/7100a8c2-8a94-4324-b6b9-8d9a1114868f)

### Pokémon List Screen
| Main Screen - List | Loading State | Feedback Error |
|---------|---------|---------|
|![Pokedex Success](https://github.com/user-attachments/assets/920ac20f-3c66-41af-89fa-737427232ede)|![Loading State Pokedex](https://github.com/user-attachments/assets/ad520d78-a86d-4ad1-b1c8-cbab1adcef09)|![FeedbackError Pokedex](https://github.com/user-attachments/assets/98e5778e-76a4-46ea-b6c4-6512de5f52b6) |

### Pokémon Details Screen

| Bulbasaur | Charmander | Squirtle | Pikachu |
|---------|---------|---------|---------|
| ![Bulbasaur](https://github.com/user-attachments/assets/45f1cc6c-4f7a-487d-bbd1-e215d7c9d629) | ![Charmander](https://github.com/user-attachments/assets/0faaaf15-236c-4c8f-aebf-2320602aab67) | ![Squirtle](https://github.com/user-attachments/assets/3fc6c56c-26b3-454e-b103-32af31182a72) | ![Pikachu](https://github.com/user-attachments/assets/be38b17d-cc17-4696-a86e-7f18b888f079) |

## 🛠️ Technical Implementation

### Technologies & Frameworks Used
- **SwiftUI**: Chosen for its declarative nature and tight integration with iOS
- **Swift Concurrency**: Async/await for clean asynchronous code
- **URLSession**: Native networking without external dependencies
- **Swift Testing**: Modern testing framework (replacing XCTest)

### My Implementation Approach

#### State Management Strategy
I created a custom `UIState<T>` enum to handle the different states of async operations:
```swift
enum UIState<T> {
    case idle, loading, success(data: T), failure(error: ApiError)
}
```
This approach provides clear state management and makes it easy to handle loading states, errors, and success scenarios consistently across the app.

#### Reactive Programming with @Published
Instead of using Combine framework, I leveraged SwiftUI's built-in reactive capabilities:
- `@Published` properties in ViewModels automatically trigger UI updates
- `@StateObject` and `@ObservedObject` create reactive bindings
- This approach keeps the code simple while maintaining reactivity

#### Networking Architecture
I implemented a protocol-based HTTP client that:
- Uses generics for type-safe API responses
- Automatically converts snake_case JSON to camelCase Swift properties
- Provides comprehensive error handling with custom `ApiError` types
- Supports easy testing through protocol abstraction

#### Navigation Solution
Created a custom Router pattern that:
- Centralizes navigation logic in a single place
- Uses SwiftUI's NavigationStack with programmatic navigation
- Supports back navigation and potential future deeplinking
- Keeps navigation logic separate from Views

#### Error Handling Philosophy
Implemented comprehensive error handling that:
- Provides user-friendly error messages
- Includes retry functionality for failed operations
- Differentiates between network errors, parsing errors, and API errors
- Uses Result types for clean error propagation

#### Performance Optimizations
- **Pagination**: Load Pokemon in batches of 15 to keep memory usage low
- **Lazy Loading**: Only fetch details when user navigates to detail screen
- **Async Image Loading**: Built-in SwiftUI AsyncImage with custom fallbacks
- **Search Optimization**: Real-time filtering on already loaded data

## 🧪 Testing Strategy

I implemented comprehensive testing using **Swift Testing** (the new testing framework) instead of XCTest:

### Testing Architecture
- **Unit Tests**: Focus on business logic and data layer components
- **Mock Objects**: Created protocol-based mocks for repositories and use cases
- **Test Fixtures**: Reusable test data generators for consistent testing
- **Async Testing**: Proper testing of async/await functions

### What I Tested
- **Repository Layer**: API integration and data mapping
- **Use Cases**: Business logic validation and error handling
- **ViewModels**: State management and UI logic
- **Network Layer**: HTTP client functionality with different scenarios

### Testing Approach
I structured tests to cover the most critical paths:
- Data fetching and parsing from PokéAPI
- Error scenarios and recovery mechanisms
- Pagination logic and state management
- Search functionality and filtering
- Navigation flow between screens

### Swift Testing Benefits
Using Swift Testing provided several advantages:
- More expressive test syntax with `#expect` macros
- Better async testing support
- Improved test organization and readability
- Better integration with Swift's type system

### Test Coverage Areas
- ✅ Pokémon list loading and pagination
- ✅ Search functionality
- ✅ Navigation between screens  
- ✅ Error handling and retry mechanisms
- ✅ Pokémon details loading
- ✅ Network layer functionality

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0+
- iOS 18.0+
- Swift 5.9+

### Installation
1. Clone the repository
2. Open `Pokedex.xcodeproj` in Xcode
3. Build and run the project

### Running Tests
1. Press `Cmd + U` to run all tests
2. Or use the Test Navigator in Xcode

## 🎯 Challenge Implementation

This project successfully addresses all core requirements for a modern iOS Pokédex application:

### Core Features Delivered
- ✅ **Pokémon List with Pagination**: Implemented efficient loading of 15 Pokemon at a time
- ✅ **Real-time Search**: Filter Pokemon by name as user types
- ✅ **Sorting Options**: Toggle between Pokédex number and alphabetical order
- ✅ **Detailed Pokemon View**: Complete stats, abilities, types, and characteristics
- ✅ **Robust Error Handling**: User-friendly error states with retry functionality
- ✅ **Modern UI Design**: Clean SwiftUI interface with type-based color schemes

### Technical Achievements
- ✅ **Clean Architecture**: Proper separation of concerns with testable code
- ✅ **Protocol-Oriented Programming**: Abstracted dependencies for flexibility
- ✅ **Async/Await Implementation**: Modern Swift concurrency patterns
- ✅ **Comprehensive Testing**: Swift Testing framework with high coverage
- ✅ **Performance Optimization**: Efficient data loading and memory management
- ✅ **Code Quality**: Well-documented, maintainable codebase

### Development Decisions
- **No External Dependencies**: Used only native iOS frameworks for reliability
- **SwiftUI First**: Fully embraced SwiftUI's declarative paradigm
- **Modern Swift**: Utilized latest Swift features like async/await and Swift Testing
- **Clean Code**: Focused on readability and maintainability over complexity

## 🔮 Future Enhancements

Potential improvements that could be added:
- Favorite Pokemon functionality with local persistence
- Advanced filtering by type, generation, or stats
- Pokemon evolution chain visualization
- Offline caching for better performance

## 📄 License

This project was developed as part of an iOS development challenge to demonstrate Clean Architecture and modern Swift development practices.

---

*Built with SwiftUI, Clean Architecture, and modern Swift development practices*
