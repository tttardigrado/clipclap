import json
import os
import clip



# Load settings from the config json
proc loadSettings*(): ClipBoard =
  var clip: ClipBoard

  # process path by expanding "~" -> user (ex: home/force/)
  let pathToConfig = expandTilde("~/.config/clipclap/settings.json")
  try:
    # load json settings
    let toLoad = parseJson(readFile(pathToConfig))

    # maximum number of copied lines
    let maximum = toLoad["max"].getInt()

    # preCopied text that is set from the json file
    var preCopied: seq[string] = @[]

    # iterate through the precopied text from the json file
    var i = 0
    for str in toLoad["preCopied"]:
      # if the number of added text
      # has not exceded the maximum
      # add the new text
      if i < maximum:
        preCopied.add(str.getStr())
        inc(i)
      else:
        break

    clip = ClipBoard(copiedText: preCopied, cursor: 0, maximum: maximum)

  except:
    # on error return a default clipboard
    clip = newClipBoard()

  result = clip
