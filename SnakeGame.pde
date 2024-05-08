
SnakeGame snakeGame = new SnakeGame();

void games_snake() {
  snakeGame.update();
  snakeGame.draw();
}
class SnakeGame {
    ArrayList<PVector> snake;
    PVector food;
    int direction = 2;
    float speed = 4.0; //Game speed 
    int scale = 2;      //scale of game per dot 
    int board_width = 14;   //width of game board 
    int board_height = 14;  //height of game board 

    boolean input_left = false;
    boolean input_right = false;
    boolean input_down = false;
    boolean input_up = false;
    boolean gameOver = false;
    boolean buttonReady = true;
    long last_input_time = 0; 
    float anim_progress = 0.0;
    long menuStartTime = 0;
    int menuDelay = 3000;


    int[] buttonStates = new int[4]; // Array to store button states

    SnakeGame() {
        restart();
    }

    // Initialize or reset the game to its initial state
void restart() {
        snake = new ArrayList<PVector>();
        snake.add(new PVector(board_width / 2, board_height / 2));
        placeFood();
        direction = 2;
        gameOver = false;
        anim_progress = 0.0;
    }

    // Update game logic
    void update() {
        if (!gameOver) {
            handleInput();
            if (millis() - last_input_time > 1000 / speed) {
                move();
                last_input_time = millis();
            }
            checkCollisions();
        }
    }

    // Draw the game to the screen
      void draw() {
              if (!gameOver) {
                  draw_board();
              } else {
                  tick_game_over();
              }
          }


    // Handle movement based on current direction
    void move() {
        PVector head = snake.get(0).copy();
        switch (direction) {
            case 0: head.y -= 1; break;
            case 1: head.x += 1; break;
            case 2: head.y += 1; break;
            case 3: head.x -= 1; break;
        }
        snake.add(0, head);

        // Check if the snake eats the food
        if (head.equals(food)) {
            placeFood();
        } else {
            snake.remove(snake.size() - 1);
        }
    }

    // Randomly place food on the board
    void placeFood() {
        do {
            food = new PVector((int) random(board_width), (int) random(board_height));
        } while (snake.contains(food));
    }

    // Check for collisions with the wall and itself
    void checkCollisions() {
        PVector head = snake.get(0);
        if (head.x < 0 || head.x >= board_width || head.y < 0 || head.y >= board_height) {
            gameOver = true;  // hit the wall
        }
        for (int i = 1; i < snake.size(); i++) {
            if (head.equals(snake.get(i))) {
                gameOver = true;  // hit itself
            }
        }
    }

    void tick_game_over() {
      virtualDisplay.fill(255);
      virtualDisplay.textFont(FlipDotFont_pixel);
      virtualDisplay.textLeading(7);
      virtualDisplay.textAlign(CENTER, CENTER);
      virtualDisplay.text("Game\nOver", this.board_width * this.scale * 0.5, this.board_height * this.scale * 0.25);

      // Restart text
      if (frameCount % 15 < 11) {
        virtualDisplay.textAlign(CENTER, CENTER);
        virtualDisplay.text("play", round(this.board_width * this.scale * 0.5), round(this.board_height * this.scale * 0.7));
      }
    }

    void draw_board() {
        virtualDisplay.background(0);
        virtualDisplay.noStroke();
        virtualDisplay.fill(255);
        for (PVector segment : snake) {
            virtualDisplay.rect(segment.x * scale, segment.y * scale, scale, scale);
        }
        virtualDisplay.fill(255, 0, 0);
        virtualDisplay.rect(food.x * scale, food.y * scale, scale, scale);
    }

    void updateButtonStates(int[] newStates) {
        System.arraycopy(newStates, 0, buttonStates, 0, newStates.length);
        handleInput();
    }

void handleInput() {
    if (gameOver) {
        if (buttonStates[0] == 1) {
            restart();  // Restart the game if the first button is pressed
        }
        if (buttonStates[1] == 1) {
            screenState = "menu";  // Go back to the menu if the second button is pressed
        }
    } else {
        // Handle game input only if the game is not over
        if (buttonStates[0] == 1 && direction != 2) direction = 0; // UP
        if (buttonStates[1] == 1 && direction != 3) direction = 1; // RIGHT
        if (buttonStates[2] == 1 && direction != 0) direction = 2; // DOWN
        if (buttonStates[3] == 1 && direction != 1) direction = 3; // LEFT
    }
}


void start_screen() {
    virtualDisplay.fill(255);
    virtualDisplay.textFont(FlipDotFont_pixel);
    virtualDisplay.textLeading(7);
    virtualDisplay.textAlign(CENTER, CENTER);
    virtualDisplay.text("Hi!\n", round(board_width * scale * 0.5), round(board_height * scale * 0.2));

    if (frameCount % 17 < 11) {
        virtualDisplay.text("Press!\nEnter", round(board_width * scale * 0.5), round(board_height * scale * 0.45));
    }

    if (buttonStates[2] == 1 && buttonReady) {
        screenState = "menu";
        buttonReady = false; 
    } else if (buttonStates[2] == 0) {
        buttonReady = true; 
    }
}

void game_menu() {
    if (menuStartTime == 0) {
        menuStartTime = millis();
    }
    
    virtualDisplay.fill(255);
    virtualDisplay.textFont(FlipDotFont_pixel);
    virtualDisplay.textAlign(CENTER, CENTER);
    virtualDisplay.textLeading(7);
    virtualDisplay.text("1.Tetris", round(board_width * scale * 0.5), round(board_height * scale * 0.3));
    virtualDisplay.text("2.Snake", round(board_width * scale * 0.5), round(board_height * scale * 0.6));
  
    if (millis() - menuStartTime > menuDelay) {
        if (buttonStates[2] == 1) {
            screenState = "tetris";
        } else if (buttonStates[3] == 1) {
            screenState = "snake";
        }
    }
}

}
