# ShinyNumberMemoryGame

A Shiny application to play the number memory game — a challenging brain game where players must remember and recall sequences of numbers that increase in difficulty.

## Overview

ShinyNumberMemoryGame is an interactive web application built with R Shiny that implements a classic number memory challenge. Players are shown a sequence of numbers and must recall them correctly. As you progress, the sequences become longer and more complex, testing your memory and concentration.

## Features

- **Interactive Gameplay**: Play directly in your web browser
- **Progressive Difficulty**: Game difficulty increases with each successful round
- **User-Friendly Interface**: Clean, intuitive interface built with Shiny
- **Score Tracking**: Keep track of your performance

## Technology Stack

- **R** — Core language
- **Shiny** — Interactive web framework for R
- **R Interactive Web Applications** — Real-time gameplay feedback

## Getting Started

### Prerequisites

- R (version 3.5.0 or later)
- Shiny package

### Installation

1. Clone the repository:
```bash
git clone https://github.com/AlemuTA/ShinyNumberMemoryGame.git
cd ShinyNumberMemoryGame
```

2. Install required packages (if not already installed):
```r
install.packages("shiny")
```

3. Run the Shiny app:
```r
shiny::runApp()
```

The app will open in your default web browser.

## How to Play

1. Start the game by clicking the "Play" button
2. Watch and memorize the sequence of numbers displayed
3. Recall the sequence in the correct order
4. Each successful round adds another number to the sequence
5. Continue until you make a mistake!

## Project Structure

```
ShinyNumberMemoryGame/
├── README.md              # Project documentation
├── DESCRIPTION.md         # Detailed project description
├── app.R                  # Main Shiny application file
├── ui.R                   # User interface definitions (if separated)
├── server.R               # Server logic (if separated)
└── www/                   # Static assets (CSS, images, etc.)
```

## Contributing

Contributions are welcome! Feel free to fork this repository and submit pull requests with improvements.

## License

This project is open source and available under the MIT License.

## Author

Created by [AlemuTA](https://github.com/AlemuTA)

---

**Enjoy the game and challenge your memory! 🧠**
