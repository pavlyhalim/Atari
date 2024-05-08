boolean config_cast = true;
int config_fps = 30;
int config_canvasW;
int config_canvasH;
boolean config_video_sync = true;
boolean config_show_simulator = true;

int castOver = 2;


Panel[] panels = new Panel[4];
String[] netAdapters = {};

String[] serialAdapters = {
  "/dev/tty.usbserial-110:57600"
};

Client[] adaptersNet = new Client[netAdapters.length];
Serial[] adaptersSerial = new Serial[serialAdapters.length];

PFont FlipDotFont;
PFont FlipDotFont_pixel;

int border = 40;

void config_setup() {
  FlipDotFont = createFont("fonts/zxSpectrumStrictCondensed.ttf", 15); // Good all round small font
  FlipDotFont_pixel = createFont("fonts/m3x6.ttf", 16); // Good general pixel font
  createPanels();
}

void createPanels() {

  panels[0] = new Panel(0, 1, 0, 0);
  panels[1] = new Panel(0, 2, 0, 7);
  panels[2] = new Panel(0, 4, 0, 14);
  panels[3] = new Panel(0, 3, 0, 21);

  for (int i = 0; i < panels.length; i++) {
    if (panels[i].x + 28 > config_canvasW) {
      config_canvasW = panels[i].x + 28;
    }
    if (panels[i].y + 7 > config_canvasH) {
      config_canvasH = panels[i].y + 7;
    }
  }
}