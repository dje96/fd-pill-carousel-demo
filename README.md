# Pill Carousel Demo App

A SwiftUI demo application showcasing Snowplow tracking with a interactive pill-shaped carousel. This app demonstrates out-of-the-box snowplow events and custom events and entities implemented using Snowtype.

## Features

- Interactive pill-shaped carousel
- Snowplow tracking:
  - Carousel interaction events (click, scroll, load)
  - Sports bet event
  - Screen view events
  - Lifecycle events

## Prerequisites

- Xcode 14.0 or later
- iOS 15.0 or later

## Configuraiton

- This app is configured to send events to Snowplow Micro (http://127.0.0.1:9090)
- Specify a new collector by editing the "endpoint" setting in Pill_CarouselApp.swift

## Installation

1. Clone the repository
2. Open the .xcodeproj file in Xcode
3. Run the project in Xcode
