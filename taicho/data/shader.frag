precision highp float;

#define PI 3.14159265

uniform vec2 resolution;
uniform sampler2D texture;

void main() {
  vec2 uv = gl_FragCoord.xy / resolution;
  vec3 tex = texture2D( texture, uv ).xyz;
  vec3 ret = (
    ( tex.x < 3.0 / 255.0 ) ? vec3( 0.0, 0.0, 0.0 )
    : ( tex.x < 5.0 / 255.0 ) ? vec3( 0.0, 0.2, 0.1 )
    : ( tex.x < 7.0 / 255.0 ) ? vec3( 0.0, 0.3, 0.4 )
    : ( tex.x < 9.0 / 255.0 ) ? vec3( 0.1, 0.4, 0.6 )
    : ( tex.x < 11.0 / 255.0 ) ? vec3( 0.3, 0.3, 0.8 )
    : ( tex.x < 13.0 / 255.0 ) ? vec3( 0.6, 0.2, 1.0 )
    : ( tex.x < 15.0 / 255.0 ) ? vec3( 0.7, 0.4, 1.0 )
    : vec3( 0.0, 0.0, 0.0 )
  );

  gl_FragColor = vec4( ret, 1.0 );
}