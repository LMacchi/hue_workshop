# traffic_lights.pp
Hue_light { on => true, bri => 10, sat => 254 }
hue_light {
  '1':
    hue => 23536;
  '2':
    hue => 10000;
  '3':
    hue => 65136;
}
