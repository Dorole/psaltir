# CHANGELOG

All notable changes to this project will be documented here.

## [Unreleased]

### 2026-01-27

- Implemented theme save/load.
- Refactored bookmarks save/load to use the same system as settings.
- Added UI button for resetting text settings to defaults.
- Cleaned up main() so it's not as cluttered.
- Added system theme to theme options.
- Minor refactoring of SettingsPage and ThemeProvider.

📷 See [SCREENSHOTS](screenshots/2026-01-27/).
Note that the current design is purely functional, not final.

📋 TO DO:

- Add the rest of the settings and restructure the settings page by functionality.
- Add decorative font and the option to toggle it on/off.
- Implement a custom theme.

### 2026-01-26

- Text settings are applied to the text on the reading page.
- Renamed Accessibility Provider to Text Settings Provider and moved consts from the settings page to the provider because it's more logical for them to be there.
- Implemented saving/loading of text settings.

📋 TO DO:

- <s>Adjust bookmarks save/load to use the same system as settings.</s>
- <s>Clean up main().</s>
- <s>Add UI button for resetting text settings to defaults.</s>

### 2026-01-25

- Added a "Continue reading" button on the home page which is enabled if the reader has initiated a reading session.
- Added functionality to the back button in the settings and bookmarks page - if the reader accessed those pages from the reading page, the back button is enabled and the user can tap it to continue reading.
- Refactored the settings and bookmarks page since there was some repeating logic.

📷 See [SCREENSHOTS](screenshots/2026-01-25/).
Note that the current design is purely functional, not final.

### 2026-01-22

- FINALLY managed to implement swiping and navigating to the next psalm via buttons with a basic animation.
- For this to work I had to refactor ReadingProvider to separate next and previous and to stash neighbouring psalms so that no unexpected behavior can occur. I removed null values from the provider for fields that I don't expect to ever be null after the provider is initialized (Future<String> for psalm texts and int for psalm numbers). There was also the issue of timing the notifyListeners() so I adjusted the way it is called. Realistically, for navigating via buttons, it can be called straight away without issues, but if the user swipes, the notification has to be timed correctly in order to avoid the flicker. It is a bit hacky, but it's good enough, I'm done with this, seriously 🫸
- I also refactored PsalmText which now always shows something instead of showing nothing - showing nothing caused a flicker when the next psalm settles on the screen while the psalm loads. In order to do this, I had to switch back to stateful for this class.
- I had to refactor the way the psalms are rendered in the first place. Now PsalmView uses PageView (as opposed to the simple PsalmText widget which only changed its own content previously).
- I first tried just animating what I had, which was a straight up no because it was one widget which only changed its content and it looked stupid. Then I tried PageView, PageView.builder, LoopPageView and then went back to PageView. This was <u>the biggest challenge so far</u>, I think.
- The animation is a simple one. I wanted the Kindle-style one with page perforation and all, but decided against it in the end. That's now deep in the backlog, but I also think it's unnecessary for such a simple app like this.

### 2026-01-15

- Implemented the option to switch between the light and the dark theme.

📋 TO DO:

- Go over the hard-coded colors and use theme instead.
- <s>Implement the third option - use system theme - and make it a starting theme.</s>
- <s>Persist theme.</s>

📷 See [SCREENSHOTS](screenshots/2026-01-15/).
Note that the current design is purely functional, not final.

### 2026-01-14

It's been a minute :)

- Worked on reading settings - currently I've lumped them all under accessibility, but I think I'll change that name in the future since these settings refer to reading in general. For now it doesn't matter. Settings can currently be managed for the psalm text size, line height and font. Selections are applied in real time only to the demo text, not the actual psalm text.

📋 TO DO:

- <s>Apply the settings to the actual reading page.</s>
- <s>Persist settings.</s>
- <s>Implement other settings - light/dark theme.</s>
- Settings to be implemented in the later stage, but prepare the functionality: turn decorative font on/off (will only be used in titles - app title, psalm titles on the reading page and on the bookmark tiles)
- Make sure the app produces no sound anywhere.
- Consider grouping settings by functionality into expandable tiles or Kindle-app-like cards.

📷 See [VIDEO](screenshots/2026-01-14/).
Note that the current design is purely functional, not final.

### 2025-12-08

- Implemented save/load of bookmarks (Shared Preferences). All that is stored is a simple int list (converted to a string list due to prefs' limitations) so I don't think anything more complicated is needed, at least not right now. Will see what to do when it comes to storing general and accessibility settings.
- Refactored main.dart to implement eager init of BookmarksProvider and prevent the flickering of BookmarksPage the first time it is opened.
- Extended AppPage enum in navigation_models with labels so I can pull the name of the pages from there instead of hard-coding the string for every page.
- Simplified the reading_models (Category enum) by removing the fromString function for conversion of enum to string because apparently there was a built-in enum function for that all along so...

### 2025-12-05

- Implemented Details View. Reading Page will display an info icon in the top bar for psalms that have details. Reading Page can now display two different views: Psalm View and Details View. There is some potential refactoring to consider here because these two views share a lot of logic.
- Minor refactoring of PsalmLoader and ReadingProvider.
- Made main() async to be able to preload psalm metadata and avoid unnecessary async operations.

### 2025-12-02

- Refactored Reading Page so it can display psalm text or psalm details

### 2025-11-29

- Added a customizable top bar on reading, accessibility, settings and bookmarks page
- Buttons on the top bar are currently only visual (except the bookmark button on the reading page)

📋 TO DO:

- <s>Implement returning to the reading page from Settings and Accessibility (and Bookmarks??) if the user opened any of those pages from the reading page</s>
- <s>Save bookmarks</s>
- <s>Consider pairing strings for page headers with page enums and retrieve the pairs from a model</s>

📷 See [SCREENSHOTS](screenshots/2025-11-29/).
Note that the current design is only there so I have something to work with, it's not final.

### 2025-11-27

- Bookmarks now contain everything intended - psalm number, some starting text and a button for discarding a bookmark
- Bookmarks are displayed in numerical order, not chronological
- Changed the design of bookmarks so it looks more like end design (structurally)

📋 TO DO:

- <s>Top banners for reading and bookmarks page</s>
- <s>Details page for psalms on reading page </s>
- <s>Click on bookmark card takes the user to the reading page, from there navigation is +/-1.</s>

📷 See [SCREENSHOTS](screenshots/2025-11-27/).
Note that the current design is only there so I have something to work with, it's not final.

### 2025-11-24

- Moved literals to separate files
- Random mode stores shown psalms so they don't repeat during the same session
- Random mode always shows a random psalm when the user clicks forward or previous (instead of going in order)
- Implemented bookmarks - psalms can be (un)bookmarked from the reading page via an icon button. Bookmark page shows a list of all bookmarked psalms. Psalms can be unbookmarked from the bookmark page.
  Bookmarks and all related logic is stored in BookmarkProvider.

📋 TO DO:

- <s>Extend a bookmark tile so it shows starting psalm text.</s>
- <s>Consider storing bookmarks in an ordered collection.</s>

📷 See [SCREENSHOTS](screenshots/2025-11-24/).
Note that the current design is only there so I have something to work with, it's not final.

### 2025-11-21

- Implemented category mode - a category can be chosen from the dropdown menu. Psalms within a category can be read either in order or randomly. Categories are currently randomly assigned, they aren't necessarily correct.
- Psalm text loader - the reading page now displays the corresponding psalm text.
- Added psalm files up to 110 (courtesy of a helpful husband)

📋 TO DO:

- <s>Swipe to navigate between psalms</s>
- <s>Setup the top banner on the reading page</s>
- <s>BACKLOG: page turn transition/animation</s> - 2026-01-22: there is a basic transition animation for now.

📷 See [SCREENSHOTS](screenshots/2025-11-21/).
Note that the current design is only there so I have something to work with, it's not final.

### 2025-11-19

- Implemented an absolutely basic theme because I got tired of looking at brown and beige
- Started writing a .json file with psalms data. For now, I have decided to go with simple .txt files that contain psalms and a .json file that contains psalms metadata. Perhaps in the future I should move to some kind of local database (which I've never used so far), but I will stick with this simple solution until the need arises for a more complicated one (if it arises). Currently there are 3 psalms. I will use them for setup and slowly fill the data for the rest.

### 2025-11-17

- ReadingPage basic structure
- Implemented basic psalm navigation for random and number reading choices. Currently the app responds the same for both choices - the button for the next psalm displays the next psalm number and the button for previous displays the previous psalm number, depending on the current psalm number.

📋 TO DO:

- <s>Consider: ReadingChoice.random navigation always displays a random psalm, regardless of the current psalm number and direction (forward or back).</s>
- <s>Consider: if the user doesn't exit the app, but navigates away from the reading page, HomePage shows a "Continue Reading" button or an IconButton next to the "Čitaj" button.</s>

### 2025-11-11

- HomePage refactoring (code reorganisation only)
- HomePage design change - the "Čitaj" button and tooltip above it are now positioned at the bottom of the screen
- MainPage: Switched the BottomNavigationBar for a regular Row with IconButtons and added a slight animation

📋 TO DO:

- <s>A .json file with psalms - hook it up with ReadingProvider</s>

📷 See [SCREENSHOTS](screenshots/2025-11-11/).
Note that the current design is only there so I have something to work with, it's not final.

### 2025-11-10

- Refactored MainPage so it can display pages that are not accessible from the bottom navigation bar
- Introduced Navigation Provider and refactored HomePage accordingly
- Hooked up ReadingPage with ReadingProvider so it reads the data from it

📋 TO DO:

- <s>Switch bottom navBar for a regular row with IconButtons for more control</s>

### 2025-11-04

- Refactored HomePage logic into a Provider (initial implementation): moved shared data into Reading Provider, moved enums from HomePage to Reading Models
- Implemented initial navigation to Reading Page.

📋 TO DO:

- <s>Implement the category case in getNextPsalm() in ReadingProvider</s>
- <s>Save psalms from the same session so they don't repeat in random mode</s>

### 2025-10-28

- NavBar holds basic logic and leads to separate pages.
- Functioning radio buttons for psalm category and psalm number.
- A functioning button that will trigger reading. Currently only performs necessary checks and prints the action it will perform.
- Added tooltips to ℹ️ icons.

📋 TO DO:

- <s>Refactor HomePage - separate widgets</s>
- <s>Implement an initial Theme - customize later</s>
- <s>Refactor to use Provider</s>

📷 See [SCREENSHOTS](screenshots/2025-10-28/).
Note that the current design is only there so I have something to work with, it's not final.

### 2025-10-24

- Basic structure and ROUGH design.
- Most widgets only visual, no logic.
