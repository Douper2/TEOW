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
  dialog.title = "Test Open"
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

window.show()
app.run()
