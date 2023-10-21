//bob is the cell you control, and joe is the list containing all of the enemy cells
Cell bob;
Enemy [] joe;

void setup(){
  //declares bob & joe
  //sets up some other stuff like the size, text stuff, and frame rate
  size(500,500);
  textAlign(0);
  textSize(47);
  frameRate(60);
  
  bob = new Cell();
  joe = new Enemy[10];
  for(int i = 0; i < joe.length; i++){//fills up the list joe
    joe[i] = new Enemy();
  }
}

void draw(){
  background(150,150,150);
  bob.move(mouseX, mouseY);//moves your cell to where your mouse is
  for(int i = 0; i < joe.length; i++){//updates all the enemy cells
    int save = bob.r;//saves your radius
    joe[i].move();//moves the cell
    if(bob.r != save){//if your cell has grown that means the enemy cell got eaten
      joe[i] = new Enemy();//recreate this specific enemy
    }
  }
}

class Enemy{//other cells
  int x, y, r, rgb; //x y coordinates, radius, and color
  Enemy(){
    //spawns with random x coordinate on either top or bottom of the screen
    x = (int)(Math.random()*600)-50;
    r = (int)(Math.random()*bob.r) + bob.r/2; //random radius based on your own 
                                               //cell's radius
    y = (int)(Math.random()*2)*500;
    if(y > 1){         //spawns the enemy cell out of the visual screen 
      y += (r/2 + 47); //so you don't just instantly die by a bigger cell spawning on you
    } else {
      y -= (r/2 + 47);
    }
    rgb = color((int)(Math.random()*256), (int)(Math.random()*256), (int)(Math.random()*256));
    fill(rgb); //random color
  }
  void move(){//moves closer to bob in a random pattern
    if(x > bob.x){
      x -= (int)(Math.random()*2);
    } else {
      x += (int)(Math.random()*2);
    }
    
    if(y > bob.y){
      y -= (int)(Math.random()*2);
    } else {
      y += (int)(Math.random()*2);
    }
    
    //draws the enemy cell
    fill(rgb);
    ellipse(x, y, r, r);
    
    if(dist(x, y, mouseX, mouseY) < (bob.r+r)/2){//checks if the enemy cell is touching your cell
      if(bob.r >= r){//if your cell is bigger
        bob.r += (r/20) + 1;//then increase ur cell size by a bit
      } else {
        fill(0,0,0);//otherwise you lose
        text("You Lost!", 150, 150);
        stop();
      }
    }
  }
}

class Cell{//your cell
  int r, x, y, rgb; //radius, x y coordinates, and color
  Cell(){
    r = 10;//starts with a radius of 10
    rgb = color((int)(Math.random()*256), (int)(Math.random()*256), (int)(Math.random()*256));
    fill(rgb);  //random color
}
  void move(int okX, int okY){
    x = okX;//moves your cell to where your mouse is
    y = okY;
    fill(rgb);
    ellipse(x, y, r, r);//draws your cell
    if(r > 600){//win condition is if ur cell's radius is greater than 600 then the game stops and u win
      fill(0,0,0);
      text("You Win!", 150,150);
      stop();
    }
  }
}

