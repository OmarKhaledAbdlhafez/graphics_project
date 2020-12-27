  //Class Definition// //<>//
  class Ball{
    long x = 500;
    long y = 250;
    long radius = 20;
    long velocityX = 5;
    long velocityY = 5;
    long speed = 5;
  }
  
  class User {
    long x = 0;
    long y = 200;
    long h = 100;
    long w = 10;
    long score = 0;
  }
  
  class Com {
    long x = 990;
    long y = 200;
    long h = 100;
    long w = 10;
    long score = 0;
  }
  
  class net {
    long x = 499;
    long y = 0;
    long h = 10;
    long w = 2;
  }
  
  //objects' definition//
  Ball ball = new Ball();
  User user = new User();
  Com com = new Com ();
  net net = new net();
  boolean game = true ;
  boolean startgame = true ;
  PFont font;
  PImage img;
  
  void drawNet(){
    for (long i =0; i <=500 ; i+=15){
      rect(net.x, net.y+i,net.w,net.h);
    }
  }
  
  
  void display (){
    textSize(32);
    background(50);
    fill(150);
    usermove();
    stroke(255);
    rect(user.x, user.y, user.w, user.h);
    rect(com.x, com.y, com.w, com.h);
    drawNet();
    ellipse (ball.x,ball.y, ball.radius, ball.radius);
    text(user.score,width/4,height/5);
    text(com.score,3*width/4,height/5);
  }
  
  void displaystart(){
    background(255);
    
    //font = loadFont("helvetica.ttf");
    img = loadImage("ping-pong2.jpg");
    
    image(img,700,0,300,300);
    
    textAlign(LEFT);
    fill(0);
    stroke(255);
    //textFont(font);
    textSize(64);
    String s = "PING PONG";
    text(s , 50 , height/4);
    
    fill(50);
    textSize(28);
    s = "the game has two players\nthe first uses the mouse ( left player )\nand the second player uses the \"w\" and \"s\" to move (right player)";
    text(s,50,height/2);
    
    fill(50);
    textSize(28);
    s ="Welcome to the game please type \"enter\" to start";
    text(s, 50 , height-50);
    
  }
  
  void usermove(){
    //  move user with mouse 
    user.y = mouseY;
    // control don't get out of the window 
    if (user.y<=0){user.y=0;}
    if (user.y>=400){user.y=500-user.h;}
    // move com 
    if (keyPressed){
      println(key);
      // move down and control don't get out window  
      if (key == 's'){
        if (com.y >= 400){
        com.y=500-com.h;
        }
        
        else {
        com.y+=5;
        }
      }
        
        // move up and control don't get out window
      else if (key == 'w'){
          
        if(com.y == 0){
          com.y = 0;
        }
          
        else {
          com.y -= 5;
        }
      }
    }
  
  }
  
  void game (){
    ball.x += ball.velocityX;
    ball.y += ball.velocityY;
    if (ball.x + ball.radius < width/2)
      {
        if(collisionUser(user, ball))
        {
          long collidePolong = (ball.y - (user.y + user.h/2));
          collidePolong = collidePolong / (user.h/2);
          float angleRad = (PI/4) * collidePolong;
          long direction = 1;
          ball.speed =ball.speed > 100 ? 100:ball.speed; 
          ball.speed += 1;
          ball.velocityX = (long)(direction * ball.speed * cos(angleRad));
          ball.velocityY = (long)(ball.speed * sin(angleRad));
          
        }
      } 
      else
      {
        if (collisionCom(com, ball))
        {
          long collidePolong = (ball.y - (com.y + com.h/2));
          collidePolong = collidePolong / (com.h/2);
          float angleRad = (PI/4) * collidePolong;
          long direction = -1;
          ball.speed =ball.speed > 100 ? 100:ball.speed; 
          ball.speed += 1;
          ball.velocityX = (long)(direction * ball.speed * cos(angleRad));
          ball.velocityY = (long)(ball.speed * sin(angleRad));
         
        }
      }
    
  
    // when the ball get out window in thr left side com win 1 polong 
  if( ball.x - ball.radius < 0 && !collisionUser(user, ball)){
          com.score++;
          resetball();
      }
      // when the ball get out window in thr right side user win 1 polong 
      else if( ball.x + ball.radius > width && !collisionCom(com, ball)){
          user.score++;
          resetball();
      }
      // move ball in the window 
      
      // control ball so it don't get off the window
      if(ball.y - ball.radius < 0 || ball.y + ball.radius > height){
          ball.velocityY = -ball.velocityY;
      }
  }
  
  void resetball(){
    ball.x = width/2;
    ball.y = height/2;
    ball.velocityX = -ball.velocityX;
  }
  
  boolean collisionUser(User p, Ball b)
  {
    long topUser = p.y;
    long bottomUser = p.y + p.h;
    long leftUser = p.x;
    long rightUser = p.x + p.w;
    
    long topBall = b.y - b.radius;
    long bottomBall = b.y + b.radius;
    long leftBall = b.x - b.radius;
    long rightBall = b.x + b.radius;
    
    return rightUser >= leftBall && topUser <= bottomBall && bottomUser >= topBall;
  }
  
  boolean collisionCom(Com p, Ball b)
  {
    long topUser = p.y;
    long bottomUser = p.y + p.h;
    long leftUser = p.x;
    long rightUser = p.x + p.w;
    
    long topBall = b.y - b.radius;
    long bottomBall = b.y + b.radius;
    long leftBall = b.x - b.radius;
    long rightBall = b.x + b.radius;
    
    return leftUser <= rightBall && topUser <= bottomBall && bottomUser >= topBall;
  }
  
  void setup(){
    size(1000,500);
    background(50);
    textSize(64);
    textAlign(CENTER);
  }
  
  void draw(){
    if (startgame){
      displaystart();
      if (keyPressed && key == '\n' ){
        startgame = false ;
      }
    }
    
    else {
      if(keyPressed){
          if(key == 'r' || key == 'R'){
            textSize(32);
            com.score = 0;
            user.score = 0;
            game = true;
          }
          if(key == 'e' || key == 'E'){
            System.exit(0);
          }
          }
      if (game){
        display();
        game();
        if (user.score == 5){
          
          background(0);
          textSize(64);
          fill(255);
          text ("Player One Wins " , width/4 , height /2);
          textSize(32);
          text ("\npress \"r\" to reset the game " , width/4 , height/2 );
          text ("\n\npress \"e\" to exit the game " , width/4 , height/2 );
          game = false ;
          
        
        }
        if (com.score == 5){
          
          background(0);
          textSize(64);
          fill(255);
          text ("player two wins " , width/4 , height /2);
          
          game = false ;
        }
      }
    }
  }
