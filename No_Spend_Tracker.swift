```swift
import SwiftUI

struct NoSpendTrackerWidget: View {
    @State private var spent = 0.0
    @State private var goal = 1000.0
    @State private var currentDate = Date()
    
    var body: some View {
        VStack(spacing: 8) {
            Text("\(formattedCurrency)")
                .font(.title)
            
            ProgressView(value: spent, total: goal)
                .frame(height: 20)
            
            Text("\(formattedPercentage)%")
                .font(.caption)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
    }
    
    private var formattedCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: spent)) ?? "$0.00"
    }
    
    private var formattedPercentage: String {
        let percentage = (spent / goal * 100).rounded(toIntegersAndHalf)
        return "\(Int(percentage))"
    }
}

#Preview {
    NoSpendTrackerWidget()
        .frame(width: 150, height: 100)
}
```