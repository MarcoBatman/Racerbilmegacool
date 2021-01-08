//populationSize: Hvor mange "controllere" der genereres, controller = bil & hjerne & sensorer
int       populationSize  = 100;     

//CarSystem: Indholder en population af "controllere" 
CarSystem carSystem       = new CarSystem(populationSize);

//trackImage: RacerBanen , Vejen=sort, Udenfor=hvid, Målstreg= 100%grøn 
PImage    trackImage;

void setup() {
  size(500, 600);
  trackImage = loadImage("track.png");
}

void draw() {
  clear();
  fill(255);
  rect(0,0,1000,1000);
  image(trackImage,0,80);  

  carSystem.updateAndDisplay();
  
  //TESTKODE: Frastortering af dårlige biler, for hver gang der går 200 frame - f.eks. dem der kører uden for banen
   if (frameCount%2000==0) {
    
   for(int i= 0;i<carSystem.CarControllerList.size();i++){
      carSystem.CarControllerList.get(i).sensorSystem.updateFitness();
       println(carSystem.CarControllerList.get(i).sensorSystem.time);
   if(carSystem.CarControllerList.get(i).sensorSystem.fitness<=0){
   carSystem.CarControllerList.remove(i);
   i--;
   }  
  
    }
    
    
    }
    
}