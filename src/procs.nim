import nimclipboard/libclipboard
import illwill
import strutils
import clip
import message
import os



# Illwill boilerplate code for exiting
proc exitProc*() {.noconv.} =
  illwillDeinit()
  showCursor()
  quit(0)



# UP key binding
proc upProc*(clipBoard: var ClipBoard) =
  # move cursor up
  clipBoard.moveCursor(-1)



# DOWN key binding
proc downProc*(clipBoard: var ClipBoard) =
  # move cursor down
  clipBoard.moveCursor(1)



# C key binding
# Copy text to the clipboard
proc copyProc*(cb: var ptr clipboard_c, clipBoard: var ClipBoard, message: var Message) =
  # get the text that should be copied
  # (the text selected by the cursor)
  let toCopy = clipBoard.stringToCopy()

  # copy to the system clipBoard
  discard cb.clipboard_set_text(toCopy)

  # update message
  message.setMsg("Copied: " & toCopy)



# D key binding
# Delete the selected text
proc deleteProc*(clipBoard: var ClipBoard, message: var Message) =
  # delete the text that should be deleted
  # (the text selected by the cursor)
  clipBoard.deleteText()

  # update message
  message.setMsg("Deleted a value")



# E key binding
# Erase all text
proc eraseProc*(clipBoard: var ClipBoard, message: var Message) =
  # Erase everything
  clipBoard.eraseAllText()

  # update message
  message.setMsg("Erased the copy History")



# Illwill Boilerplate code
# init the illwill app
proc setupProc*() =
  illwillInit(fullscreen=true)
  setControlCHook(exitProc)
  hideCursor()



# update the clipBoard
proc updateProc*(cb: var ptr clipboard_c, clipBoard: var ClipBoard) =
  clipBoard.update($cb.clipboardText)



# draw the app to the screen
proc drawProc*(tb: var TerminalBuffer, clipBoard: var ClipBoard, message: var Message) =
  # draw clipboard
  clipBoard.draw(tb)

  # draw message
  message.draw(tb)

  # render the terminal buffer to the real terminal screen
  tb.display()
  sleep(20)
