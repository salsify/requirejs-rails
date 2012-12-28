# Avoid being trapped inside a frame
doc = document
blankOutPage = -> doc.body.innerHTML = ""
getOutOfFrame = ->
  doc.write = ""
  window.top.location = window.self.location
  setTimeout blankOutPage, 9
  window.self.onload = blankOutPage

if window.top != window.self
  try
    window.top.location.host || getOutOfFrame()
  catch error
    getOutOfFrame()

# Console log proctection
noop = ->
methods = ["assert", "clear", "count", "debug", "log", "warn", "error", "trace", "info"]
length = methods.length
console = (window.console = window.console || {})
while length--
  method = methods[length]
  console[method] = noop unless console[method]

className = doc.documentElement.className
doc.documentElement.className = className.replace(/\bno-js\b/g, '')