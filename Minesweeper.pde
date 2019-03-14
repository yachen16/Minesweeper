import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
int NUM_ROWS = 30;
int NUM_COLS = 30;
int NUM_BOMBS = 120;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(600,700);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int i = 0; i < NUM_ROWS; i++){
      for(int j = 0; j < NUM_COLS; j++){
        buttons[i][j] = new MSButton(i, j);
      }
    }
    for(int i = 0; i < NUM_BOMBS; i++){
      setBombs();
    }
}
public void setBombs()
{
    //your code
  final int row = (int)(Math.random()*NUM_ROWS);
  final int col = (int)(Math.random()*NUM_COLS);
  if(bombs.contains(buttons[row][col])){
    setBombs();
  }else{
    bombs.add(buttons[row][col]);
  }
  background( 0 );
}

public void draw ()
{
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        if(buttons[r][c].isClicked() == false){
           return false;
        }
      }
    }
   return true;
}
public void displayLosingMessage()
{
    //your code here
    fill(255);
    textSize(20);
    text("TRY AGAIN", 290, 650);
}
public void displayWinningMessage()
{
    //your code here
    fill(255);
    textSize(20);
    text("YAY NICE JOB", 290, 650);
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 600/NUM_COLS;
        height = 600/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(mouseButton == RIGHT){
          marked = !marked;
          if(marked == false){
            clicked = false;
          }
        }else if(bombs.contains(this)){
          displayLosingMessage();
        }else if(countBombs(r, c) > 0){
          setLabel(""+countBombs(r,c));
        }else{
          for(int i = r-1; i <= r+1; i++){
            for(int j = c-1; j <= c+1; j++){
              if(isValid(i,j) && !buttons[i][j].isClicked()){
                buttons[i][j].mousePressed();
              }
            }
          }
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(255);
        textSize(10);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS){
          return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        for(int i = row-1; i <= row+1; i++){
          for(int j = col - 1; j <= col+1; j++){
            if(isValid(i,j) && bombs.contains(buttons[i][j])){
              numBombs++;
            }
          }
        }
        return numBombs;
    }
}


