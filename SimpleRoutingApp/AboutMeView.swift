import SwiftUI

struct AboutMeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Profile Image
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.blue)
                    .padding(.top, 20)
                
                // Name and Title
                VStack(spacing: 8) {
                    Text("John Doe")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("iOS Developer")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                
                // Bio Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("About Me")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("I'm a passionate iOS developer with experience in Swift and SwiftUI. I love creating beautiful and functional mobile applications that provide great user experiences.")
                        .font(.body)
                        .lineSpacing(4)
                }
                .padding(.horizontal, 30)
                
                // Skills Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Skills")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 10) {
                        SkillTag(text: "Swift")
                        SkillTag(text: "SwiftUI")
                        SkillTag(text: "UIKit")
                        SkillTag(text: "Core Data")
                        SkillTag(text: "Firebase")
                        SkillTag(text: "Git")
                    }
                }
                .padding(.horizontal, 30)
                
                // Contact Section
                VStack(spacing: 15) {
                    Text("Get in Touch")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 10) {
                        ContactRow(icon: "envelope", text: "john.doe@example.com")
                        ContactRow(icon: "phone", text: "+1 (555) 123-4567")
                        ContactRow(icon: "globe", text: "johndoe.dev")
                    }
                }
                .padding(.horizontal, 30)
                
                Spacer(minLength: 30)
            }
        }
        .navigationTitle("About Me")
        .navigationBarTitleDisplayMode(.large)
    }
}

// Helper view for skill tags
struct SkillTag: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.medium)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.blue.opacity(0.1))
            .foregroundColor(.blue)
            .cornerRadius(15)
    }
}

// Helper view for contact rows
struct ContactRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)
            
            Text(text)
                .font(.body)
            
            Spacer()
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
    }
}
