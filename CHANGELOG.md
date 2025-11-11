# CHANGELOG

All notable changes to this project will be documented here.

## [Unreleased]

### 2025-11-11

- HomePage refactoring (code reorganisation only)
- HomePage design change - the "Čitaj" button and tooltip above it are now positioned at the bottom of the screen
- MainPage: Switched the BottomNavigationBar for a regular Row with IconButtons and added a slight animation

📋 TO DO:

- A .json file with psalms - hook it up with ReadingProvider

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

- Implement the category case in getNextPsalm() in ReadingProvider
- Save psalms from the same sessions so they don't repeat in random mode

### 2025-10-28

- NavBar holds basic logic and leads to separate pages.
- Functioning radio buttons for psalm category and psalm number.
- A functioning button that will trigger reading. Currently only performs necessary checks and prints the action it will perform.
- Added tooltips to ℹ️ icons.

📋 TO DO:

- <s>Refactor HomePage - separate widgets</s>
- [?] Keep HomePage state when navigating to another page then back
- Implement an initial Theme - customize later
- <s>Refactor to use Provider</s>

📷 See [SCREENSHOTS](screenshots/2025-10-28/).
Note that the current design is only there so I have something to work with, it's not final.

### 2025-10-24

- Basic structure and ROUGH design.
- Most widgets only visual, no logic.
