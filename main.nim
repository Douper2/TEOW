import nigui, os, strutils
from os import fileExists


app.init()

let file = "plugin.txt"
var lines = newSeq[string]()
if fileExists(file):
  lines = readFile(file).splitLines()

# new window fuck yeah
var window = newWindow("TEOW")
window.height = 480
window.width = 640

# try:
  # var icon = newImage()                   # COMMENTING IT OUT UNTIL I FIGURE OUT WHAT THE FUCK IS WRONG
  # if icon.loadFromFile("icon.png")
  # window.icon = icon
  # else:
    # echo "Failed to set the icon"
# except Exception as e:
  # echo "Error setting the icon"

var mainContainer = newLayoutContainer(Layout_Vertical)
window.add(mainContainer)

var textArea = newTextArea()
mainContainer.add(textArea)

var buttonsContainer = newLayoutContainer(Layout_Horizontal)
mainContainer.add(buttonsContainer)

var openButton = newButton(lines[1])
buttonsContainer.add(openButton)

var saveasButton = newButton(lines[0])
buttonsContainer.add(saveasButton)

openButton.onClick = proc(event: ClickEvent) =
  var dialog = newOpenFileDialog()
  dialog.title = lines[2]
  dialog.multiple = true
  # dialog.directory = ""
  dialog.run()
  textArea.addLine($dialog.files.len & " files selected")
  if dialog.files.len > 0:
    let openedFile = dialog.files[0]
    var filecontent: string = ""
    try:
      filecontent = readFile(openedFile)
      textArea.text = filecontent
    except OSError as e:
      textArea.text = lines[3]

saveasButton.onClick = proc(event: ClickEvent) =
  var dialog = SaveFileDialog()
  dialog.title = lines[4]
  dialog.defaultName = "defaultName.txt"
  dialog.run()
  if dialog.file != "":
    try:
      textArea.text = lines[5]
    except OSError as e:
      textArea.text = lines[6]
  else:
    textArea.text = "Task failed successfully"

window.show()
app.run()
