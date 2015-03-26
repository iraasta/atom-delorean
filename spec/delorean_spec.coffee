AsciiArt = require '../lib/ascii-art'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Delorean", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)

    waitsForPromise ->
      atom.workspace.open()

  it "converts", ->
    editor = atom.workspace.getActiveTextEditor()
    editor.insertText("cool")
    editor.selectAll()
    changeHandler = jasmine.createSpy('changeHandler')
    editor.onDidChange(changeHandler)

    atom.commands.dispatch workspaceElement, 'ascii-art:convert'

    waitsForPromise ->
      activationPromise

    waitsFor ->
      changeHandler.callCount > 0

    runs ->
