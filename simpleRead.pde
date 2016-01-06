import processing.video.*;

JSONArray json;

Capture cam;
int savedTime;
int totalTime = 10000;

void setup() {

  savedTime = millis();

  size(640, 480);  
  frameRate(25);
  cam = new Capture(this);
  cam.start();
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);//Dibujando la imagensilla
  imprimiendoJsonArrays();

  // Calculate how much time has passed
  int passedTime = millis() - savedTime;
  // Has five seconds passed?
  if (passedTime > totalTime) {
   
    saveFrame("/home/pepe/torch/neuraltalk2-master/imgs/miFrame.jpg");//enviando mi imagen a la carpeta de NeuralTalk
    savedTime = millis(); // Save the current time to restart the timer!
   
  }
}


void mousePressed() {
  //exec("/home/pepe/torch/neuraltalk2-master/redExec.sh");//Ejecutando el algoritmo de LUA desde "consola"
}

void imprimiendoJsonArrays() {
  json = loadJSONArray("/home/pepe/torch/neuraltalk2-master/vis/vis.json");//cargando mi archivo json con las etiquetas de la prediccion del modelo 

  for (int i = 0; i < json.size(); i++) {

    JSONObject predicciones = json.getJSONObject(i); 

    //int id = etiquetas.getInt("id");
    String id = predicciones.getString("image_id");
    String etiqueta = predicciones.getString("caption");

    println(id + ", " + etiqueta);
    fill(0);
    pushMatrix();
    translate(0, 20);
    textSize(20);
    text("imagen "+id+": "+etiqueta+"\n", 20, 35*i);
    popMatrix();
  }
}
