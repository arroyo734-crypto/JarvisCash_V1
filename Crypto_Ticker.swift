```swift
import SwiftUI
import WidgetKit

struct CryptoEntry: TimelineEntry {
    let date: Date
    let bitcoinPrice: Double
    let timestamp: String
}

struct CryptoWidget: Widget {
    let kind = "CryptoTicker"

    func placeholder(in context: Context) -> some View {
        CryptoWidgetView(price: "?", change: "?", timestamp: "?")
    }

    func timeline(
        for configuration: StaticConfiguration<CryptoTicker.Configuration>
    ) -> Timeline<CryptoEntry> {
        // Simulate fetching data
        let now = Date()
        let price = 60000 + Double.random(in: -500...500)
        let change = String(format: "%.2f%%", Double.random(in: -10...10))
        let timestamp = now.formatted(date: .abbreviated, time: .shortened)
        
        return Timeline(
            entries: [
                CryptoEntry(
                    date: now,
                    bitcoinPrice: price,
                    timestamp: timestamp
                )
            ],
            policy: .update(up to: now.addingTimeInterval(60))
        )
    }
}

struct CryptoWidgetView: View {
    let price: String
    let change: String
    let timestamp: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text("BTC/USD")
                .font(.headline)
                .foregroundColor(.gray)
                .opacity(0.7)
            
            Text(price)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.black)
            
            if let changeValue = change.dropFirst(), let sign = changeValue.first {
                let value = String(changeValue.dropFirst())
                Text("\(sign)$\(value)")
                    .font(.system(size: 14))
                    .foregroundColor(sign == "+" ? .green : .red)
            }
            
            Text(timestamp)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("bgColor"), Color("bgColor").opacity(0)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

struct CryptoWidget_Previews: PreviewProvider {
    static let configuration = CryptoTicker.Configuration(
        provider: LiveActivityProvider(),
        intent: .none
    )
    
    static var previews: some View {
        Group {
            CryptoWidgetView(price: "$60,000.00", change: "+2.5%", timestamp: "12:30 PM")
                .previewDisplayName("Light")
                .environment(ColorScheme.light)
            CryptoWidgetView(price: "$60,000.00", change: "+2.5%", timestamp: "12:30 PM")
                .previewDisplayName("Dark")
                .environment(ColorScheme.dark)
        }
    }
}

struct CryptoTicker: WidgetExtension {
    @MainActor
    struct Configuration: WidgetConfiguration {
        var updateInterval: ComponentValue<TimeInterval> = 60
    }
}
```

Note: This is a simplified example for demonstration purposes. In a real-world implementation, you would need to:

1. Add proper API integration for live crypto data
2. Handle different color schemes properly
3. Implement actual data fetching and background updates
4. Add proper error handling
5. Include more cryptocurrencies or customization options

The widget uses a simulated data source for demonstration. To make it functional, you would need to replace the timeline() function with actual data fetching logic.