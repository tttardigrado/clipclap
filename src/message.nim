import illwill
import strutils



# Message Type
# composed of:
#   -> msg:
#     -> string to be shown at the bottom of the screen
#   -> color:
#     -> foreground color in which the message will be written in
type Message* = object
  msg: string
  color: ForegroundColor



# Create and return a new *Default* Message Object
proc newMessage*(): Message =
  result = Message(msg: "", color: fgBlue)



# Set the msg (message) parameter of a Message Object
proc setMsg*(m: var Message, msgToSet: string) =
  # Replace the "new line" characters
  # this is done so that the new lines
  # won't interfere and disturb the
  # render of the message
  m.msg = msgToSet.replace("\n", " ")



# Set the color parameter of a Message Object
proc setColor*(m: var Message, colorToSet: ForegroundColor) =
  m.color = colorToSet



# Draw the Message object as a Widget to the screen
proc draw*(m: Message, tb: var TerminalBuffer) =
  # 3 cells before the end of the screen
  let yStartPos = terminalHeight() - 3

  # setting the bg and fg colors
  tb.setForegroundColor(m.color)
  tb.setBackgroundColor(bgNone)

  # create a divider line
  tb.fill(0,yStartPos, terminalWidth(), terminalHeight(), "_")

  # clear the screen after the line
  tb.fill(0,yStartPos + 1, terminalWidth(), terminalHeight(), " ")

  # write the message to the previously cleared screen
  tb.write(1, yStartPos + 1, m.msg)
