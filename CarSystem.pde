class CarSystem {
  //CarSystem - 
  //Her kan man lave en generisk alogoritme, der skaber en optimal "hjerne" til de forhåndenværende betingelser

  ArrayList<CarController> CarControllerList  = new ArrayList<CarController>();

  CarSystem(int populationSize) {
    for (int i=0; i<populationSize; i++) { 
      CarController controller = new CarController();
      CarControllerList.add(controller);
    }
  }

  void updateAndDisplay() {
    //1.) Opdaterer sensorer og bilpositioner
    for (CarController controller : CarControllerList) {
      controller.update();
    }

    //2.) Tegner tilsidst - så sensorer kun ser banen og ikke andre biler!
    for (CarController controller : CarControllerList) {
      controller.display();
    }
  }

  void newGen() {
    float sum = 0;

    for (int i = 0; i>CarControllerList.size(); i++) {
      sum+=CarControllerList.get(i).sensorSystem.fitness;
    }
    ArrayList<CarController> newGen  = new ArrayList<CarController>();
    ArrayList<CarController> parrents = new ArrayList<CarController>();
    while (newGen.size()+CarControllerList.size()<101) {
      while (parrents.size()<3)
        for (int i = 0; i < CarControllerList.size(); i++) {
          if (random(sum)<CarControllerList.get(i).sensorSystem.fitness && parrents.size()<3) {
            parrents.add(CarControllerList.get(i));
          }
        }
      newGen.add(new CarController());
      for (int i =0; i<8; i++) {
        if (parrents.get(0).hjerne.weights[i]<parrents.get(1).hjerne.weights[i])
          newGen.get(newGen.size()-1).hjerne.weights[i]=random(parrents.get(0).hjerne.weights[i], parrents.get(1).hjerne.weights[i]);
        if (parrents.get(1).hjerne.weights[i]<parrents.get(0).hjerne.weights[i])
          newGen.get(newGen.size()-1).hjerne.weights[i]=random(parrents.get(1).hjerne.weights[i], parrents.get(0).hjerne.weights[i]);
        if (parrents.get(0).hjerne.weights[i]==parrents.get(1).hjerne.weights[i])
          newGen.get(newGen.size()-1).hjerne.weights[i]=parrents.get(0).hjerne.weights[i];
        if (random(1)<mutationRate)
          newGen.get(newGen.size()-1).hjerne.weights[i]=random(-newGen.get(newGen.size()-1).varians, newGen.get(newGen.size()-1).varians);
      }

      for (int i =0; i<3; i++) {
        if (parrents.get(0).hjerne.biases[i]<parrents.get(1).hjerne.biases[i])
          newGen.get(newGen.size()-1).hjerne.biases[i]=random(parrents.get(0).hjerne.biases[i], parrents.get(1).hjerne.biases[i]);
        if (parrents.get(1).hjerne.biases[i]<parrents.get(0).hjerne.biases[i])
          newGen.get(newGen.size()-1).hjerne.biases[i]=random(parrents.get(1).hjerne.biases[i], parrents.get(0).hjerne.biases[i]);
        if (parrents.get(0).hjerne.biases[i]==parrents.get(1).hjerne.biases[i])
          newGen.get(newGen.size()-1).hjerne.biases[i]=parrents.get(0).hjerne.biases[i];
        if (random(1)<mutationRate)
          newGen.get(newGen.size()-1).hjerne.biases[i]=random(-newGen.get(newGen.size()-1).varians, newGen.get(newGen.size()-1).varians);
      }
    }
    for (int i = 0; i<CarControllerList.size(); i++) {
      newGen.add(CarControllerList.get(i));
    }
    CarControllerList.clear();
    for (int i = 0; i<newGen.size(); i++) {
      CarControllerList.add(newGen.get(i));
    }
    for (int i = 0; i<CarControllerList.size(); i++) {
      CarControllerList.get(i).sensorSystem.fitness=0;
      CarControllerList.get(i).sensorSystem.whiteSensorFrameCount=0;
      CarControllerList.get(i).sensorSystem.lapTimeInFrames=500;
      CarControllerList.get(i).sensorSystem.time=0;
      CarControllerList.get(i).sensorSystem.clockWiseRotationFrameCounter = 0;
      CarControllerList.get(i).bil.pos = new PVector(60, 232);
    }
  }
}
