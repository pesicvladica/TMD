#TheMovieDatabase App

iOS application which allows us to browse movies or TV shows from The Movie Database (TMDb) using provided API. 
The project uses modular design implementing VIPER architecture and emphasizing separation of concerns, reusability, and scalability.

#To build and run the project:

##1. Clone the repository

    git clone https://github.com/your-username/TheMovieDatabaseApp.git
    cd TheMovieDatabaseApp

##2. Install dependencies

    Make sure CocoaPods is installed:

        sudo gem install cocoapods

    Then run:

        pod install

##3. Provide API Key

    Create a Config.xcconfig file inside the TMDApplication/ directory with the following content:

        API_KEY = your_tmdb_api_key_here

##4. Open the workspace

    Open TheMovieDatabase.xcworkspace

#Project Structure & Architecture

##The project is divided into two main parts:

###1. TheMovieDatabase Swift Package
    A modular library that encapsulates:
        Models: Decodable types for TMDb data.
        Protocols: Abstractions for testability and extensibility.
        Networking: Handles requests to the TMDb API.
        MediaType: Enum for different types of media (movie, TV).

    The architecture here is clean service layer, with protocol oriented design. 
    Encapsulated networking logic behind protocols.

###2. TMDApplication
    Implements VIPER architecture structured as:
        View: SwiftUI components.
        Interactor: Data fetching.
        Presenter: Prepares data for the view.
        Router: Navigation logic.
        
        Module: Assembles and wires the VIPER components.

#Libraries Used

    ##Combine
        Used for reactive programming, particularly in managing async data flows between layers, fetching and updating views.

    ##SwiftUI
        Declarative UI framework for building views used across the entire application for rendering the UI layer.

    ##SDWebImageSwiftUI
        Used for image caching and async loading to present poster images efficiently.
