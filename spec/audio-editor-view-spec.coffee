{WorkspaceView, View} = require 'atom'
AudioEditorView = require '../lib/audio-editor-view'
AudioEditor = require '../lib/audio-editor'

describe "AudioEditorView", ->
  [editor, view, filePath] = []

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    filePath = atom.project.resolve('example.ogg')
    editor = new AudioEditor(filePath)
    view = new AudioEditorView(editor)
    view.attachToDom()
    view.height(100)

    waitsFor -> view.loaded
