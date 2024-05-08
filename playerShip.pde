// class Game {
//     ArrayList<Star> stars = new ArrayList<Star>();
//     Ship playerShip = new Ship();
//     ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
//     ArrayList<Bullet> bullets = new ArrayList<Bullet>();
//     int points = 0;
//     EndScene end;

//     int frequency = 4; // Frequency for stars
//     int asteroidFrequency = 60; // Frequency for asteroids

//     Game() {
//         initialize();
//     }

//     void initialize() {
//         playerShip = new Ship();
//         points = 0;
//     }

//     void update() {
//         if (end != null) {
//             end.drawEndScene();
//         } else { 
//             background(0);
//             drawStars();
//             drawAsteroids();
//             drawBullets();
//             playerShip.drawShip();
//             checkCollision();
//             displayScore();
//         }
//     }

//     void drawStars() {
//         if (frameCount % frequency == 0) {
//             stars.add(new Star());
//         }
//         for (int i = stars.size() - 1; i >= 0; i--) {
//             Star star = stars.get(i);
//             star.update();
//             star.display();
//             if (star.y > height) {
//                 stars.remove(i);
//             }
//         }
//     }

//     void drawAsteroids() {
//         if (frameCount % asteroidFrequency == 0) {
//             asteroids.add(new Asteroid(random(150, 250)));
//         }
//         for (int i = asteroids.size() - 1; i >= 0; i--) {
//             Asteroid asteroid = asteroids.get(i);
//             asteroid.update();
//             asteroid.display();
//             if (asteroid.y > height + asteroid.size) {
//                 asteroids.remove(i);
//                 points--;
//             }
//         }
//     }

//     void drawBullets() {
//         for (int i = bullets.size() - 1; i >= 0; i--) {
//             Bullet bullet = bullets.get(i);
//             bullet.update();
//             bullet.display();
//             if (bullet.y < 0) {
//                 bullets.remove(i);
//             }
//         }
//     }

//     void checkCollision() {
//         for (int a = 0; a < asteroids.size(); a++) {
//             Asteroid asteroid = asteroids.get(a);
//             if (asteroid.checkCollision(playerShip)) {
//                 end = new EndScene(points);
//             }
//             for (int b = bullets.size() - 1; b >= 0; b--) {
//                 Bullet bullet = bullets.get(b);
//                 if (asteroid.checkCollision(bullet)) {
//                     points++;
//                     asteroids.remove(a);
//                     bullets.remove(b);
//                     break;
//                 }
//             }
//         }
//     }

//     void displayScore() {
//         fill(255);
//         textSize(30);
//         text("Points: " + points, 50, 50);
//     }
// }

// // void keyPressed() {
// //     game.keyPressed();
// // }

// // void keyReleased() {
// //     game.keyReleased();
// // }

// // void mousePressed() {
// //     game.mousePressed();
// // }

// class Asteroid {
//   float size, x, y;

//   int vy = 5; //speed of asteroid

//   Asteroid(float size) {
//     this.size = size;
//     this.x = random(width);
//     this.y = -size;
//   }

//   void drawAsteroid() {
//     fill(150);
//     stroke(150);
//     ellipse(x, y, size, size);
//     y+=vy;
//   }

//   boolean checkCollision(Object other) {
//     if (other instanceof Ship) {
//       Ship playerShip = (Ship) other;
//       float apothem = 10 * tan(60);
//       float distance = dist(x, y, playerShip.x, playerShip.y-apothem);
//       if (distance < size/2 + apothem + 10) {
//         //background(255, 0, 0);
//         fill(255, 0, 0, 100);
//         rect(0, 0, width, height);
//         fill(255);
        
//         return true;
//       }
//     } else if (other instanceof Bullet) {
//       Bullet bullet = (Bullet) other;
//       float distance = dist(x, y, bullet.x, bullet.y); 
//       println(distance);
//       if (distance <= size/2 + bullet.size/2 ) {
//         fill(0, 255, 0, 100);
//         rect(0, 0, width, height);
//         fill(255);
        
//         return true;
//       }
//     }
//     return false;
    
//   }
// }

// class Bullet {
//   float x, y, vy;
//   float size;
  
//   Bullet(Ship playerShip) {
//     this.x = playerShip.x;
//     this.y = playerShip.y - 15;
//     this.vy = -10;
//     this.size = 10;
//   }
  
//   void drawBullet() {
//     //color?
//     fill(255, 0, 0);
//     ellipse(x, y, size, size);
//     y+=vy;
//   }
    
    
// }


// class EndScene {
//   String gameOverText, buttonText, pointsText;
//   int buttonX, buttonY, buttonW, buttonH;


//   EndScene(int points) {
//     this.gameOverText = "Game Over!";
//     this.buttonText = "Retry";
//     this.pointsText = "Your final Score is " + points;
//     this.buttonW = 200;
//     this.buttonH = 100;
//     this.buttonX = width/2 - this.buttonW/2;
//     this.buttonY = height/2 - this.buttonH/2;
//   }

//   void drawEndScene() {
//     //OVERLAY
//     fill(#F73939);
//     rect(0, 0, width, height);
//     rect(buttonX, buttonY, buttonW, buttonH);

//     //TEXT
//     stroke(255);
//     fill(255);
//     textSize(60);
//     text(this.gameOverText, width/3, height/4);

//     //BUTTON
//     fill(0);
//     stroke(200);
//     rect(buttonX, buttonY, buttonW, buttonH);
//     fill(200);
//     text(buttonText, buttonX+25, buttonY+70);
    
//     //SCORE
//     stroke(255);
//     fill(255);
//     textSize(30);
//     text(pointsText, width/3, height - height/4);
//   }

//   boolean mouseOverButton() {
//     return (mouseX > buttonX 
//       && mouseX < buttonX + buttonW
//       && mouseY > buttonY
//       && mouseY < buttonY + buttonH);
//   }
// }


// class Ship {
//   float x, y, vx, vy;
//   boolean upPressed, downPressed, leftPressed, rightPressed;
  
//   int speed = 6; //speed of ship
  
//   Ship() {
//     this.x = width/2;
//     this.y = height - height/4;
//     this.vy = 0;
//     this.vx = 0;
//   }
  
//   void drawShip() {
//     if (upPressed == true) {
//       vy= -speed;
//     } else if (downPressed == true) {
//       vy = speed;
//     } else {
//       y -= vy;
//       vy = 0;
//     }
    
//     if (leftPressed == true) {
//       vx= -speed;
//     } else if (rightPressed == true) {
//       vx= speed;
//     } else {
//       vx=0;
//     }
    
//     x += vx;
    
//     if (y-20>=50 && y<height) {
//       y += vy;
//     }
    
    
//     if (x+10 < 0)
//       x = width+9;
    
//     if (x-10 > width) x = -9;
    
//     triangle(x, y-17.32, x-10, y, x+10, y);
//   }
// }

// class Star {
//   float x, y;
//   int vy;
  
//   Star() { //CONSTRUCTOR
//     this.x = random(width);
//     this.y = 0;
//     this.vy = 8; //velocity of falling star
//   }
  
//   void drawStar() {
//     y+=vy;
//     point(x,y);
    
//   }
// }