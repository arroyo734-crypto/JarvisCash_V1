```swift
import SwiftUI

struct StepCounterWidget: View {
    @State private var stepCount: Int = 0
    
    var body: some View {
        VStack(spacing: 4) {
            Text(stepCount.formatted(.number))
                .font(.system(size: 24, weight: .bold))
            Text("Steps today")
                .font(.system(size: 12))
        }
        .padding()
        .background(Color.blue.cornerRadius(16))
        .foregroundColor(.white)
    }
}

#Preview {
    StepCounterWidget()
        .environment(\.widgetFamily, .systemSmall)
}
```