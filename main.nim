import nimclipboard/libclipboard
import illwill
import strutils
import os

import src/load
import src/clip
import src/message
import src/processor
import src/procs



# Rerender
proc rerenderIllWill(cb: var ptr clipboard_c, clipBoard: var ClipBoard, message: var Message) =
  # new terminal buffer
  var tb = newTerminalBuffer(terminalWidth(), terminalHeight())

  # process the key the user pressed
  keyProcessor(cb, clipBoard, message)

  # update the clipboard
  updateProc(cb, clipBoard)

  # draw the new frame
  drawProc(tb, clipBoard, message)



proc main() =
  # setup illwill
  setupProc()

  try:
    # create important variables
    var cb = clipboardNew(nil)
    var clipBoard = loadSettings()
    var message = newMessage()

    # main loop
    while true:
      rerenderIllWill(cb, clipBoard, message)

    # end
    cb.clipboard_free()

  except:
    exitProc()

main()
