import nigui, std/json, strutils

app.init()

# new window fuck yeah
var window = newWindow("TEOW")
window.height = 480
window.width = 640

# try:
  # var icon = newImage()                 # COMMENTING IT OUT UNTIL I FIGURE OUT WHAT THE FUCK IS WRONG
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

var openButton = newButton("Open file")
buttonsContainer.add(openButton)

var saveasButton = newButton("Save as")
buttonsContainer.add(saveasButton)

openButton.onClick = proc(event: ClickEvent) =
  var dialog = newOpenFileDialog()
  dialog.title = "Opening files..."
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
      textArea.text = "Cannot open file, try again"

saveasButton.onClick = proc(event: ClickEvent) =
  var dialog = SaveFileDialog()
  dialog.title = "Saving files as..."
  dialog.defaultName = "defaultName.txt"
  dialog.run()
  if dialog.file != "":
    try:
      textArea.text = "File saved succsessfully"
    except OSError as e:
      textArea.text = "Error: Couldn't save file"
  else:
    textArea.text = "Task failed successfully"

window.show()
app.run()
