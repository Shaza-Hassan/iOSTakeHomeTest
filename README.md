# iOS Take Home Test

## How to run the app

1. Clone the repository
2. Open the project in Xcode
3. Click on File from the menu bar and select Swift Packages -> Resolve Package Versions
4. Click on the play button to run the app

## Project Overview
This app show list charachter from Rick and Morty API with pagination and filter feature.
The project is using MVVM architecture and Combine framework, the app doesn't depend on storyboard it depend on sepration view controllers and its nib file.
The UI Components are built using UIKit and SwiftUI.

### parts with UIKit:
- CharacterListViewController 
- FilterTableViewCell

### Parts with SwiftUI:
- CharacterListRow
- FilterView
- CharacterDetailView

## Project Structure
The project is divided into the following parts:
- **Shared**: Contains shared Model, extensions and Network Service
- **CharacterList**: Contains the View(View Controller and cells for table view and collection view), ViewModel and Model(Repo for handle calling api) for the Character List screen
- **CharacterDetail**: Contains the View, ViewModel for the Character Detail screen 

## Third Party Libraries
- **Kingfisher**: For Showing and caching images from the url
- **Mockingkit**: For mocking network request

## Unit Test
- **CharacterListViewModelTest**: Test for CharacterListViewModel
 - I want to make a test case for throwing error while calling api but there is no way to throw error from MockingKit or I don't know how to do it, so I just make a test case for success response.
- **CharacterListRepoTest**: Test for CharacterListRepo


