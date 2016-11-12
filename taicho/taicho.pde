final int frames = 140;

PImage img;
PShader shader;

float[][][] array;
int arraySw;

boolean initFrame = true;

void setup() {
  size( 96, 96, P2D );
  
  img = loadImage( "text.png" );
  
  shader = loadShader( "shader.frag" );
  shader.set( "resolution", width * 1.0, height * 1.0 );
  
  array = new float[ 2 ][ width ][ height ];
  arraySw = 0;
}

void draw() {
  if ( initFrame ) {
    initFrame = false;
    
    background( 0 );
    tint( 15 );
    image( img, 1, 37 );
    tint( 255 );
    
    loadPixels();
    for ( int iy = 0; iy < height; iy ++ ) {
      for ( int ix = 0; ix < width; ix ++ ) {
        println( (int)red( pixels[ ix + iy * width ] ) );
        array[ arraySw ][ iy ][ ix ] = (int)red( pixels[ ix + iy * width ] );
      }
    }
  }
  
  float time = frameCount * 1.0 % frames / frames; 
  
  arraySw = 1 - arraySw;
  for ( int iy = 0; iy < height; iy ++ ) {
    for ( int ix = 0; ix < width; ix ++ ) {
      float p = array[ 1 - arraySw ][ iy ][ ix ];
      
      if ( p != 15.0 ) {
        p = 0;
        for ( int icy = -1; icy < 2; icy ++ ) {
          for ( int icx = -1; icx < 2; icx ++ ) {
            if ( 0 <= icx + ix && icx + ix < width && 0 <= icy + iy && icy + iy < height ) {
              float n = array[ 1 - arraySw ][ icy + iy ][ icx + ix ];
              float out = n - random( 0.0, 4.0 );
              if ( n == 15.0 ) {
                out *= 0.5 - 0.5 * cos( time * PI * 2.0 );
              }
              p = max( p, out );
            }
          }
        }
      }
      
      array[ arraySw ][ iy ][ ix ] = p;
      pixels[ ix + iy * width ] = color( p );
    }
  }
  updatePixels();
  
  filter( shader );
  
  saveFrame( "out/#####.png" );
}