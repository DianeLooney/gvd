void main() {
  gl_Position = gl_in[0].gl_Position;
  fragTexCoord = geomTexCoord[0];
  EmitVertex();
  gl_Position = gl_in[1].gl_Position; 
  fragTexCoord = geomTexCoord[1];
  EmitVertex();
  gl_Position = gl_in[2].gl_Position; 
  fragTexCoord = geomTexCoord[2];
  EmitVertex();
  EndPrimitive();
}  
