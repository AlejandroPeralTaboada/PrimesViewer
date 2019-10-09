/*
 * This is a prime viewer in polar coordinates, use the mouse wheel to zoom in / zoom out 
 * The whole program is writen in a single file to make it easy to share
 *
 * The program computes each number onece and stores it in a list
 */
// Represents a value in polar coordinates
class PolarPoint{
  final float x,y;  
  final int val;
  PolarPoint(int val){
   this.x=val*cos(val);
   this.y=val*sin(val);
   this.val=val;
  }
}

// --------------------- Prime Computing -------------------
// The largest prime that we have computed
int primesUpTo = 0;
// List of primes up to the vale of primesUpTo
ArrayList<PolarPoint> primes = new ArrayList<PolarPoint>();

void computePrimesUpTo(int limit){
  if(primesUpTo< limit){
    println("computing from: "+primesUpTo+" to: "+limit);
    for(int i = primesUpTo; i<=limit; i++){
      if(isPrime(i)){
        primes.add(new PolarPoint(i));
      }
    }
    primesUpTo = limit;
  }
  
}
boolean isPrime(int n){
  if (n==0 || n==1 || n == 2){  
    return true;
  } 
  float squareN = sqrt(n)+1;
  for (int i = 2; i<squareN; i++){
    if (n%i==0){  
      return false;
    }
  }  
  return true;
}

// --------------------- Lifecycle -------------------
// Animation speed increase 
final float acceleration = 0.01;
// The largest resolution, max(width,height)
int limit = 0;
// The current resolution multiplayer
float resolutionMultiplayer = 0.5;

void setup(){
  size(1920,1080);  
  limit = Math.max(height,width);
}


void draw(){  
  computePrimesUpTo((int)resolutionMultiplayer*limit);
  background(255);
  translate(width/2,height/2);
  noStroke();
  fill(0, 0, 255);
  float size = 3 - log(log(resolutionMultiplayer));
  for(PolarPoint p : primes){
    if(p.val > limit*resolutionMultiplayer){  
      break;
    }
    circle(p.x/resolutionMultiplayer,p.y/resolutionMultiplayer,size);
  }
  modifyResolution(resolutionMultiplayer*acceleration);
}


void modifyResolution(float e){
  resolutionMultiplayer=Math.max(resolutionMultiplayer+e*0.5,1);
}


// Events

// Use mouse to increase or decrease the field of view
void mouseWheel(MouseEvent event) {
  modifyResolution(event.getCount()*10);
}

// Press R to reset the view
void keyPressed(KeyEvent event){
  switch(event.getKey()){
    case 'r':
      resolutionMultiplayer=1;
  }
}
