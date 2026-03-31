import SwiftUI

struct AlphaDashboardView: View {
    @StateObject private var monitor = HighVolatilityMonitor()
    @State private var traderStatus: String = "IDLE"
    
    var body: some View {
        VStack(spacing: 25) {
            // Header: The Billion Dollar Mission
            Text("JARVIS 2.0: MAIN FRAME")
                .font(.system(size: 12, weight: .bold, design: .monospaced))
                .foregroundColor(.green)
            
            // Market Monitor Section
            VStack {
                Text("POLYMARKET ALPHA")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text("$\(monitor.currentPrice, specifier: "%.2f")")
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                    .foregroundColor(monitor.isVolatile ? .red : .primary)
                
                if monitor.isVolatile {
                    Text("⚠️ HIGH VOLATILITY DETECTED")
                        .font(.caption.bold())
                        .foregroundColor(.red)
                        .padding(5)
                        .background(Color.red.opacity(0.2))
                        .cornerRadius(5)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 15).fill(Color.secondary.opacity(0.1)))

            // Trader Signal Status (Connection to 15 Pro)
            HStack {
                Circle()
                    .fill(monitor.isVolatile ? Color.green : Color.gray)
                    .frame(width: 10, height: 10)
                Text("15 PRO TRADER: \(traderStatus)")
                    .font(.system(size: 10, weight: .bold))
            }

            // Manual Refresh / Signal Test
            Button(action: {
                monitor.checkForHighVolatility()
                if monitor.isVolatile {
                    traderStatus = "SIGNAL SENT"
                }
            }) {
                Text("REFRESH MARKET ALPHA")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
        }
        .padding()
    }
}
