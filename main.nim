import nigui, os, strutils
from os import fileExists

app.init()

var
  textcontent = ""
  searchterm = ""

let file = "plugin.txt"
var lines = newSeq[string]()
if fileExists(file):
  lines = readFile(file).splitLines()

# new window fuck yeah
var window = newWindow("TEOW")
window.height = 480
window.width = 640
window.iconPath = "icon.png"

var mainContainer = newLayoutContainer(Layout_Vertical)
window.add(mainContainer)

var textArea = newTextArea()
mainContainer.add(textArea)

var buttonsContainer = newLayoutContainer(Layout_Horizontal)
mainContainer.add(buttonsContainer)

var openButton = newButton(lines[1]) # Open file
buttonsContainer.add(openButton)

var saveasButton = newButton(lines[0]) # Save as
buttonsContainer.add(saveasButton)

var helpbutton = newButton("Placeholder")
buttonsContainer.add(helpbutton)

var findButton = newButton(lines[13]) # Find
buttonsContainer.add(findButton)

openButton.onClick = proc(event: ClickEvent) =
  var dialog = newOpenFileDialog()
  dialog.title = lines[2] # Opening files...
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
      textArea.text = lines[3]  # Cannot open file, try again

saveasButton.onClick = proc(event: ClickEvent) =
  var dialog = SaveFileDialog()
  dialog.title = lines[4] # Saving files...
  dialog.defaultName = "file.txt"
  dialog.run()
  if dialog.file != "":
    try:
      writeFile(dialog.file, textArea.text)
      textArea.text = lines[5] # File saved successfully
    except OSError as e:
      textArea.text = lines[6] # Error: Couldn't save file
  else:
    textArea.text = "Task failed successfully"

window.show()
app.run()