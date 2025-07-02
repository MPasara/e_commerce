# Shopzy :shopping_trolley:
A modern, feature-rich e-commerce mobile application built with Flutter, providing a seamless shopping experience with robust backend integration and clean architecture principles.
## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Configuration](#configuration)
- [Backend Setup](#backend-setup)
- [Payment Integration](#payment-integration)
- [State Management](#state-management)
- [Error Handling](#error-handling)
- [Localization](#localization)
- [Testing](#testing)
- [Build Flavors](#build-flavors)
- [Screenshots](#screenshots)
## Overview
Shopzy is a comprehensive e-commerce application that offers users a complete online shopping experience. Built with Flutter and powered by Supabase, it combines modern UI/UX design with robust functionality including user authentication, product management, payment processing, and personalized user experiences.
## Features
### :closed_lock_with_key: Authentication
- User registration and login
- Secure authentication with Supabase Auth
- Password reset functionality
### :house: Shopping Experience
- **Home Page**: Curated product showcase
- **Product Search**: Advanced search functionality
- **Filtering**: Filter products by category and type
- **Product Details**: Comprehensive product information
- **Wishlist**: Save favorite items for later
### :shopping_bags: User Account Management
- **Order History**: View past purchases and order details
- **Account Settings**: Personalized user preferences
- **App Localization**: Multi-language support
- **Theme Customization**: Custom background colors
- **App Information**: Version details and app info
### :credit_card: Payment Processing
- Secure payment integration with Stripe
- Multiple payment methods support
- Order confirmation and receipt generation
### :art: User Experience
- Clean, intuitive interface
- Responsive design
- Smooth animations and transitions
- Dark/Light theme support
## Architecture
Shopzy follows **Clean Architecture** principles with a **feature-first** approach, ensuring maintainable, testable, and scalable code.
### Architecture Layers
```
:file_folder: lib/
├── :file_folder: features/
│   ├── :file_folder: auth/
│   │   ├── :file_folder: presentation/     # UI Components, Pages, Controllers
│   │   ├── :file_folder: domain/          # Entities, Use Cases, Repositories
│   │   └── :file_folder: data/            # Data Sources, Models, Repository Implementations
│   ├── :file_folder: home/
│   ├── :file_folder: products/
│   ├── :file_folder: cart/
│   ├── :file_folder: wishlist/
│   ├── :file_folder: orders/
│   └── :file_folder: profile/
├── :file_folder: core/
│   ├── :file_folder: constants/
│   ├── :file_folder: utils/
│   ├── :file_folder: theme/
│   └── :file_folder: errors/
└── :file_folder: shared/
    ├── :file_folder: widgets/
    ├── :file_folder: services/
    └── :file_folder: models/
```
### Layer Responsibilities
- **Presentation Layer**: UI components, state management, user interactions
- **Domain Layer**: Business logic, entities, use cases, repository interfaces
- **Data Layer**: External data sources, API calls, local storage, repository implementations
## Tech Stack
### Frontend
- **Flutter**: Cross-platform mobile development
- **Dart**: Programming language
- **Riverpod**: State management solution
- **Either Dart**: Functional error handling
### Backend & Services
- **Supabase**: Backend-as-a-Service
  - Database (PostgreSQL)
  - Authentication
  - Real-time subscriptions
  - Storage
- **Stripe**: Payment processing
### Development Tools
- **Flutter SDK**: Latest stable version
- **Android Studio / VSCode**: Development environment
- **Git**: Version control
- **Flutter Flavorizr**: Environment management (dev, staging, prod)
### Testing
- **Unit Tests**: Comprehensive test coverage
- **Widget Tests**: UI component testing
- **Integration Tests**: End-to-end testing
## Project Structure
```
shopzy/
├── android/                 # Android-specific configuration
├── ios/                     # iOS-specific configuration
├── lib/
│   ├── core/               # Core utilities and constants
│   ├── features/           # Feature modules
│   ├── shared/             # Shared components
│   └── main.dart          # App entry point
├── test/                   # Unit and widget tests
├── integration_test/       # Integration tests
├── assets/                 # Images, fonts, and other assets
├── pubspec.yaml           # Dependencies and configuration
└── README.md              # This file
```
## Getting Started
### Prerequisites
- Flutter SDK (Latest stable version)
- Dart SDK
- Android Studio / VSCode
- Git
- A Supabase account
- A Stripe account
### Installation
1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/shopzy.git
   cd shopzy
   ```
2. **Install dependencies**
   ```bash
   flutter pub get
   ```
3. **Run the app**
   ```bash
   flutter run
   ```
### Configuration
1. **Environment Variables**
   Create a `.env` file in the root directory:
   ```env
   SUPABASE_URL=your_supabase_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key
   ```
2. **Update Configuration Files**
   - Update `android/app/src/main/AndroidManifest.xml` for Android permissions
   - Update `ios/Runner/Info.plist` for iOS permissions
## Backend Setup
### Supabase Configuration
1. Create a new Supabase project
2. Set up the following tables:
   - `users` - User profiles
   - `products` - Product catalog
   - `categories` - Product categories
   - `orders` - Order management
   - `order_items` - Order line items
   - `wishlist` - User wishlists
3. Configure Row Level Security (RLS) policies
4. Set up authentication providers
5. Configure storage buckets for product images
## Payment Integration
Shopzy uses Stripe for secure payment processing:
- Credit/Debit card payments
- Digital wallet support (Apple Pay, Google Pay)
- Secure tokenization
- PCI compliance
- Real-time payment status updates
## State Management
The app uses **Riverpod** for state management, providing:
- Reactive state updates
- Dependency injection
- Easy testing
- Performance optimization
- Type safety
### Key Providers
- `authProvider` - Authentication state
- `productsProvider` - Product catalog
- `cartProvider` - Shopping cart
- `wishlistProvider` - User wishlist
- `ordersProvider` - Order history
## Error Handling
Shopzy implements the **Railway-Oriented Programming** approach using `either_dart`:
```dart
Either<Failure, Success> result = await useCase.execute();
return result.fold(
  (failure) => handleError(failure),
  (success) => handleSuccess(success),
);
```
This approach ensures:
- Explicit error handling
- Type-safe error propagation
- Consistent error management across the app
## Localization
The app supports multiple languages and regions:
- English (default)
- Spanish
- French
- German
- Right-to-left (RTL) language support
- Dynamic language switching
- Localized date and currency formatting
## Testing
Shopzy includes comprehensive testing to ensure code quality and reliability:
### Test Types
- **Unit Tests**: Test individual functions, methods, and classes in isolation
- **Widget Tests**: Test UI components and their interactions
- **Integration Tests**: Test complete user flows and app functionality
### Running Tests
```bash
# Run all unit and widget tests
flutter test
# Run tests with coverage
flutter test --coverage
# Run integration tests
flutter drive --target=integration_test/app_test.dart
```
### Test Structure
```
test/
├── unit/
│   ├── features/
│   │   ├── auth/
│   │   ├── products/
│   │   └── orders/
│   └── core/
├── widget/
│   └── features/
└── integration_test/
    └── app_test.dart
```
## Build Flavors
Shopzy uses **Flutter Flavorizr** to manage multiple build environments:
### Available Flavors
- **Development**: For local development and testing
- **Staging**: For pre-production testing and QA
- **Production**: For live app store releases
### Configuration
Each flavor has its own configuration:
- API endpoints
- Database connections
- Payment gateway settings
- App icons and names
- Bundle identifiers
### Running Different Flavors
```bash
# Development
flutter run --flavor dev
# Staging
flutter run --flavor staging
# Production
flutter run --flavor prod
```
### Building for Different Environments
```bash
# Build development APK
flutter build apk --flavor dev
# Build staging APK
flutter build apk --flavor staging
# Build production APK
flutter build apk --flavor prod
```
## Screenshots
<!-- Add your app screenshots here -->
| Home | Products | Profile |
|------|----------|---------|
| ![Home](screenshots/home.png) | ![Products](screenshots/products.png) | ![Profile](screenshots/profile.png) |
---
**Happy Shopping with Shopzy! :shopping_trolley::sparkles:**
