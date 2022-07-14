A Lua script using the Aseprite API to provide a method for deleting large chunks of frames in steps.
\
\
Useful for reducing the framecount of a source animation when rotoscoping.
\
\
\
Configure
  - The step size when considering what frames to remove
  - The offset from the start of the selection 
  - Whether to update the frame duration after deletion, (i.e. if the duration of a frame is 60ms, with a step size of 2, the frame duration will become 120ms) 

\
Includes a small preview showing the pattern of which frames will be deleted (highlighted in black)
\
\
\
\
Demo:
![Alt Text](demo.gif)
