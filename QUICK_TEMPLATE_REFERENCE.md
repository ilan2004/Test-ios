# Quick iOS Project Template Reference

## 🎯 **Copy-Paste Checklist for New Projects**

### **Variables to Replace:**
- `YourApp` → Your actual app name (e.g., "TodoApp")
- `com.yourcompany.YourApp` → Your bundle ID (e.g., "com.acme.TodoApp")

### **Directory Structure to Create:**
```
YourApp/
├── YourApp.xcodeproj/project.pbxproj
├── YourApp/
│   ├── YourAppApp.swift
│   ├── ContentView.swift
│   ├── Assets.xcassets/
│   │   ├── Contents.json
│   │   ├── AppIcon.appiconset/Contents.json
│   │   └── AccentColor.colorset/Contents.json
│   └── Preview Content/
│       └── Preview Assets.xcassets/Contents.json
└── codemagic.yaml
```

### **Key Files to Modify:**

#### **1. codemagic.yaml - Update these lines:**
```yaml
XCODE_PROJECT: "YourApp.xcodeproj"
XCODE_SCHEME: "YourApp" 
bundle_identifier: com.yourcompany.YourApp
```

#### **2. project.pbxproj - Find & Replace:**
- `SimpleRoutingApp` → `YourApp` (all occurrences)
- `com.test.SimpleRoutingApp` → `com.yourcompany.YourApp`

#### **3. YourAppApp.swift - Template:**
```swift
import SwiftUI

@main
struct YourAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

## 🚀 **Testing Flow:**
1. Create files → 2. Push to GitHub → 3. Connect Codemagic → 4. Run unsigned build → 5. Download IPA

## ⚠️ **Critical Don'ts:**
- Don't forget to rename the main app file to match your app name
- Don't use spaces in project names (use CamelCase)
- Don't change asset catalog structure - copy exactly
- Don't skip the Preview Content directory

## 🎯 **Success Indicators:**
- ✅ Codemagic detects your project as iOS
- ✅ Build completes without "scheme not found" errors
- ✅ IPA file appears in artifacts
- ✅ File size > 1MB (indicates successful build)
