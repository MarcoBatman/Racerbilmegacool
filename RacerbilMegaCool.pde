//populationSize: Hvor mange "controllere" der genereres, controller = bil & hjerne & sensorer
int       populationSize  = 100;     

//CarSystem: Indholder en population af "controllere" 
CarSystem carSystem       = new CarSystem(populationSize);

//trackImage: RacerBanen , Vejen=sort, Udenfor=hvid, Målstreg= 100%grøn 
PImage    trackImage;

int genNumber = 1;
int bestLapTime;

void setup() {
  size(500, 900);
  trackImage = loadImage("track.png");
}

void draw() {
  clear();

  fill(255);
  rect(-1000,-1000,10000,10000);
  image(trackImage,0,80);  
  fill(255,180,0);
  textSize(18);
  text("Det her er en simulation af biler der lærer at køre\ninde for en sat bane, bilerne bliver bedre og bedre\njo flere generationer de går igennem.\nDu er på generation "+genNumber+"\nDer bliver lavet nye generationer hver gang der går \n500 frames.\nSidste generations hurtigste og lovlige lap var "+bestLapTime+"\nBilerne har også en chance for at mutere, som gør at \nde ændre deres bevægelse væk fra normen, dette kan \ngive nye muligheder for nye bevægelser.\nChancen for at mutere er 0.02",25,600);
  fill(255);
  carSystem.updateAndDisplay();
  
  //TESTKODE: Frastortering af dårlige biler, for hver gang der går 200 frame - f.eks. dem der kører uden for banen
   if (frameCount%500==0) {
    genNumber++;
   for(int i= 0;i<carSystem.CarControllerList.size();i++){
      carSystem.CarControllerList.get(i).sensorSystem.updateFitness();}
      for(int i= 0;i<carSystem.CarControllerList.size();i++){
      float highest=0;
      float secondhighest=0;
      for(int j =0;j<carSystem.CarControllerList.size();j++){
      if(carSystem.CarControllerList.get(j).sensorSystem.fitness > carSystem.CarControllerList.get((int)highest).sensorSystem.fitness)
      highest=j;
      }
      
      for(int j= 0;j<carSystem.CarControllerList.size();j++){
      if(carSystem.CarControllerList.get(j).sensorSystem.fitness < carSystem.CarControllerList.get((int)highest).sensorSystem.fitness && carSystem.CarControllerList.get(j).sensorSystem.fitness > carSystem.CarControllerList.get((int)secondhighest).sensorSystem.fitness)
      secondhighest=j;
      }
      
   if(carSystem.CarControllerList.get(i).sensorSystem.fitness<=carSystem.CarControllerList.get((int)secondhighest).sensorSystem.fitness/10){
   carSystem.CarControllerList.remove(i);
   i--;
   }  
    }
    while(carSystem.CarControllerList.size()>50){
    int deleteThis=0;
    for(int j = 0;j<carSystem.CarControllerList.size();j++){
    if(carSystem.CarControllerList.get(j).sensorSystem.fitness<carSystem.CarControllerList.get(deleteThis).sensorSystem.fitness){
      deleteThis=j;
    }
    }
    carSystem.CarControllerList.remove(deleteThis);
    }
      int bestLapPlace=0;
      for(int j =0;j<carSystem.CarControllerList.size();j++){
      if(carSystem.CarControllerList.get(j).sensorSystem.lapTimeInFrames < carSystem.CarControllerList.get((int)bestLapPlace).sensorSystem.lapTimeInFrames && carSystem.CarControllerList.get(j).sensorSystem.lapTimeInFrames>120&&carSystem.CarControllerList.get(j).sensorSystem.whiteSensorFrameCount==0){
      bestLapPlace=j;
      bestLapTime= carSystem.CarControllerList.get(j).sensorSystem.lapTimeInFrames;
      }
      }
    carSystem.newGen();
  }  
    
}
