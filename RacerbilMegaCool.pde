//populationSize: Hvor mange "controllere" der genereres, controller = bil & hjerne & sensorer
int       populationSize  = 100;     

//CarSystem: Indholder en population af "controllere" 
CarSystem carSystem       = new CarSystem(populationSize);

//trackImage: RacerBanen , Vejen=sort, Udenfor=hvid, Målstreg= 100%grøn 
PImage    trackImage;

void setup() {
  size(500, 600);
  trackImage = loadImage("track2.png");
}

void draw() {
  clear();
  fill(255);
  rect(-1000,-1000,10000,10000);
  image(trackImage,0,80);  

  carSystem.updateAndDisplay();
  
  //TESTKODE: Frastortering af dårlige biler, for hver gang der går 200 frame - f.eks. dem der kører uden for banen
   if (frameCount%1000==0) {
    
   for(int i= 0;i<carSystem.CarControllerList.size();i++){
      carSystem.CarControllerList.get(i).sensorSystem.updateFitness();
       println(carSystem.CarControllerList.get(i).sensorSystem.time);
   if(carSystem.CarControllerList.get(i).sensorSystem.fitness<=0){
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
    println("new stuff");
    for(int i= 0;i<carSystem.CarControllerList.size();i++){
     //println(carSystem.CarControllerList.get(i).sensorSystem.fitness);
   }
    //println(carSystem.CarControllerList.size());
    carSystem.newGen();
  }  
    
}
