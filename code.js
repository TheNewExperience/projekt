var canvasHeight = 400;
var canvasWidth = 400;

var ballR= 20;
var x = 20

var xPossition = 50;
var yPossition =50;

var speedAxisX =7;
var speedAxisY = 7;

var catwalkWidth = 100;
var catwalkHeight = 20;
var yPossitionCatWalk = canvasHeight - 30;


var blocks = [[]];
var blocksRows = 3;
var blockHight = 40;
var blockInRow = 4;
var blockWidth = canvasWidth/blockInRow;

var blocksHit = 0;
 
void setup() 
{
    size(canvasHeight,canvasWidth);
};

var mainBall = function(){
    noStroke();
    fill(255, 0, 0)
    ellipse(xPossition,yPossition,ballR * 2, ballR *2);

    if( (xPossition + ballR >= canvasWidth) || (xPossition - ballR <=0)){
        speedAxisX = speedAxisX * -1;
    }
    // if ((yPossition + ballR >= canvasHeight) || (yPossition - ballR <=0)){
    if ((yPossition + ballR >= canvasHeight) || (yPossition - ballR <=0)){
        speedAxisY = speedAxisY* -1;
    }
    if(yPossition + ballR > canvasHeight){
        document.write("GAME OVER");
        throw new Error('Error');
    }
};

var snapBackCatwalk = function() {
    noStroke();
    fill(0,255,0);
    rect(mouseX - catwalkWidth/2, yPossitionCatWalk,catwalkWidth,catwalkHeight);

    if((yPossition +ballR >= yPossitionCatWalk) && 
    (xPossition + ballR > mouseX - catwalkWidth/2) &&
    (xPossition-ballR < mouseX + catwalkWidth)) {
        speedAxisY =speedAxisY *-1;
    }
};


var drawBlocks = function(){
    stroke(0,0,0);

    for(var j = 0; j< blocksRows; j++){
       for (var i =0; i < blockInRow; i++){
        if(blocks[j][i] == true){
            if((yPossition - ballR < blockHight * j)&&
            (xPossition - ballR >= blockWidth * i) &&
            (xPossition + ballR<=blockWidth*(i +1))){
                blocks[j][i] = false;
                speedAxisY * -1;
                blocksHit +=1;
                if (blocksHit == blockInRow *blocksRows){
                    document.write("Hello Winner!")
                }
            }else{
            fill( 20*(i+j), 255/(i+j),(i*2)+j+50);
            rect(i*blockWidth,j*blockHight,blockWidth,blockHight);
            }
        }
    }
}

};
for (var j =0; j < blocksRows;j++){
    for ( var i  = 0; i <blockInRow;i++){
        if(i === 0){
            blocks[j] = []
        }
        blocks[j][i] = true;
    }
}

void draw() {
    background(204,255,204);
    mainBall();

    snapBackCatwalk();
    drawBlocks();
    xPossition = xPossition +speedAxisX;
    yPossition = yPossition +speedAxisY;
};


