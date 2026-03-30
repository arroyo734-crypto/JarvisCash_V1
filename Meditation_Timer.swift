```swift
import SwiftUI
import WidgetKit

struct MeditationTimerWidget: View {
    @State private var timeRemaining: TimeInterval = 300  // 5 minutes in seconds
    @State private var isActive = false
    @State private var timer: Timer?

    var body: some View {
        VStack(spacing: 12) {
            // Circular progress timer
            Canvas { context, size in
                let width = size.width
                let height = size.height
                let radius = min(width, height) / 2 - 10
                
                let startAngle = .degrees(90)
                let endAngle = isActive
                    ? .degrees(90 - 360 * (timeRemaining / 300))
                    : .degrees(90)
                
                // Background circle
                Path { path in
                    path.addArc(
                        center: CGPoint(x: width/2, y: height/2),
                        radius: radius,
                        startAngle: startAngle,
                        endAngle: .degrees(360),
                        clockwise: false
                    )
                }
                .stroke(Color.gray.opacity(0.2), lineWidth: 10)
                
                // Foreground circle (progress)
                Path { path in
                    path.addArc(
                        center: CGPoint(x: width/2, y: height/2),
                        radius: radius,
                        startAngle: startAngle,
                        endAngle: end = isActive ? .degrees(90 - 360 * (timeRemaining / 300)) : .degrees(90),
                        clockwise: false
                    )
                }
                .stroke(Color.green, lineWidth: 10)
                
                // Center dot
                Circle()
                    .fill(Color.green)
                    .opacity(isActive ? 1 : 0)
                    .frame(width: 20, height: 20)
            }
            .frame(width: 80, height: 80)
            
            // Timer display
            Text("\(formatTime())")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.primary)
            
            // Start/Stop button
            Button(action: toggleTimer) {
                Image(systemName: isActive ? "stop.circle" : "play.circle")
                    .symbolRenderingMode(.multicolor)
                    .font(.system(size: 24))
                    .padding(12)
            }
            .buttonStyle(PlainButtonStyle())
            
            // Reset button
            Button(action: resetTimer) {
                Text("Reset")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
            }
        }
        .padding()
        .widgetPreview(Color.black)
    }
    
    private func formatTime() -> String {
        let minutes = Int(timeRemaining / 60)
        let seconds = Int(timeRemaining % 60)
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func toggleTimer() {
        isActive.toggle()
        
        if isActive {
            timer = Timer.scheduledTimer(with: .seconds(1), target: self, selector: #selector(updateTimer), repeats: true)
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc private func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            isActive = false
            timer?.invalidate()
            timer = nil
        }
    }
    
    private func resetTimer() {
        isActive = false
        timeRemaining = 300
        timer?.invalidate()
        timer = nil
    }
}

// Preview for widget development
struct MeditationTimerWidget_Previews: PreviewProvider {
    static var previews: some View {
        MeditationTimerWidget()
            .previewDisplayName("Meditation Timer Widget")
    }
}
```