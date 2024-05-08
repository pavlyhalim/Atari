# Atari-FlipDot-Revival

## Overview
This project aims to bring classic Atari games back to life with a modern twist, utilizing physical buttons for controls and a unique flip-dot display for visuals.

## Getting Started

### Hardware Requirements
- Arduino Uno
- Buttons (4)
- Wires
- Resistors
- Flip-dots display panel

### Software Requirements
- Processing ([Processing Website](https://processing.org/))

### Installation
1. Clone or download this repository.
2. Install Processing and ensure you have the necessary libraries installed (refer to the code for specific libraries).
3. Connect the buttons to the Arduino as per the circuit diagram (you can create one based on the code).
4. Connect the Arduino to your computer and upload the `arduino.ino` sketch.
5. Open the Processing project and configure the `config.pde` file with the correct serial port and flip-dot panel settings.
6. Run the Processing sketch to start playing!

## How it Works
- **Buttons**: The Arduino reads the button presses and sends the data to the Processing sketch via serial communication.
- **Processing**: The Processing sketch handles game logic, generates visuals, and communicates with the flip-dots display through another serial connection.
- **Flip-dots**: The flip-dots display panel receives data from Processing and renders the visuals for the games.

## Included Games
- Tetris
- Snake

## Future Possibilities
- Expand the game library with more Atari classics or custom-designed games.
- Enhance visuals with animation and graphical effects.
- Refine the user interface and menu system.

## Code Structure
- `arduino.ino`: Arduino code for reading button states and sending data via serial.
- `FlipDot.pde`, `Panel.pde`: Libraries for controlling the flip-dots display.
- `SnakeGame.pde`, `games_tetris.pde`: Game logic and visuals for Snake and Tetris.
- `cast.pde`: Handles communication with the flip-dot display.
- `config.pde`: Configuration settings for serial ports and flip-dot panels.
- `stage.pde`: Manages game states and transitions.
- `ui.pde`: User interface elements.

"""
