import nimclipboard/libclipboard
import illwill
import clip
import message
import procs



# Key Processing proc that reads and executes diferent functions
# depending on the key that is pressed
proc keyProcessor*(cb: var ptr clipboard_c, clipBoard: var ClipBoard, message: var Message) =
  let key = getKey()

  case key
    of Key.Escape, Key.Q:
      # Quit
      exitProc()

    of Key.Down, Key.J, Key.ShiftJ:
      # Move the cursor down
      # process down
      downProc(clipBoard)

    of Key.Up, Key.K, Key.ShiftK:
      # Move the cursor up
      # process up
      upProc(clipBoard)

    of Key.C, Key.ShiftC, Key.Enter, Key.Space:
      # Copy to the clipboard
      # process copy
      copyProc(cb, clipBoard, message)

    of Key.D, Key.ShiftD, Key.Delete, Key.Backspace:
      # Delete the selected text
      # process deletion
      deleteProc(clipBoard, message)

    of Key.E, Key.ExclamationMark:
      # erase/clear all copied text
      # process clearing/erasing
      eraseProc(clipBoard, message)

    else:
      # non relevant keys
      discard



