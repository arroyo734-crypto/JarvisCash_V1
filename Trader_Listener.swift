import Foundation

class TraderListener {
    func startListening() {
        let server = TCPServer(host: "localhost", port: 18790) { (data, clientInfo) in
            guard let request = String(data: data, encoding: .utf8), let tradeRequest = TradeRequest(fromJSONString: request) else {
                print("Invalid request received")
                return
            }
            
            self.executeTrade(tradeRequest)
        }
        
        server?.listen { error in
            if let error = error {
                print("Error starting TCP server: \(error)")
            } else {
                print("TCP server started successfully, listening on port 18790")
            }
        }
    }
    
    private func executeTrade(_ tradeRequest: TradeRequest) {
        // Placeholder logic to simulate executing a trade
        print("Executing trade request: \(tradeRequest)")
        // Code to actually place the trade would go here
    }
}

struct TradeRequest: Codable {
    var symbol: String
    var action: String
    var quantity: Double
    
    init?(fromJSONString jsonString: String) {
        if let jsonData = jsonString.data(using: .utf8), 
           let decodedRequest = try? JSONDecoder().decode(TradeRequest.self, from: jsonData) {
            self = decodedRequest
        } else {
            return nil
        }
    }
}