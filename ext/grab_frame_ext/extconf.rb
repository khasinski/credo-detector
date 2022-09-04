require "mkmf"

$CXXFLAGS << " -std=c++11 "
$INCFLAGS << " -I/opt/homebrew/opt/opencv/include/opencv4/   "
$LDFLAGS << " -L/opt/homebrew/opt/opencv/lib -lopencv_core -lopencv_videoio"

create_makefile("grab_frame_ext")
