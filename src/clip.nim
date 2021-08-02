import illwill
import sequtils
import strutils



# ClipBoard object
#   -> copiedText:
#       -> sequence of text strings that where copied.
#       -> all strings should be unique
#   -> cursor:
#       -> integer that determines what text is currently selected
#   -> maximum:
#       -> maximum number of strings hold in copiedText
type ClipBoard* = object
  copiedText*: seq[string]
  cursor*: int
  maximum*: int



# Create a new default Clipboard Object
proc newClipBoard* (): ClipBoard =
  result = ClipBoard(copiedText: @[], cursor: 0, maximum: 25)



# Move the cursor by a *delta*
proc moveCursor*(c: var ClipBoard, delta: int) =
  let newCursor = c.cursor + delta

  # cursor can't be less than 0
  if newCursor < 0:
    c.cursor = 0

  # cursor can't be more than
  # the length of the copied strings
  elif newCursor >= len(c.copiedText):
    c.cursor = len(c.copiedText) - 1

  # possible cursor
  else:
    c.cursor = newCursor



# Add a new string to copiedText
proc addText(c: var ClipBoard, text: string) =
  # if the current number of copiedText's is less than setted max
  let isLessThanMax = len(c.copiedText) < c.maximum

  # just add text to the beginning of copiedText
  if isLessThanMax:
    c.copiedText = @[text] & c.copiedText

  # add text to the beginning of copiedText
  # but remove the last copied text
  # so that the length is not larger than the max
  else:
    c.copiedText = @[text] & c.copiedText[0 ..< ^1]



# remove one *text* from copiedText
proc deleteText*(c: var ClipBoard) =
  # When the length of copiedText is 1,
  # it just becomes an empty seq
  if len(c.copiedText) == 1:
    c.copiedText = @[]

  # delete the first text
  elif c.cursor == 0:
    c.copiedText = c.copiedText[1 .. ^1]

  # delete a the current cursor text
  elif c.cursor < len(c.copiedText):
    # (text from start to before cursor)
    # +
    # (text after cursor to the end)
    c.copiedText = c.copiedText[0 ..< c.cursor] & c.copiedText[c.cursor + 1 .. ^1]

  # delete the last text
  else:
    c.copiedText = c.copiedText[0 .. ^2]

  # reset the cursor to 0
  c.cursor = 0


# Set copiedText to an empty seq
# Reset the cursor to 0
proc eraseAllText*(c: var ClipBoard) =
  c.copiedText = @[]
  c.cursor = 0



# update the clipBoard with a new text
proc update*(c: var ClipBoard, text: string) =
  if len(c.copiedText) > 0:
    # check if the text that is trying to be added
    # already is in copiedText
    let isInList = text in c.copiedText

    # if not just add text
    if not isInList:
      c.addText(text)

  # just add text if copiedText is not empty
  else:
    c.addText(text)



# Process a text cell before it gets drawn to the screen
proc processToDraw*(text: string): string =
  # remove "new lines"
  result = text.replace("\n", " ")



# Get the current text so that it can be copied
proc stringToCopy*(c: var ClipBoard): string =
  return c.copiedText[c.cursor]



# Draw the ClipBoard to the screen
proc draw*(c: var ClipBoard, tb: var TerminalBuffer) =
  # Header
  tb.setForegroundColor(fgBlue)
  tb.write(1,1, "ClipClap")
  tb.fill(0,2, terminalWidth(), 2, "‾")

  tb.setForegroundColor(fgWhite)

  var y = 3

  # draw each text after cursor
  for i, text in c.copiedText[c.cursor .. ^1]:
    # process text to remove "new lines"
    let drawableText = text.processToDraw()

    # text selected by the cursor
    if i == 0:
      tb.setBackgroundColor(bgBlue)
      tb.fill(0,y, terminalWidth(), y, " ")
      tb.write(2, y, drawableText)
      tb.setBackgroundColor(bgNone)

    # just write the text
    else:
      tb.write(2, y, drawableText)

    # new line
    y += 2




