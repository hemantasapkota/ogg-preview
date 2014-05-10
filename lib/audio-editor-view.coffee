_ = require 'underscore-plus'
{$, ScrollView} = require 'atom'

# View that renders the audio of an {AudioEditor}.
module.exports =
class AudioEditorView extends ScrollView
  @content: ->
    @div class: 'audio-view', tabindex: -1, =>
      @div class: 'audio-container', =>
        @audio class: 'none', controls: 'controls', =>
          @source outlet:'image'

  initialize: (editor) ->
    super

    @loaded = false
    @image.hide().attr('src', editor.getUri())

  afterAttach: (onDom) ->
    return unless onDom

    if pane = @getPane()
      @active = @is(pane.activeView)

      @subscribe pane, 'pane:active-item-changed', (event, item) =>
        wasActive = @active
        @active = @is(pane.activeView)

  # Retrieves this view's pane.
  #
  # Returns a {Pane}.
  getPane: ->
    @parents('.pane').view()
