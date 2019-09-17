PImage pic1;
PImage pic2;
PImage display;
PImage lightning;
PImage rain;
PImage tornado;
int randomnum;
int counter = 0;
int [] pixelList;
int mode;
int shift;
int i;
int j;
int colorIncr = 0;
String [] titles = {"Columbia, SC", "MY HOME", "October 4, 2015", "The Flood of the Millenium'",
                     "Houses submerged", "14 Dead", "18 Dams Breached", "We have no choice!",
                   "Divest from fossil fuels!"};
int x;
int iterations;
Float [][] panelsRatios = {
  {0.0052083336, 0.7462963, float(43/2880), float(29/1800)},//1
  {0.06302083, 0.7972222, float(43/2880), float(29/1800)},//2
  {0.08645833, 0.7712963, float(43/2880), float(29/1800)},//3
  {0.122395836, 0.7712963, float(43/2880), float(29/1800)},//4
  {0.17916666, 0.7972222, float(44/2880), float(29/1800)},//5
  {0.2765625, 0.7685185, float(44/2880), float(29/1800)},//6
  {0.29895833, 0.7425926, float(44/2880), float(29/1800)},//7
  {0.35364583, 0.7425926, float(44/2880), float(29/1800)},//8
  {0.3875, 0.7962963, float(44/2880), float(29/1800)},//9
  {0.41041666, 0.7962963, float(44/2880), float(29/1800)},//10
  {0.43385416, 0.7685185, float(44/2880), float(29/1800)},//11
  {0.4609375, 0.8851852, float(45/2880), float(30/1800)},//12
  {0.48645833, 0.7425926, float(44/2880), float(29/1800)},//13
  {0.50885415, 0.7685185, float(44/2880), float(29/1800)},//14
  {0.5640625, 0.85925925, float(49/2880), float(34/1800)}};//15
 color rred = color(200, 20, 20);
 color ggreen = color(20, 200, 20);
 Float [] colorRatios = {0.01, 0.1, 0.18, 0.22, 0.3, 0.38, 0.46,
                         0.54, 0.6, 0.65, 0.73, 0.81, 0.88, 0.92, 0.99};



void setup(){
  fullScreen();
  pic1 = loadImage("Cola,SC_PreFlood.jpg");
  pic2 = loadImage("Cola,SC_TheFlood2015.jpg");
  pic1.loadPixels();
  pic2.loadPixels();
  display = loadImage("Cola,SC_PreFlood.jpg");
  display.loadPixels();
  
  lightning = loadImage("lightning.jpg");
  tornado = loadImage("tornado.jpg");
  rain = loadImage("rain.jpg");
  
  mode=0;
  x=0;
  textSize(50);
  iterations =0;
}


void draw(){
 //Outside Panels
 for(i=0; i<panelsRatios.length; i++){
   fill(lerpColor(ggreen, rred, colorRatios[(i+counter)%colorRatios.length]));
   //for testing use commented out rect statement, to see the rectangles
   rect(panelsRatios[i][0]*width, panelsRatios[i][1]*height, 50, 50);
   rect(panelsRatios[i][0]*width, panelsRatios[i][1]*height, panelsRatios[i][2]*width, panelsRatios[i][3]*height);
 }
  
 //In cafe -- ceiling
  if(counter>25){
    x = (x+1) %(titles.length);
  }
  fill(12+colorIncr, 0, 20+colorIncr);
  rect(0.66041666*width, 0, (1-0.66041666)*width, 0.0394444*height);
  fill(175);
  println(x);
  text(titles[x], 0.75*width, 0.03*height);
  colorIncr = (colorIncr + 1)%100;

  
 //In cafe -- wall
 if(counter>25){
    mode = int(random(4));
    iterations ++;
    counter=0;
  }

 image(display, 0.66041666*width,0.0394444*height,(1-0.66041666)*width,height);
  switch (mode){
    case 0://small rects of pic2 populating display
      randomnum = int(random(pic2.pixels.length));  
    
      for(i=0; i<100; i++){
        for(j=0; j<100; j++){
          if (randomnum+(i*pic2.width+j+1) <pic2.pixels.length && randomnum+(i*pic2.width+j)+1 < display.pixels.length){
            display.pixels[randomnum +(i*display.width) + j]=pic2.pixels[randomnum + (i*display.width) + j] + color((i+j)%10);
          }
        }
      }
      break;

     case 1://large rect chunks switching between photos
     randomnum= int(random(display.height-501));
     shift = pick(0,600,1000);
     if(counter%11==0){
       for(i=0; i<500; i++){
          for(j=0; j<500; j++){
            if(shift+(randomnum+ i)*display.width+j < display.pixels.length){
              display.pixels[shift+(randomnum+ i)*display.width+j] = pic1.pixels[shift+(randomnum+ i)*display.width+j];
            }
          }
       }
     }
     else if(counter%11==6){
     
     for(i=0; i<500; i++){
          for(j=0; j<500; j++){
            if(shift+(randomnum+ i)*display.width+j < display.pixels.length){
              display.pixels[shift + (randomnum+ i)*display.width+j] = pic2.pixels[shift +(randomnum+ i)*display.width+j];
            }
          }
       }
     }
     break;
     
    case 2: //drops of grainy inbetween the photos
    pixelList = genr8PixList(display, int(random(20,200)));
    for (i=0; i<pixelList.length; i++){
      if(pixelList[i]+1 <display.pixels.length && pixelList[i] >0){
        display.pixels[pixelList[i]] = lerpColor(pic1.pixels[pixelList[i]], pic2.pixels[pixelList[i]], random(1));
      }
    }
    break;
    
    case 3:
    int chance = pick(1,2,3);
    switch (chance){
      case 1:
        blend(lightning, 0, 0, display.width, display.height,
        int(0.66041666*width),int(0.0394444*height), int((1-0.66041666)*width),height,
        int(random(14)));
        delay(500);
        break;
      case 2:
      blend(tornado, 0, 0, display.width, display.height,
        int(0.66041666*width),int(0.0394444*height), int((1-0.66041666)*width),height,
        int(random(14)));
        delay(500);
        break;
      case 3:
      blend(rain, 0, 0, display.width, display.height,
        int(0.66041666*width),int(0.0394444*height), int((1-0.66041666)*width),height,
        int(random(14)));
        delay(500);
        break;
    }
    }
    

counter++;
display.updatePixels();
}


int pick(int a, int b, int c){
  int r = int(random(3));
  if (r== 0){
    return a;
  }
  else if(r==1){
    return b;
  }
  else{
    return c;
  }
}

int [] genr8PixList(PImage pic, int spotRad){
  int [] pixList = new int [int(PI * sq(spotRad))];
  pic.loadPixels();
  int c=0;
  int [] loc = new int [2];
  int [] spot = {int(random(pic.width)), int(random(pic.height))};
  for(i=-spotRad; i<spotRad; i++){
    for(j=-spotRad; j<spotRad; j++){
      loc[0]=spot[0] + j;
      loc[1]=spot[1] + i;
      if(sqrt(sq(spot[0]-loc[0]) + sq(spot[1]-loc[1])) < spotRad){
        pixList[c]= loc[1]*pic.width + loc[0];
        c++;
      }
    }
  }
  return pixList;
}
