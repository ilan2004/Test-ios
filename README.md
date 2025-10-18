# Simple iOS Routing App

A simple iOS app built with Swift and SwiftUI featuring navigation between Home and About Me screens.

## Features

- **Tab Navigation**: Switch between screens using bottom tab bar
- **NavigationLink**: Direct navigation with buttons
- **Modern SwiftUI**: Declarative UI with clean, professional design
- **Responsive Layout**: Works on iPhone and iPad

## App Structure

```
SimpleRoutingApp/
├── App.swift           # Main app entry point
├── ContentView.swift   # Tab-based navigation container
├── HomeView.swift      # Home screen with welcome message
└── AboutMeView.swift   # Profile screen with skills and contact info
```

## Screenshots

### Home Screen
- Welcome message with house icon
- Quick action button to navigate to About Me
- Clean, centered layout

### About Me Screen
- Profile information with avatar
- Skills section with tags
- Contact information
- Scrollable content

## How to Build

### Option 1: Xcode (Recommended)
1. Clone this repository
2. Open Xcode on macOS
3. Create new iOS project (SwiftUI)
4. Replace default files with these Swift files
5. Build and run on simulator or device

### Option 2: Codemagic (Recommended)
1. Go to [Codemagic.io](https://codemagic.io) and sign up
2. Connect your GitHub repository
3. Select the **ios-test-build** workflow for testing without signing
4. Build will create a simulator-compatible app for testing

**For production IPA (requires Apple Developer Account):**
- Use the **ios-production** workflow
- Add your App Store Connect API keys in Codemagic settings
- Change bundle identifier from `com.test.SimpleRoutingApp` to your own

### Option 3: Other Cloud Services
- **GitHub Actions**: Uses the workflow in `.github/workflows/`
- **Bitrise**: iOS CI/CD with cloud macOS runners
- **AppCenter**: Microsoft's app build service

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.0+

## License

MIT License - Feel free to use and modify as needed.

## Contributing

1. Fork the repository
2. Create feature branch
3. Make changes
4. Submit pull request

---

**Note**: To build actual IPA files for distribution, you'll need:
- Apple Developer Account ($99/year)
- iOS Distribution Certificate
- Provisioning Profile
- Access to macOS with Xcode
