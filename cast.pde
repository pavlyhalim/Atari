import processing.net.*;
import processing.serial.*;

void cast_setup() {
  if (!config_cast) return;
  if (castOver == 1) {
    for (int i = 0; i < netAdapters.length; i++) {
      String[] adapterAddress = split(netAdapters[i], ':');
      adaptersNet[i] = new Client(this, adapterAddress[0], int(adapterAddress[1]));
    }
  }

  else if (castOver == 2) {
    // printArray(Serial.list());
    for (int i = 0; i < serialAdapters.length; i++) {
      String[] adapterAddress = split(serialAdapters[i], ':');
      adaptersSerial[i] = new Serial(this, adapterAddress[0], int(adapterAddress[1]));
    }
  }
}

void cast_broadcast() {
  if (!config_cast) return;
  int adapterCount = netAdapters.length;
  if (castOver == 2) {
    adapterCount = serialAdapters.length;
  }

  for (int adapter = 0; adapter < adapterCount; adapter++) {
    for (int i = 0; i < panels.length; i++) {
      if (panels[i].adapter != adapter) continue;
      cast_write(adapter, 0x80);
      cast_write(adapter, (config_video_sync) ? 0x84 : 0x83);
      cast_write(adapter, panels[i].id);
      cast_write(adapter, panels[i].buffer);
      cast_write(adapter, 0x8F);
    }
  }

  if (config_video_sync) {
    for (int adapter = 0; adapter < adapterCount; adapter++) {
      cast_write(adapter, 0x80);
      cast_write(adapter, 0x82);
      cast_write(adapter, 0x8F);
    }
  }
}


void cast_write(int adapter, int data) {
  if (castOver == 1) {
    adaptersNet[adapter].write(data);
  }
  else if(castOver == 2) {
    adaptersSerial[adapter].write(data);
  }
}
void cast_write(int adapter, byte data) {
  cast_write(adapter, data);
}
void cast_write(int adapter, byte[] data) {
  if (castOver == 1) {
    adaptersNet[adapter].write(data);
  }
  else if(castOver == 2) {
    adaptersSerial[adapter].write(data);
  }
}