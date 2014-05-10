path = require 'path'
AudioEditor = require '../lib/audio-editor'
AudioEditorView = require '../lib/audio-editor-view'
{WorkspaceView} = require 'atom'

describe "AudioEditor", ->
  describe ".deserialize(state)", ->
    it "returns undefined if no file exists at the given path", ->
      spyOn(console, 'warn') # suppress logging in spec
      editor = new AudioEditor(path.join(__dirname, 'fixtures', 'example.ogg'))
      state = editor.serialize()
      expect(AudioEditor.deserialize(state)).toBeDefined()
      state.filePath = 'bogus'
      expect(AudioEditor.deserialize(state)).toBeUndefined()

  describe ".activate()", ->
    it "registers a project opener that handles audio file extension", ->
      atom.workspaceView = new WorkspaceView()
      atom.workspace = atom.workspaceView.model

      waitsForPromise ->
        atom.packages.activatePackage('ogg-preview')

      runs ->
        atom.workspaceView = new WorkspaceView()
        atom.workspaceView.open(path.join(__dirname, 'fixtures', 'example.ogg'))

      waitsFor ->
        atom.workspace.getActivePaneItem() instanceof AudioEditor

      runs ->
        expect(atom.workspace.getActivePaneItem().getTitle()).toBe 'example.ogg'
        atom.workspaceView.destroyActivePaneItem()
        atom.packages.deactivatePackage('ogg-preview')

        atom.workspaceView.open(path.join(__dirname, 'fixtures', 'example.ogg'))

      waitsFor ->
        atom.workspace.getActivePaneItem()?

      runs ->
        expect(atom.workspace.getActivePaneItem() instanceof AudioEditor).toBe false
