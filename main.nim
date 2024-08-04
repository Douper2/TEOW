import nigui, std/json, strutils

app.init()

# new window fuck yeah (i tried so much shit out just for it to work its unbeliveable)
var window = newWindow("TEST APP")
window.height = 480
window.width = 640

var mainContainer = newLayoutContainer(Layout_Vertical)
window.add(mainContainer)

var textArea = newTextArea()
mainContainer.add(textArea)

var buttonsContainer = newLayoutContainer(Layout_Horizontal)
mainContainer.add(buttonsContainer)

var openButton = newButton("Open file")
buttonsContainer.add(openButton)

openButton.onClick = proc(event: ClickEvent) =
  var dialog = newOpenFileDialog()
  dialog.title = "I wanna die help"
  dialog.multiple = true
  if dialog.run() and (dialog.files.len > 0):
    let selected_file = dialog.files[0]
    var filecontent = ""
    try:
      filecontent = readFile(selected_file)
      textArea.text = filecontent
    except OSError as e:
      textArea.text = "Error reading file"
  else:
      textArea.text = "No file selected."

window.show()
app.run()
