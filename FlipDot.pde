
Serial arduinoPort;
int[] buttonStates = new int[4]; 
String screenState = "start";


void setup() {
  size(1080, 720, P2D);
  frameRate(30);
  colorMode(RGB, 255, 255, 255, 1);
  cast_setup();  
  config_setup(); 
  stages_setup(); 
  ui_setup();

  arduinoPort = new Serial(this, "/dev/cu.usbmodem101", 9600);
  snakeGame = new SnakeGame(); 
}

void draw() {
  background(59);

  virtualDisplay.beginDraw();
  virtualDisplay.background(0);

  switch(screenState) {
        case "start":
            snakeGame.start_screen();
            break;
        case "menu":
            snakeGame.game_menu();
            break;
        case "tetris":
            games_tetris();
            break;
        case "snake":
            games_snake();
            break;
    }

  virtualDisplay.endDraw();
  
  ui_render();  
  stage_process(); 
  cast_broadcast();
}

void serialEvent(Serial p) {
  if (p == arduinoPort) {
    String val = arduinoPort.readStringUntil('\n');  // Read the data from the serial port up to a newline character
    if (val != null) {
      val = trim(val);  // Remove any whitespace or newline characters
      String[] numbers = split(val, ','); 
      if (numbers.length == 4) { 
        int[] newButtonStates = new int[4];
        for (int i = 0; i < numbers.length; i++) {
          try {
            newButtonStates[i] = Integer.parseInt(numbers[i]);
          } catch (NumberFormatException e) {
            System.err.println("Error parsing button state: " + numbers[i]);
            return; 
          }
        }
        switch(screenState) {
            case "start":
              snakeGame.updateButtonStates(newButtonStates);
                break;
            case "menu":
                snakeGame.updateButtonStates(newButtonStates);
                break;
            case "tetris":
                tetris.updateButtonStates(newButtonStates);
                break;
            case "snake":
                snakeGame.updateButtonStates(newButtonStates);
                break;
        }
      }
    }
  }
}

