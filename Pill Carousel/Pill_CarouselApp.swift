import SwiftUI
import SnowplowTracker

@main
struct Pill_Carousel_App: App {
    init() {
        // Initialize Snowplow Tracker
        _ = Snowplow.createTracker(
            namespace: "ns",
            endpoint: "http://127.0.0.1:9090"
            // http://127.0.0.1:9090 - Localhost

        ) {
            TrackerConfiguration(appId: "pill-carousel-ios")
                .base64Encoding(false)
                .sessionContext(true)
                .platformContext(true)
                .lifecycleAutotracking(true)
                .screenViewAutotracking(true)
                .screenContext(true)
                .applicationContext(true)
                .exceptionAutotracking(true)
                .installAutotracking(true)
                .userAnonymisation(false)
                .immersiveSpaceContext(true)
            SessionConfiguration(
                foregroundTimeout: Measurement(value: 30, unit: .minutes),
                backgroundTimeout: Measurement(value: 30, unit: .minutes))
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
