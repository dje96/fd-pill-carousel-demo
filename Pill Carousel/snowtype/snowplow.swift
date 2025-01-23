import Foundation
import SnowplowTracker


// MARK: - BannerElement

/// Data structure of an entity for contextual information about the banner
/// Schema: `iglu:com.fanduel/banner_element/jsonschema/1-0-0`
///
/// Example:
/// ```swift
/// let data = BannerElement(
///     elementVizType: elementVizType, 
///     label: label, 
///     modelName: modelName, 
///     onScreen: onScreen, 
///     personalizationCohort: personalizationCohort, 
///     placementMethod: placementMethod, 
///     position: position
/// )
/// // Track as an event
/// Snowplow.defaultTracker()?.track(data.toEvent())
/// // Add as an entity to another event
/// let event = ScreenView(name: "Product")
/// event.entities.append(data.toEntity())
/// Snowplow.defaultTracker()?.track(event)
/// ```
struct BannerElement {

        /// The type of visual that was displayed to the user
        var elementVizType: ElementVizType?
        /// The label on the element that is displayed to the user
        var label: String
        /// The name of the personalization model used
        var modelName: String?
        /// If the element was visible to the user
        var onScreen: Bool
        /// The cohort the user is in to determine personalized content
        var personalizationCohort: String?
        /// How the order in the carousel was determined
        var placementMethod: PlacementMethod
        /// The position of the element in the carousel
        var position: Int

        private var schema: String {
                return "iglu:com.fanduel/banner_element/jsonschema/1-0-0"
        }

        private var payload: [String : Any] {
                var payload: [String : Any] = [:]
                if let elementVizType = elementVizType {
                        payload["element_viz_type"] = elementVizType.rawValue
                }
                payload["label"] = label
                if let modelName = modelName {
                        payload["model_name"] = modelName
                }
                payload["on_screen"] = onScreen
                if let personalizationCohort = personalizationCohort {
                        payload["personalization_cohort"] = personalizationCohort
                }
                payload["placement_method"] = placementMethod.rawValue
                payload["position"] = position
                return payload
        }

        /// Creates an event instance to be tracked by the tracker.
        func toEvent() -> SelfDescribing {
                return SelfDescribing(schema: schema, payload: payload)
        }

        /// Creates an entity that can be added to events.
        func toEntity() -> SelfDescribingJson {
                return SelfDescribingJson(schema: schema, andData: payload)
        }

}

// MARK: - PlaceBetSportsBet

/// Data structure for when a bet is placed - Generated from a property rule
/// Schema: `iglu:com.fanduel/place_bet/jsonschema/1-0-0`
///
/// Example:
/// ```swift
/// let data = PlaceBetSportsBet(
///     amount: amount, 
///     type: type
/// )
/// // Track as an event
/// Snowplow.defaultTracker()?.track(data.toEvent())
/// // Add as an entity to another event
/// let event = ScreenView(name: "Product")
/// event.entities.append(data.toEntity())
/// Snowplow.defaultTracker()?.track(event)
/// ```
struct PlaceBetSportsBet {

        /// The amount of the bet
        var amount: Int
        /// The type of bet being placed should be "sports"
        var type: TypeEnum

        private var schema: String {
                return "iglu:com.fanduel/place_bet/jsonschema/1-0-0"
        }

        private var payload: [String : Any] {
                var payload: [String : Any] = [:]
                payload["amount"] = amount
                payload["type"] = type.rawValue
                return payload
        }

        /// Creates an event instance to be tracked by the tracker.
        func toEvent() -> SelfDescribing {
                return SelfDescribing(schema: schema, payload: payload)
        }

        /// Creates an entity that can be added to events.
        func toEntity() -> SelfDescribingJson {
                return SelfDescribingJson(schema: schema, andData: payload)
        }

}

// MARK: - BannerInteractionPopNavScroll

/// Data structure for an event that captures interactions with banners or carousels - Generated from a property rule
/// Schema: `iglu:com.fanduel/banner_interaction/jsonschema/1-0-0`
///
/// Example:
/// ```swift
/// let data = BannerInteractionPopNavScroll(
///     bannerAction: bannerAction, 
///     bannerName: bannerName
/// )
/// // Track as an event
/// Snowplow.defaultTracker()?.track(data.toEvent())
/// // Add as an entity to another event
/// let event = ScreenView(name: "Product")
/// event.entities.append(data.toEntity())
/// Snowplow.defaultTracker()?.track(event)
/// ```
struct BannerInteractionPopNavScroll {

        /// When the user interacted with the banner
        var bannerAction: BannerInteractionPopNavScrollBannerAction
        /// When the user interacted with the banner
        var bannerName: BannerName

        private var schema: String {
                return "iglu:com.fanduel/banner_interaction/jsonschema/1-0-0"
        }

        private var payload: [String : Any] {
                var payload: [String : Any] = [:]
                payload["banner_action"] = bannerAction.rawValue
                payload["banner_name"] = bannerName.rawValue
                return payload
        }

        /// Creates an event instance to be tracked by the tracker.
        func toEvent() -> SelfDescribing {
                return SelfDescribing(schema: schema, payload: payload)
        }

        /// Creates an entity that can be added to events.
        func toEntity() -> SelfDescribingJson {
                return SelfDescribingJson(schema: schema, andData: payload)
        }

}

// MARK: - BannerInteractionPopNavClick

/// Data structure for an event that captures interactions with banners or carousels - Generated from a property rule
/// Schema: `iglu:com.fanduel/banner_interaction/jsonschema/1-0-0`
///
/// Example:
/// ```swift
/// let data = BannerInteractionPopNavClick(
///     bannerAction: bannerAction, 
///     bannerName: bannerName
/// )
/// // Track as an event
/// Snowplow.defaultTracker()?.track(data.toEvent())
/// // Add as an entity to another event
/// let event = ScreenView(name: "Product")
/// event.entities.append(data.toEntity())
/// Snowplow.defaultTracker()?.track(event)
/// ```
struct BannerInteractionPopNavClick {

        /// When the user interacted with the banner
        var bannerAction: BannerInteractionPopNavClickBannerAction
        /// When the user interacted with the banner
        var bannerName: BannerName

        private var schema: String {
                return "iglu:com.fanduel/banner_interaction/jsonschema/1-0-0"
        }

        private var payload: [String : Any] {
                var payload: [String : Any] = [:]
                payload["banner_action"] = bannerAction.rawValue
                payload["banner_name"] = bannerName.rawValue
                return payload
        }

        /// Creates an event instance to be tracked by the tracker.
        func toEvent() -> SelfDescribing {
                return SelfDescribing(schema: schema, payload: payload)
        }

        /// Creates an entity that can be added to events.
        func toEntity() -> SelfDescribingJson {
                return SelfDescribingJson(schema: schema, andData: payload)
        }

}

// MARK: - BannerInteractionPopNavInitialLoad

/// Data structure for an event that captures interactions with banners or carousels - Generated from a property rule
/// Schema: `iglu:com.fanduel/banner_interaction/jsonschema/1-0-0`
///
/// Example:
/// ```swift
/// let data = BannerInteractionPopNavInitialLoad(
///     bannerAction: bannerAction, 
///     bannerName: bannerName
/// )
/// // Track as an event
/// Snowplow.defaultTracker()?.track(data.toEvent())
/// // Add as an entity to another event
/// let event = ScreenView(name: "Product")
/// event.entities.append(data.toEntity())
/// Snowplow.defaultTracker()?.track(event)
/// ```
struct BannerInteractionPopNavInitialLoad {

        /// When the user interacted with the banner
        var bannerAction: BannerInteractionPopNavInitialLoadBannerAction
        /// When the user interacted with the banner
        var bannerName: BannerName

        private var schema: String {
                return "iglu:com.fanduel/banner_interaction/jsonschema/1-0-0"
        }

        private var payload: [String : Any] {
                var payload: [String : Any] = [:]
                payload["banner_action"] = bannerAction.rawValue
                payload["banner_name"] = bannerName.rawValue
                return payload
        }

        /// Creates an event instance to be tracked by the tracker.
        func toEvent() -> SelfDescribing {
                return SelfDescribing(schema: schema, payload: payload)
        }

        /// Creates an entity that can be added to events.
        func toEntity() -> SelfDescribingJson {
                return SelfDescribingJson(schema: schema, andData: payload)
        }

}

// MARK: - Event Specification

/// Entity schema for referencing an event specification
/// Schema: `iglu:com.snowplowanalytics.snowplow/event_specification/jsonschema/1-0-2`
///
/// Example:
/// ```swift
/// let data = EventSpecification(
///     id: id,
///     name: name,
///     dataProductId: dataProductId,
///     dataProductName: dataProductName
/// )
/// // Track as an event
/// Snowplow.defaultTracker()?.track(data.toEvent())
/// // Add as an entity to another event
/// let event = ScreenView(name: "Product")
/// event.entities.append(data.toEntity())
/// Snowplow.defaultTracker()?.track(event)
/// ```
struct EventSpecification {

        /// Identifier for the event specification that the event adheres
        var id: String

        /// Name for the event specification that the event adheres to
        var name: String

        /// Identifier for the data product that the event specification belongs to
        var dataProductId: String

        /// Name for the data product that the event specification belongs to
        var dataProductName: String

        private var schema: String {
                return "iglu:com.snowplowanalytics.snowplow/event_specification/jsonschema/1-0-2"
        }

        private var payload: [String : Any] {
                var payload: [String : Any] = [:]
                payload["id"] = id
                payload["name"] = name
                payload["data_product_id"] = dataProductId
                payload["data_product_name"] = dataProductName
                return payload
        }

        /// Creates an event instance to be tracked by the tracker.
        func toEvent() -> SelfDescribing {
                return SelfDescribing(schema: schema, payload: payload)
        }

        /// Creates an entity that can be added to events.
        func toEntity() -> SelfDescribingJson {
                return SelfDescribingJson(schema: schema, andData: payload)
        }

}

// MARK: - ElementVizType

/// The type of visual that was displayed to the user
enum ElementVizType: String {
        case graphic = "graphic"
        case icon = "icon"
        case other = "other"
        case text = "text"
}

// MARK: - PlacementMethod

/// How the order in the carousel was determined
public enum PlacementMethod: String {
        case placementMethodManual = "manual"
        case placementMethodPersonalization = "personalization"
        case placementMethodDefault = "default"
}

// MARK: - TypeEnum

/// The type of bet being placed should be "sports"
enum TypeEnum: String {
        case sports = "sports"
}

// MARK: - BannerInteractionPopNavScrollBannerAction

/// When the user interacted with the banner
enum BannerInteractionPopNavScrollBannerAction: String {
        case scroll = "scroll"
}

// MARK: - BannerName

/// When the user interacted with the banner
enum BannerName: String {
        case popNav = "pop_nav"
}

// MARK: - BannerInteractionPopNavClickBannerAction

/// When the user interacted with the banner
enum BannerInteractionPopNavClickBannerAction: String {
        case click = "click"
}

// MARK: - BannerInteractionPopNavInitialLoadBannerAction

/// When the user interacted with the banner
enum BannerInteractionPopNavInitialLoadBannerAction: String {
        case initialLoad = "initial_load"
}

extension PlaceBetSportsBet {
        /// Creates an event with entities for a SportsBet event specification.
        /// ID: 34315b63-46a9-4dfd-b559-8b6c0f808fc9
        /// Example:
        /// ```swift
        /// let data = PlaceBetSportsBet(...)
        /// let event = data.toSportsBetSpec()
        /// // Track as an event
        /// Snowplow.defaultTracker()?.track(event)
        /// ```
        func toSportsBetSpec() -> SelfDescribing {
                let event = toEvent()
                let eventSpec = EventSpecification(
                        id: "34315b63-46a9-4dfd-b559-8b6c0f808fc9",
                        name: "sports_bet",
                        dataProductId: "9aa8aeb2-4299-4054-9ff2-f177040bebf6",
                        dataProductName: "Sportsbook Personalization Modules"
                )
                event.entities.append(eventSpec.toEntity())
                return event
        }
}

extension BannerInteractionPopNavScroll {
        /// Creates an event with entities for a PopNavScroll event specification.
        /// ID: 6ddffe7a-e2e3-4022-bee0-7bb20e8335a1
        /// Example:
        /// ```swift
        /// let data = BannerInteractionPopNavScroll(...)
        /// let dataBannerElement = BannerElement(...)
        /// let event = data.toPopNavScrollSpec(dataBannerElement)
        /// // Track as an event
        /// Snowplow.defaultTracker()?.track(event)
        /// ```
        func toPopNavScrollSpec(_ entityBannerElement: BannerElement) -> SelfDescribing {
                let event = toEvent()
                let eventSpec = EventSpecification(
                        id: "6ddffe7a-e2e3-4022-bee0-7bb20e8335a1",
                        name: "pop_nav_scroll",
                        dataProductId: "9aa8aeb2-4299-4054-9ff2-f177040bebf6",
                        dataProductName: "Sportsbook Personalization Modules"
                )
                event.entities.append(entityBannerElement.toEntity())
                event.entities.append(eventSpec.toEntity())
                return event
        }
}

extension BannerInteractionPopNavClick {
        /// Creates an event with entities for a PopNavClick event specification.
        /// ID: 8169f58a-8233-43f2-b5c2-df56fce03bb6
        /// Example:
        /// ```swift
        /// let data = BannerInteractionPopNavClick(...)
        /// let dataBannerElement = BannerElement(...)
        /// let event = data.toPopNavClickSpec(dataBannerElement)
        /// // Track as an event
        /// Snowplow.defaultTracker()?.track(event)
        /// ```
        func toPopNavClickSpec(_ entityBannerElement: BannerElement) -> SelfDescribing {
                let event = toEvent()
                let eventSpec = EventSpecification(
                        id: "8169f58a-8233-43f2-b5c2-df56fce03bb6",
                        name: "pop_nav_click",
                        dataProductId: "9aa8aeb2-4299-4054-9ff2-f177040bebf6",
                        dataProductName: "Sportsbook Personalization Modules"
                )
                event.entities.append(entityBannerElement.toEntity())
                event.entities.append(eventSpec.toEntity())
                return event
        }
}

extension BannerInteractionPopNavInitialLoad {
        /// Creates an event with entities for a PopNavInitialLoad event specification.
        /// ID: b7d09847-9031-42b4-867e-a0ae7d5fecc6
        /// Example:
        /// ```swift
        /// let data = BannerInteractionPopNavInitialLoad(...)
        /// let dataBannerElement = BannerElement(...)
        /// let event = data.toPopNavInitialLoadSpec(dataBannerElement)
        /// // Track as an event
        /// Snowplow.defaultTracker()?.track(event)
        /// ```
        func toPopNavInitialLoadSpec(_ entityBannerElement: BannerElement) -> SelfDescribing {
                let event = toEvent()
                let eventSpec = EventSpecification(
                        id: "b7d09847-9031-42b4-867e-a0ae7d5fecc6",
                        name: "pop_nav_initial_load",
                        dataProductId: "9aa8aeb2-4299-4054-9ff2-f177040bebf6",
                        dataProductName: "Sportsbook Personalization Modules"
                )
                event.entities.append(entityBannerElement.toEntity())
                event.entities.append(eventSpec.toEntity())
                return event
        }
}

