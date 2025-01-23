import SwiftUI
import SnowplowTracker

struct Pill: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let placementMethod: PlacementMethod
}

struct ContentView: View {
    let pills: [Pill] = [
        Pill(name: "Pill 1", color: .red, placementMethod: .placementMethodPersonalization),
        Pill(name: "Pill 2", color: .blue, placementMethod: .placementMethodManual),
        Pill(name: "Pill 3", color: .green, placementMethod: .placementMethodDefault),
        Pill(name: "Pill 4", color: .orange, placementMethod: .placementMethodPersonalization),
        Pill(name: "Pill 5", color: .purple, placementMethod: .placementMethodManual),
        Pill(name: "Pill 6", color: .pink, placementMethod: .placementMethodDefault),
        Pill(name: "Pill 7", color: .yellow, placementMethod: .placementMethodPersonalization),
        Pill(name: "Pill 8", color: .gray, placementMethod: .placementMethodManual),
        Pill(name: "Pill 9", color: .mint, placementMethod: .placementMethodDefault),
        Pill(name: "Pill 10", color: .indigo, placementMethod: .placementMethodPersonalization)
    ]
    
    @State private var currentIndex = 0
    @State private var scrollPosition: UUID?
    @State private var visiblePillIds: Set<UUID> = []
    @State private var hasInitializedVisibility = false
    @State private var isScrolling = false
    @State private var scrollTimer: Timer?
    @State private var navigateToBet = false
    @State private var hasTrackedInitialLoad = false
    @State private var isTrackingInitialLoad = false
    @State private var userId = ""
    @State private var showingUserIdAlert = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Add spacer to push content down
                Spacer()
                    .frame(height: UIScreen.main.bounds.height / 4)
                
                Text("Pop Nav")
                    .font(.system(size: 28, weight: .bold))
                
                pillsScrollView
                
                // Updated User ID section
                VStack(spacing: 10) {
                    Button(action: {
                        // Show alert to get user ID
                        showingUserIdAlert = true
                    }) {
                        Text("Set user_id")
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(
                                Capsule()
                                    .fill(Color.blue)
                            )
                    }
                    
                    // Display current user ID
                    Text("Current user_id: \(userId.isEmpty ? "not set" : userId)")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                .padding(.top, 30)
                .alert("Set User ID", isPresented: $showingUserIdAlert) {
                    TextField("Enter User ID", text: $userId)
                    Button("Cancel", role: .cancel) { }
                    Button("Set") {
                        let tracker = Snowplow.defaultTracker()
                        if userId.isEmpty {
                            // Explicitly set to nil to clear the user ID
                            tracker?.subject?.userId = nil
                            print("User ID cleared")
                        } else {
                            tracker?.subject?.userId = userId
                            print("User ID set to: \(userId)")
                        }
                    }
                } message: {
                    Text("Please enter a user ID (leave empty to clear)")
                }
                
                Spacer()
            }
            .snowplowScreen(name: "homepage")
            .onAppear {
                
                // Reset visibility state
                hasInitializedVisibility = false
                visiblePillIds.removeAll()
                hasTrackedInitialLoad = false
                isTrackingInitialLoad = false
                
                // Wait for the next render cycle to ensure visibility is calculated
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if !hasTrackedInitialLoad && !isTrackingInitialLoad {
                        isTrackingInitialLoad = true  // Set flag before tracking
                        trackInitialLoadEvent()
                    }
                }
            }
        }
    }
    
    private var pillsScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                LazyHStack(spacing: 15) {
                    ForEach(pills) { pill in
                        let pillIndex = pills.firstIndex { $0.id == pill.id } ?? 0
                        NavigationLink {
                            BetView()
                        } label: {
                            PillView(
                                pill: pill,
                                position: pillIndex,
                                isVisible: visiblePillIds.contains(pill.id)
                            )
                        }
                        .id(pill.id)
                        .overlay {
                            GeometryReader { proxy in
                                Color.clear
                                    .onAppear {
                                        checkVisibility(for: pill.id, with: proxy)
                                    }
                                    .onChange(of: proxy.frame(in: .global)) { frame in
                                        checkVisibility(for: pill.id, with: proxy)
                                    }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .scrollTargetLayout()
        }
        .background(
            Rectangle()
                .fill(Color(.systemGray6))
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
        .frame(height: 60)
        .simultaneousGesture(
            DragGesture()
                .onChanged { _ in
                    isScrolling = true
                    scrollTimer?.invalidate()
                    
                    scrollTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                        if isScrolling {
                            isScrolling = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                trackScrollEvent()
                            }
                        }
                    }
                }
        )
    }
    
    private func trackInitialLoadEvent() {
        guard !hasTrackedInitialLoad else {
            return
        }
        
        print("trackInitialLoadEvent called")
        hasTrackedInitialLoad = true  // Set flag immediately
        
        let tracker = Snowplow.defaultTracker()
        
        // Create banner elements for all pills
        let bannerElements = pills.enumerated().map { index, pill in
            BannerElement(
                elementVizType: .text,
                label: pill.name,
                onScreen: visiblePillIds.contains(pill.id),
                placementMethod: pill.placementMethod,
                position: index
            )
        }
        
        // Create the initial load event with the first pill
        let initialLoadEvent = BannerInteractionPopNavInitialLoad(
            bannerAction: .initialLoad,
            bannerName: .popNav
        ).toPopNavInitialLoadSpec(bannerElements[0])
        
        // Add the remaining banner elements as entities, skipping the first one
        bannerElements.dropFirst().forEach { element in
            initialLoadEvent.entities.append(element.toEntity())
        }
        
        // Track the event
        _ = tracker?.track(initialLoadEvent)
    }
    
    private func trackScrollEvent() {
        // Add a print to debug visibility states
        print("Visible pills: \(visiblePillIds.count)")
        pills.forEach { pill in
            print("\(pill.name): \(visiblePillIds.contains(pill.id))")
        }
        
        print("trackScrollEvent called")
        
        let tracker = Snowplow.defaultTracker()
        
        // Create banner elements for all pills
        let bannerElements = pills.enumerated().map { index, pill in
            BannerElement(
                elementVizType: .text,
                label: pill.name,
                onScreen: visiblePillIds.contains(pill.id),
                placementMethod: pill.placementMethod,
                position: index
            )
        }
        
        // Create the scroll event with the first pill
        let scrollEvent = BannerInteractionPopNavScroll(
            bannerAction: .scroll,
            bannerName: .popNav
        ).toPopNavScrollSpec(bannerElements[0])
        
        // Add the remaining banner elements as entities, skipping the first one
        bannerElements.dropFirst().forEach { element in
            scrollEvent.entities.append(element.toEntity())
        }
        
        // Track the event
        _ = tracker?.track(scrollEvent)
    }
    
    private func checkVisibility(for pillId: UUID, with proxy: GeometryProxy) {
        let frame = proxy.frame(in: .global)
        
        // Get screen bounds and safe area
        let screenBounds = UIScreen.main.bounds
        let safeAreaInsets = UIApplication.shared.windows.first?.safeAreaInsets ?? .zero
        let visibleBounds = CGRect(
            x: screenBounds.origin.x + safeAreaInsets.left,
            y: screenBounds.origin.y + safeAreaInsets.top,
            width: screenBounds.width - (safeAreaInsets.left + safeAreaInsets.right),
            height: screenBounds.height - (safeAreaInsets.top + safeAreaInsets.bottom)
        )
        
        let intersection = frame.intersection(visibleBounds)
        let visibilityThreshold = frame.width * 0.75
        let isVisible = !intersection.isNull && intersection.width >= visibilityThreshold
        
        // Update visibility state
        DispatchQueue.main.async {
            if isVisible {
                visiblePillIds.insert(pillId)
            } else {
                visiblePillIds.remove(pillId)
            }
        }
        
        if !hasInitializedVisibility {
            hasInitializedVisibility = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                trackInitialLoadEvent()
            }
        }
    }
}

struct PillView: View {
    let pill: Pill
    let position: Int
    let isVisible: Bool
    @State private var isPressed = false
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1
    @State private var navigateToBet = false
    
    var body: some View {
        Text(pill.name)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(
                Capsule()
                    .fill(pill.color)
            )
            .shadow(radius: isPressed ? 1 : 3)
            .scaleEffect(scale)
            .rotationEffect(.degrees(rotation))
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
            .onTapGesture {
                print("trackClickEvent called")
                
                withAnimation {
                    isPressed = true
                    scale = 0.8
                    rotation = 5
                }
                
                let tracker = Snowplow.defaultTracker() 
                // Create the click event
                let clickEvent = BannerInteractionPopNavClick(
                    bannerAction: .click,
                    bannerName: .popNav
                ).toPopNavClickSpec(
                    BannerElement(
                        elementVizType: .text,
                        label: pill.name,
                        onScreen: isVisible,
                        placementMethod: pill.placementMethod,
                        position: position
                    )
                )
                
                // Track the event
                _ = tracker?.track(clickEvent)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        isPressed = false
                        scale = 1
                        rotation = 0
                    }
                    navigateToBet = true
                }
            }
            .background(
                NavigationLink(
                    destination: BetView(),
                    isActive: $navigateToBet
                ) {
                    EmptyView()
                }
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func onScrollEdgeChanged(perform action: @escaping () -> Void) -> some View {
        self.simultaneousGesture(
            DragGesture()
                .onChanged { _ in
                    action()
                }
        )
    }
}

