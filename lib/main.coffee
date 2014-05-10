path = require 'path'
_ = require 'underscore-plus'
AudioEditor = require './audio-editor'

module.exports =
  activate: ->
    atom.workspace.registerOpener(openUri)

  deactivate: ->
    atom.workspace.unregisterOpener(openUri)

# Files with these extensions will be opened as audio preview
audioExtensions = ['.ogg']
openUri = (uriToOpen) ->
  uriExtension = path.extname(uriToOpen).toLowerCase()
  if _.include(audioExtensions, uriExtension)
    new AudioEditor(uriToOpen)
