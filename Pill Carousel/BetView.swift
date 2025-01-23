import SwiftUI
import SnowplowTracker
import Foundation

struct BetView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isHovered = false
    @State private var isPressed = false
    @State private var rotationAngle = 0.0
    @State private var scale = 1.0
    
    var body: some View {
        VStack(spacing: 30) {
            Button(action: {
                dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .foregroundColor(.blue)
                .padding()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Button(action: {
                // Trigger multiple animations
                withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                    isPressed = true
                    scale = 0.8
                    rotationAngle = 360
                }
                
                // Track the sports bet event
                trackSportsBetEvent()
                
                // Reset animations with a sequence
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        isPressed = false
                        scale = 1.0
                        rotationAngle = 0
                    }
                }
            }) {
                Text("Bet Life Savings")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        Capsule()
                            .fill(Color.yellow)
                            .shadow(
                                color: .black.opacity(isPressed ? 0.1 : 0.3),
                                radius: isPressed ? 5 : 10,
                                x: 0,
                                y: isPressed ? 2 : 5
                            )
                    )
                    .scaleEffect(scale)
                    .rotation3DEffect(
                        .degrees(rotationAngle),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
            }
            .onHover { hovering in
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isHovered = hovering
                }
            }
            .onAppear {
                // Create a continuous pulsing animation
                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                    isHovered = true
                }
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
        .snowplowScreen(name: "bet_page")
    }
    
    private func trackSportsBetEvent() {
        print("trackSportsBetEvent called")
        
        let tracker = Snowplow.defaultTracker()
        
        // Generate random bet amount between 50 and 10000
        let betAmount = Int.random(in: 50...10000)
        
        // Create and track the sports bet event
        let sportsBetEvent = PlaceBetSportsBet(
            amount: betAmount,
            type: TypeEnum.sports
        ).toSportsBetSpec()
        
        // Track the event
        _ = tracker?.track(sportsBetEvent)
    }
}

struct BetView_Previews: PreviewProvider {
    static var previews: some View {
        BetView()
    }
} 