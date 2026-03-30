```swift
import SwiftUI
import WidgetKit

struct AIQuoteDailyWidget: Widget {
    let kind = "AIQuoteDaily"
    
    func placeholder(in context: Context) -> some View {
        QuoteWidgetView(quote: "Thinking is the hardest work there is, but it can be much more satisfying than any other labor. -THURGOOD MAYBE")
    }
    
    func updateConfiguration(
        with configuration: Configuration<Defaults>) -> some WidgetConfiguration {
        return WidgetConfiguration<Defaults> { context in
            QuoteWidgetView(quote: configuration.quote)
        }
    }
}

struct QuoteWidgetView: View {
    let quote: String
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                Image(systemName: "quote.diamond.fill")
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding(.horizontal)
                
                Text(quote)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()
                    .lineSpacing(2)
                
                Spacer()
                
                Text("AI Quote of the Day")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 10)
            }
            .padding()
        }
    }
}

struct QuoteWidgetView_Previews: PreviewProvider {
    static let quotes = [
        "Thinking is the hardest work there is, but it can be much more satisfying than any other labor. -THURGOOD MAYBE",
        "The future belongs to those who believe in the beauty of their dreams. -THURGOOD MAYBE",
        "Be the change you wish to see in the world. -THURGOOD MAYBE",
        "Innovation distinguishes between a leader and a follower. -THURGOOD MAYBE",
        "The only way to do great work is to love what you do. -THUR" // truncated for preview
    ]
    
    static var previews: some View {
        Group {
            ForEach(quotes, id: \.self) { quote in
                QuoteWidgetView(quote: quote)
                    .previewDisplayName("Quote Preview")
            }
        }
        .widgetpreview(radius: .regular, gradient: .init(colors: [.blue, .systemBackground]))
    }
}

// MARK: - Widget Configuration
extension Widget {
    struct Defaults: WidgetConfiguration {
        var quote: String
    }
}
```