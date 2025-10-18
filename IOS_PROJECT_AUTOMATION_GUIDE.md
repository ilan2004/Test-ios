# iOS Project Automation Guide: From Windows to IPA

## 🎯 **Overview**
This guide explains how to create iOS apps on Windows and automatically generate IPA files using cloud services, without needing macOS or Xcode locally.

## 🏗️ **Project Structure Requirements**

### **Why This Structure?**
iOS projects need specific files for Xcode to recognize them as valid iOS applications. Cloud build services (like Codemagic) scan for these patterns.

```
YourApp/
├── YourApp.xcodeproj/           # Xcode project definition
│   └── project.pbxproj          # Build settings, targets, file references
├── YourApp/                     # Source code directory
│   ├── YourAppApp.swift         # Main app entry point (@main)
│   ├── ContentView.swift        # Root SwiftUI view
│   ├── Assets.xcassets/         # App icons and colors
│   └── Preview Content/         # SwiftUI preview assets
├── codemagic.yaml              # CI/CD build configuration
├── .github/workflows/          # GitHub Actions (optional)
└── README.md                   # Documentation
```

## 📱 **Core iOS App Files**

### **1. Main App File (`YourAppApp.swift`)**
```swift
// WHY: Every SwiftUI app needs an entry point marked with @main
// WHAT: Defines the app structure and initial view
// HOW: Contains App protocol implementation

import SwiftUI

@main
struct YourAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()  // Your root view
        }
    }
}
```

### **2. Root View (`ContentView.swift`)**
```swift
// WHY: SwiftUI apps need a starting view
// WHAT: Your main UI content (tabs, navigation, etc.)
// HOW: Implements View protocol

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Your UI here
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            // Add more tabs...
        }
    }
}
```

## 🔧 **Xcode Project Configuration**

### **Why project.pbxproj?**
- Contains all build settings, file references, and target configurations
- Tells Xcode how to compile your app
- Defines bundle identifier, deployment target, signing settings

### **Key project.pbxproj Sections:**
```xml
<!-- FILE REFERENCES: Lists all .swift files -->
1D3623230D0F684500981E51 /* YourAppApp.swift */ = {
    isa = PBXFileReference; 
    lastKnownFileType = sourcecode.swift; 
    path = YourAppApp.swift; 
    sourceTree = "<group>"; 
};

<!-- BUILD SETTINGS: Compilation and signing rules -->
PRODUCT_BUNDLE_IDENTIFIER = com.yourcompany.YourApp;
SWIFT_VERSION = 5.0;
IPHONEOS_DEPLOYMENT_TARGET = 17.0;
```

### **Critical Settings to Update:**
```xml
<!-- Change these for your app -->
PRODUCT_BUNDLE_IDENTIFIER = com.yourcompany.YourApp;
PRODUCT_NAME = "$(TARGET_NAME)";
<!-- File references must match your actual Swift files -->
```

## 🎨 **Asset Catalogs (Required)**

### **Why Assets.xcassets?**
- iOS apps require app icons in multiple sizes
- Provides color themes and image assets
- Xcode expects this structure for valid iOS apps

### **Required Structure:**
```
Assets.xcassets/
├── Contents.json              # Catalog metadata
├── AppIcon.appiconset/        # App icon sizes
│   └── Contents.json          # Icon definitions
└── AccentColor.colorset/      # App theme color
    └── Contents.json          # Color definitions
```

### **Contents.json Templates:**

**Main Assets.xcassets/Contents.json:**
```json
{
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
```

**AppIcon.appiconset/Contents.json:**
```json
{
  "images" : [
    {
      "idiom" : "iphone",
      "scale" : "2x",
      "size" : "60x60"
    },
    // ... more sizes for iPhone/iPad
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
```

## ☁️ **Cloud Build Automation**

### **Why Codemagic/Cloud Building?**
- Building iOS apps requires macOS and Xcode
- Cloud services provide macOS runners with Xcode pre-installed
- Can generate IPAs without owning Apple hardware

### **codemagic.yaml Structure:**
```yaml
workflows:
  # Unsigned IPA (works without Apple Developer account)
  ios-unsigned-ipa:
    name: iOS Unsigned IPA Build
    instance_type: mac_mini_m1
    environment:
      vars:
        XCODE_PROJECT: "YourApp.xcodeproj"  # UPDATE THIS
        XCODE_SCHEME: "YourApp"             # UPDATE THIS
      xcode: latest
    scripts:
      - name: Build unsigned app and create IPA
        script: |
          # Build without code signing
          xcodebuild \
            -project "$XCODE_PROJECT" \
            -scheme "$XCODE_SCHEME" \
            -configuration Release \
            -destination "generic/platform=iOS" \
            CODE_SIGNING_ALLOWED=NO \
            CODE_SIGNING_REQUIRED=NO \
            build
          
          # Create IPA manually
          APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData -name "YourApp.app")
          mkdir -p Payload
          cp -r "$APP_PATH" Payload/
          zip -r YourApp-unsigned.ipa Payload/
    artifacts:
      - "*.ipa"
  
  # Signed IPA (requires Apple Developer account)
  ios-signed-ipa:
    environment:
      ios_signing:
        distribution_type: development
        bundle_identifier: com.yourcompany.YourApp  # MUST MATCH PROJECT
    # ... rest of signed build process
```

### **Key Variables to Change:**
```yaml
XCODE_PROJECT: "YourNewApp.xcodeproj"      # Your project name
XCODE_SCHEME: "YourNewApp"                 # Usually same as project
bundle_identifier: com.you.YourNewApp     # Your unique app ID
```

## 🔐 **Code Signing Explained**

### **Unsigned IPA:**
- **PRO:** Works without Apple Developer account
- **CON:** Only installs on jailbroken devices or simulators
- **HOW:** Sets `CODE_SIGNING_ALLOWED=NO` during build

### **Signed IPA:**
- **PRO:** Installs on real iOS devices
- **CON:** Requires Apple Developer account ($99/year)
- **HOW:** Uses provisioning profiles and certificates

## 🚀 **Step-by-Step Implementation**

### **Step 1: Create Project Structure**
```bash
# Create directories
mkdir YourApp
mkdir YourApp/YourApp
mkdir YourApp/YourApp.xcodeproj
mkdir -p YourApp/YourApp/Assets.xcassets/AppIcon.appiconset
mkdir -p YourApp/YourApp/Assets.xcassets/AccentColor.colorset
mkdir -p YourApp/YourApp/Preview\ Content/Preview\ Assets.xcassets
```

### **Step 2: Create Swift Files**
- Create `YourAppApp.swift` with `@main` struct
- Create `ContentView.swift` with your UI
- Add additional view files as needed

### **Step 3: Generate project.pbxproj**
- Use existing template and find/replace:
  - `SimpleRoutingApp` → `YourApp`
  - `com.test.SimpleRoutingApp` → `com.yourcompany.YourApp`
  - File references to match your Swift files

### **Step 4: Create Asset Catalogs**
- Copy Contents.json files from template
- No actual images needed for basic builds

### **Step 5: Configure Build Automation**
- Copy `codemagic.yaml` template
- Update project name variables
- Update bundle identifier

### **Step 6: Test and Deploy**
- Push to GitHub repository
- Connect to Codemagic
- Run unsigned build first to test
- Add Apple Developer credentials for signed builds

## ⚠️ **Common Issues & Solutions**

### **"No matching profiles found"**
- **CAUSE:** Trying to build signed IPA without Apple Developer account
- **SOLUTION:** Use unsigned build workflow first

### **"Project not detected"**
- **CAUSE:** Missing `.xcodeproj` directory or malformed `project.pbxproj`
- **SOLUTION:** Ensure proper Xcode project structure

### **"Build scheme not found"**
- **CAUSE:** Scheme name doesn't match project name
- **SOLUTION:** Update `XCODE_SCHEME` variable in config

## 📋 **Checklist for New Projects**

- [ ] Project directory matches app name
- [ ] `.xcodeproj/project.pbxproj` exists with correct references
- [ ] Main app file has `@main` annotation
- [ ] Asset catalogs have required JSON files
- [ ] Bundle identifier is unique
- [ ] `codemagic.yaml` variables updated
- [ ] Repository is public or connected to Codemagic

## 🎯 **Quick Template Generator**

Use this pattern to generate any iOS project:

1. **Replace these placeholders:**
   - `YourApp` → Your actual app name
   - `com.yourcompany.YourApp` → Your bundle ID
   - `YourAppApp.swift` → Your main app file

2. **Copy file structure exactly**
3. **Update all file references in project.pbxproj**
4. **Test with unsigned build first**

This approach lets you create professional iOS apps from Windows and automatically generate IPAs through cloud services, without needing macOS or Xcode locally.
