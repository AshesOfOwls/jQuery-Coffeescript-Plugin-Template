#  Project: Plugin Name
#  Description:
#  Author:
#  Maintained By:
#  License:
#
#  Version: 1.0

(($, window, document, undefined_) ->
  pluginName = 'tacky'

  defaults = 
    are: 'useful'

  Plugin = (element, options) ->
    @options = $.extend({}, defaults, options)
    @$element = $(element)

    @init()

  Plugin:: =
    init: ->
      # Do stuff
      @_privateFunction()
      @publicFunction()

    publicFunction: ->
      # Can be used with .pluginName('publicFunction')

    _privateFunction: ->
      # Keep it in your pants

  # -----------------------------------
  # Initialization
  # Allows private and public functions
  # -----------------------------------
  $.fn[pluginName] = (options) ->
    args = arguments
    scoped_name = "plugin_" + pluginName
    
    if options is `undefined` or typeof options is "object"
      # Initialization
      @each ->
        unless $.data(@, scoped_name)
          $.data @, scoped_name, new Plugin(@, options)

    else if typeof options is "string" and options[0] isnt "_" and options isnt "init"
      # Calling public methods
      returns = undefined
      @each ->
        instance = $.data(@, scoped_name)

        if instance instanceof Plugin and typeof instance[options] is "function"
          returns = instance[options].apply(instance, Array::slice.call(args, 1))

        $.data @, scoped_name, null  if options is "destroy"
      (if returns isnt `undefined` then returns else @)
) jQuery, window, document