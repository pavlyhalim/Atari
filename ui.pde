float ui_dot_size;
void ui_setup() {
  float min_ui_space = 300;
  ui_dot_size = min(
    (width - (border * 2.0) - min_ui_space) / config_canvasW,
    (height - (border * 2.0)) / config_canvasH
  ); 
}

void ui_render() {
  float ui_offset = ui_dot_size * config_canvasW + (border * 2);
    
  text(config_cast ? "Casting" : "Not casting", ui_offset, 120);
  text(round(frameRate) + " fps (target: " + config_fps + "fps)", ui_offset, 140);
  text("Runtime: " + secondsToTime(round(frameCount / config_fps)), ui_offset, 160);
  

  if (config_show_simulator) {
    ui_simulate();
  }
  
  float maxSize = width - ui_offset - border;
  float vcScaleWidth = maxSize / virtualDisplay.width;
  float vcScaleHeight = maxSize / virtualDisplay.height;
  float vcScale = min(vcScaleWidth, vcScaleHeight);
  stroke(255);
  strokeWeight(2);
  rect(ui_offset, 180, virtualDisplay.width * vcScale, virtualDisplay.height * vcScale);
  image(virtualDisplay, ui_offset, 180, virtualDisplay.width * vcScale, virtualDisplay.height * vcScale);
  
  textSize(15);
  fill(255);
  noStroke();
  push();
  translate(ui_offset, 220 + virtualDisplay.height * vcScale);
    
  if (castOver == 2) {
    text("Casting mode: USB:", 0, 0);
    for (int i = 0; i < serialAdapters.length; i++) {
      fill(255);
      text(serialAdapters[i], 15, 20 + i * 20);
 
      fill(18, 222, 45);
      ellipse(6, 15 + i * 20, 7, 7);
      fill(0);
    }
  }
  pop();
}

void ui_simulate() {
  push();
  translate(border, border);
  ellipseMode(CORNER);
  for (int i = 0; i < panels.length; i++) {
    push();
    translate(panels[i].x * ui_dot_size, panels[i].y * ui_dot_size);
    
    fill(0);
    stroke(255, 0, 0);
    strokeWeight(1);
    noStroke();
    rect(0, 0, 28 * ui_dot_size, 7 * ui_dot_size);
    
    for (int col = 0; col < 28; col++) {
      for (int row = 0; row < 7; row++) {
        noStroke();
        fill(boolean(panels[i].buffer[col] & 1 << row) ? 255 : 0);
        circle(col * ui_dot_size, row * ui_dot_size, ui_dot_size - 2);
      }
    }
    
    pop();
  }
  pop();
}

String secondsToTime(int seconds) {
  int hours = seconds / 3600;
  int minutes = (seconds % 3600) / 60;
  int secs = seconds % 60;
  return String.format("%02d:%02d:%02d", hours, minutes, secs);
}
