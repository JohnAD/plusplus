# Package

version       = "0.1"
author        = "John Dupuy"
description   = "Web framework for both the front HTML/JS and the C backend API"
license       = "MIT"
srcDir        = "src"
skipDirs      = @["tool"]

# Dest

# namedBin["plusplus"] = "tool/plusplustool"

# Dependencies

requires "nim == 1.6.2"
requires "httpBeast == 0.4.1"
requires "karax == 1.3.0"
