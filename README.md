<p align="center">
<a href="https://github.com/siva-sankar-dev/ModKit.git">
<img src="./Assets/modkit.png" width="400" style="padding-bottom: 20px"/>
</a>
</p>

![Swift](https://img.shields.io/badge/Swift-6+-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0+-blue.svg)
![Platforms](https://img.shields.io/badge/platforms-iOS%20|%20macOS%20|%20tvOS%20|%20watchOS-lightgrey.svg)

**ModKit** is a comprehensive SwiftUI utility package that extends the native SwiftUI components with powerful, concise modifiers and extensions. It enhances your development workflow by providing intuitive shortcuts and advanced styling options without requiring additional dependencies.

## Features

- 🎨 **Enhanced Styling** - Clean, intuitive styling modifiers for views
- 🖼️ **Flexible Layout** - Simplified frame and padding controls
- 🔍 **Debug Tools** - Development-only debugging helpers
- 📱 **Gesture Handling** - Simplified multi-tap gesture implementation
- 🔄 **Conditional Modifiers** - Apply view changes based on conditions
- 🧮 **Math and Numeric Extensions** - Useful extensions for Int and Double values
- 📅 **Date Formatting** - Simple date manipulation and formatting
- 🔤 **Collection Utilities** - Helpful extensions for arrays
- 🕸️ **Spider Layer** - Protocol-oriented, testable network layer with both completion handler and async/await support
## Installation

### Swift Package Manager

Add ModKit to your project by adding it as a dependency in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/siva-sankar-dev/ModKit.git", from: "1.0.0")
]
```

Or add it directly through Xcode:
1. File > Swift Packages > Add Package Dependency
2. Enter the repository URL: `https://github.com/siva-sankar-dev/ModKit.git`
3. Follow the prompts to complete the installation

## Usage

### View Extensions

#### Custom Styling

```swift
// Apply uniform corner radius
Text("Rounded corners")
    .cornerRadius(8)

// Apply different corner radii to each corner
Rectangle()
    .cornerRadius(
        topLeadingRadius: 10,
        topTrailingRadius: 10,
        bottomLeadingRadius: 0,
        bottomTrailingRadius: 0
    )

// Apply comprehensive styling in one modifier
Button("Styled Button") {}
    .style(
        radius: 12,
        radiusStyle: .continuous,
        borderColor: .blue,
        borderWidth: 2
    )
```

#### Foreground and Background Colors

```swift
Text("Colored text")
    .foregroundColor(.red)
    .backgroundColor(.yellow)
```

#### Simplified Frame Modifiers

```swift
// Set width and height in one call
Image(systemName: "star.fill")
    .frame(50)  // Creates a 50x50 frame

// Set specific dimension
Text("Fixed width")
    .width(200)

// Maximum sizes
VStack {
    Text("Full width")
        .maxWidth()
    
    Spacer()
    
    Text("Full frame")
        .maxFrame()
}
```

#### Padding Shortcuts

```swift
Text("Horizontal padding")
    .horizontalPadding()

Text("Custom vertical padding")
    .verticalPadding(20)
```

#### Conditional Modifiers

```swift
// Apply a modifier conditionally
Text("Conditional styling")
    .if(isHighlighted) { view in
        view.foregroundColor(.red)
    }

// Apply different modifiers based on condition
Text("Dark mode or light mode styling")
    .ifElse(colorScheme == .dark) { view in
        view.foregroundColor(.white)
    } elseTransform: { view in
        view.foregroundColor(.black)
    }
```

#### Debugging Helpers

```swift
// Add a colored border in DEBUG builds only
VStack {
    Text("Debug layout")
}
.debugBorder(.red)

// Print view size changes to console in DEBUG builds only
Text("Size tracking")
    .debugSize("MyView")
```

#### Multi-Tap Gestures

```swift
Image(systemName: "heart")
    .multiTapGesture(
        onSingleTap: {
            print("Single tap detected")
        },
        onDoubleTap: {
            print("Double tap detected")
        },
        onLongPress: {
            print("Long press detected")
        }
    )
```

### Text Extensions

```swift
Text("Centered text")
    .align(.center)
```

### Image Extensions

```swift
// Create images with SF Symbols
Image(sfSymbol: .heart_fill)
// or
Image(sfSymbol: .star_circle)

// Make images responsive
Image("photo")
    .responsiveImage(contentMode: .fill)

// Create circular avatar images
Image("profile")
    .circularAvatar(
        diameter: 50,
        borderColor: .blue,
        borderWidth: 2
    )
```

### Color Extensions

```swift
// Core Graphics-style color constants
Text("Red text")
    .foregroundColor(.cgRed)

// Create colors from hex values
let buttonColor = Color(hex: 0x3498db)
let backgroundColor = Color(hexString: "#e74c3c")

// Create lighter or darker variants
Button("Hover effect") {}
    .background(Color.blue.darker(by: 20))
    .backgroundStyle(Color.blue)

// Simplified white with opacity
Color.white(0.5) // 50% white
```

### Integer Extensions

```swift
// Checking properties
5.isEven  // false
5.isOdd   // true
5.isPositive  // true
(-5).isNegative  // true

// Get digit information
123.digits  // [1, 2, 3]
123.digitCount  // 3

// Repetition
3.times {
    print("Hello")
}

5.times { index in
    print("Iteration \(index)")
}

// Primality check
7.isPrime  // true
8.isPrime  // false

// Type conversion
let cgFloat = 10.toCGFloat
let double = 10.toDouble
let string = 10.toString
```

### Date Extensions

```swift
// Date components
let today = Date()
today.day    // Current day (1-31)
today.month  // Current month (1-12)
today.year   // Current year

// Formatting
today.string(format: "yyyy-MM-dd")

// Status check
today.isToday  // true

// Human-readable time ago
let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
yesterday.timeAgoDisplay()  // "1 day ago"
```

### Array Extensions

```swift
// Check if not empty
if myArray.isNotEmpty {
    // Do something
}

// Split array into chunks
let numbers = [1, 2, 3, 4, 5, 6, 7, 8]
let chunks = numbers.chunked(into: 3)
// [[1, 2, 3], [4, 5, 6], [7, 8]]

// Remove duplicates (for Hashable elements)
let duplicates = [1, 2, 2, 3, 3, 3, 4]
let unique = duplicates.removeDuplicates()
// [1, 2, 3, 4]
```
---
# Spider

A lightweight, protocol-oriented network layer for Swift applications. Spider provides a flexible and testable networking foundation for both UIKit and SwiftUI applications, with support for both GCD completion handlers and modern Swift Concurrency.
## Features

- **Protocol-Oriented Design** - Clean, testable architecture following Swift best practices
- **Flexible API** - Choose between GCD completion handlers or modern Swift Concurrency (async/await)
- **Generic Response Handling** - Get typed models with automatic decoding or raw data
- **Comprehensive Error Handling** - Detailed error cases for network issues
- **Lightweight & Dependency-Free** - No external dependencies required
- **Highly Testable** - Designed with testing in mind

### Basic GET Request

```swift
import Spider

// Create a network instance
let network = Spider()

// Create a request
do {
    let request = try HTTPRequest(urlString: "https://api.example.com/users")
    
    // Using completion handlers (GCD)
    network.performRequest(request) { result in
        switch result {
        case .success(let data):
            print("Received \(data.count) bytes")
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
    
    // Or using async/await
    Task {
        let result = await network.performRequest(request)
        // Handle result
    }
} catch {
    print("Invalid request: \(error)")
}
```

### Decoding Models Automatically

```swift
struct User: Decodable {
    let id: Int
    let name: String
    let email: String
}

do {
    let request = try HTTPRequest(urlString: "https://api.example.com/users/1")
    
    // Using completion handlers
    network.performRequest(request, responseType: User.self) { result in
        switch result {
        case .success(let user):
            print("User: \(user.name)")
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
    
    // Or using async/await
    Task {
        let result = await network.performRequest(request, responseType: User.self)
        // Handle result
    }
} catch {
    print("Invalid request: \(error)")
}
```

### POST Request with JSON Body

```swift
struct LoginRequest: Encodable {
    let email: String
    let password: String
}

struct AuthResponse: Decodable {
    let token: String
    let userId: Int
}

do {
    let loginData = LoginRequest(email: "user@example.com", password: "password123")
    
    // Convenient POST with JSON helper
    let request = try HTTPRequest.post(
        urlString: "https://api.example.com/login",
        json: loginData
    )
    
    // Send the request
    network.performRequest(request, responseType: AuthResponse.self) { result in
        // Handle result
    }
} catch {
    print("Invalid request: \(error)")
}
```

## Architecture

Spider follows a clean, protocol-oriented architecture:

### Core Components

- **HTTPRequest** - Configurable request object
- **NetworkProtocol** - Core networking protocol
- **NetworkService** - Default implementation
- **NetworkSession** - URLSession abstraction

### Error Handling

Spider provides a comprehensive `NetworkError` enum:

```swift
public enum NetworkError: Error, Equatable {
    case invalidURL
    case requestFailed(statusCode: Int)
    case decodingFailed
    case noData
    case unauthorized
    case serverError
    case custom(String)
    case unknown
}
```

## Advanced Usage

### Custom Configuration

```swift
// Create a custom URLSession
let config = URLSessionConfiguration.default
config.timeoutIntervalForRequest = 30
config.requestCachePolicy = .reloadIgnoringLocalCacheData
let customSession = URLSession(configuration: config)

// Create a custom network service
let customNetworkService = NetworkService(session: customSession)

// Create Spider with custom service
let network = Spider(service: customNetworkService)
```

### Custom Headers

```swift
let request = try HTTPRequest(
    urlString: "https://api.example.com/secure-endpoint",
    method: .get,
    headers: [
        .authorization(bearerToken: "your-token-here"),
        .accept(value: "application/json"),
        HTTPHeader(name: "Custom-Header", value: "Custom-Value")
    ]
)
```

### Request with Query Parameters

```swift
var components = URLComponents(string: "https://api.example.com/search")!
components.addQueryItems([
    "q": "search term",
    "page": "1",
    "limit": "20"
])

let request = try HTTPRequest(
    urlString: components.url!.absoluteString
)
```

### File Upload

```swift
let fileData = try Data(contentsOf: fileURL)

let request = HTTPRequest(
    url: URL(string: "https://api.example.com/upload")!,
    method: .post,
    headers: [.contentType(value: "application/octet-stream")],
    body: fileData
)
```

## Testing

Spider is designed with testing in mind. The protocol-oriented architecture allows for easy mocking:

```swift
// Create a mock session for testing
let mockSession = MockNetworkSession(
    mockData: responseData,
    mockResponse: HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil),
    mockError: nil
)

// Inject the mock into the service
let mockService = NetworkService(session: mockSession)
let testNetwork = Spider(service: mockService)

// Test with the mocked network
testNetwork.performRequest(request) { result in
    // Assert on result
}
```

## Best Practices

1. **Dependency Injection** - Inject the Spider instance into your services or view models
2. **Error Handling** - Always handle network errors appropriately
3. **Cancellation** - For long-running tasks, implement cancellation logic
4. **Retry Logic** - Consider implementing retry logic for transient failures
5. **Logging** - Add proper logging for network requests in development

## Integration Examples

### SwiftUI Integration

```swift
class UserViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var error: Error?
    
    private let network: Spider
    
    init(network: Spider = Spider()) {
        self.network = network
    }
    
    func fetchUser(id: Int) async {
        isLoading = true
        
        do {
            let request = try HTTPRequest(urlString: "https://api.example.com/users/\(id)")
            let result = await network.performRequest(request, responseType: User.self)
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let user):
                    self.user = user
                case .failure(let error):
                    self.error = error
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.isLoading = false
                self.error = error
            }
        }
    }
}
```

### UIKit Integration

```swift
class UserViewController: UIViewController {
    private let network = Spider()
    private var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser(id: 1)
    }
    
    private func fetchUser(id: Int) {
        do {
            let request = try HTTPRequest(urlString: "https://api.example.com/users/\(id)")
            
            network.performRequest(request, responseType: User.self) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let user):
                    self.user = user
                    DispatchQueue.main.async {
                        self.updateUI()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showError(error)
                    }
                }
            }
        } catch {
            showError(error)
        }
    }
    
    private func updateUI() {
        // Update UI with user data
    }
    
    private func showError(_ error: Error) {
        // Show error alert
    }
}
```

## Common HTTP Status Code Handling

Spider automatically converts common HTTP status codes to appropriate errors:

| Status Code | Error |
|-------------|-------|
| 401 | `.unauthorized` |
| 500-599 | `.serverError` |
| Other non-2xx | `.requestFailed(statusCode:)` |
---



### 💡 Inspiration

ModKit is heavily inspired by the elegant and minimalist approach of the [PureSwiftUI](https://github.com/CodeSlicing/pure-swift-ui) package by [@CodeSlicing](https://github.com/CodeSlicing). PureSwiftUI demonstrated how powerful, readable, and developer-friendly SwiftUI code can become when extended with thoughtful modifiers and extensions. This project motivated me to build ModKit—a modern utility package focused on enhancing the SwiftUI development experience with powerful yet concise tools, while keeping the code expressive and dependency-free.

---

## Requirements

- iOS 16.0+ / macOS 12.0+ / tvOS 15.0+ / watchOS 8.0+
- Swift 6.0+
- Xcode 16.0+

## License

ModKit is available under the MIT license. See the LICENSE file for more info.

## Author

Created by Siva Sankar

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
