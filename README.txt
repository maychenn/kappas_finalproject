Bon Mappetit
Created by May Chen and Christina Hoang
December 9, 2019

This app helps indecisive people choose a restaurant to eat at, within walking distance. It uses the Google Places API to return restaurant results. The user can go through the options and like/dislike them. If the user does not "like" a restaurant and reaches the end of the results, the user is told that they have exhausted all options. There is a table view displaying Core Data. Core Data includes all the viewed restaurants and if they were liked/disliked. An entry can be deleted by swiping to the left.

To use app:
1. Open and press pin button
2. Press the thumbs up to "like," thumbs down to "dislike"
	Dislike will refresh the options and save/update the entry in Core Data
	Like will save/update the entry in Core Data and then open up a map with a route 	to the location
3. Press on bookmark button in navigation controller to go to table view and see all past entries
4. Swipe left to delete


Multiple views: 4
Core Data: stores past entries and updates likes/dislikes
Core Graphics: custom buttons and map pin
Additional frameworks: Core Location, Map Kit
Network functionality: Google Places API