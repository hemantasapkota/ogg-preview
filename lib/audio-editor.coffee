path = require 'path'
fs = require 'fs-plus'

# Editor model for an audio file
module.exports =
class AudioEditor
  atom.deserializers.add(this)

  @deserialize: ({filePath}) ->
    if fs.isFileSync(filePath)
      new AudioEditor(filePath)
    else
      console.warn "Could not deserialize audio editor for path '#{filePath}' because that file no longer exists"

  constructor: (@filePath) ->

  serialize: ->
    {@filePath, deserializer: @constructor.name}

  getViewClass: ->
    require './audio-editor-view'

  # Retrieves the filename of the open file.
  #
  # This is `'untitled'` if the file is new and not saved to the disk.
  #
  # Returns a {String}.
  getTitle: ->
    if @filePath?
      path.basename(@filePath)
    else
      'untitled'

  # Retrieves the URI of the audio.
  #
  # Returns a {String}.
  getUri: ->
    @filePath

  # Retrieves the absolute path to the audio.
  #
  # Returns a {String} path.
  getPath: ->
    @filePath

  # Compares two {AudioEditor}s to determine equality.
  #
  # Equality is based on the condition that the two URIs are the same.
  #
  # Returns a {Boolean}.
  isEqual: (other) ->
    other instanceof AudioEditor and @getUri() is other.getUri()
