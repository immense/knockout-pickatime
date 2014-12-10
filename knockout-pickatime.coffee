ko.bindingHandlers.pickatime =
  init: (element, valueAccessor, allBindings) ->
    value = valueAccessor()
    options =
      # Translations and clear button
      clear: 'Clear'

      # Formats
      format: 'h:i A'
      formatLabel: undefined
      formatSubmit: undefined
      hiddenPrefix: undefined
      hiddenSuffix: '_submit'

      # Editable input
      editable: undefined

      # Time intervals
      interval: 30

      # Time limits
      min: undefined
      max: undefined

      # Disable times
      disable: undefined

      # Root container
      container: undefined

      # Events
      onStart: undefined
      onRender: undefined
      onOpen: undefined
      onClose: undefined
      onSet: undefined
      onStop: undefined

      # Classes
      klass: {

          # The element states
          input: 'picker__input'
          active: 'picker__input--active'

          # The root picker and states *
          picker: 'picker picker--time'
          opened: 'picker--opened'
          focused: 'picker--focused'

          # The picker holder
          holder: 'picker__holder'

          # The picker frame wrapper and box
          frame: 'picker__frame'
          wrap: 'picker__wrap'
          box: 'picker__box'

          # List of times
          list: 'picker__list'
          listItem: 'picker__list-item'

          # Time states
          disabled: 'picker__list-item--disabled'
          selected: 'picker__list-item--selected'
          highlighted: 'picker__list-item--highlighted'
          viewset: 'picker__list-item--viewset'
          now: 'picker__list-item--now'

          # Clear button
          buttonClear: 'picker__button--clear'
      }

    pickatime_options = allBindings.get('pickatime_options')

    if 'function' is typeof pickatime_options
      options_from_binding = pickatime_options()
    else
      options_from_binding = pickatime_options or {}

    for key, val of options_from_binding
      options[key] = val

    _init_picker = ($elem) ->
      return $elem
        .attr 'autocomplete', 'off'
        .pickatime options
        .pickatime 'picker'

    if options.clear_button_addon or options.clock_addon
      wrapper_id = new Date().getTime()
      options.container = "##{wrapper_id}"
      clock_addon_position = if options.clock_addon is 'before' then 'before' else 'after'
      clear_button_addon_position = if options.clear_button_addon is 'before' then 'before' else 'after'
      $clock_addon =
        if options.clock_addon
          $(
            "<span class='input-group-addon'>" +
              "<i style='color: navy; cursor: pointer'" +
                "title='A time picker appears when interacting with this field'" +
                "class='fa fa-clock-o'>" +
              "</i>" +
            "</span>"
          )
        else
          undefined

      $clear_button_addon =
        if options.clear_button_addon
          $(
            "<span class='input-group-addon'>" +
              "<i style='color: navy; cursor: pointer'" +
                "title='Click to clear time'" +
                "class='fa fa-times'>" +
              "</i>" +
            "</span>"
          )
        else
          undefined

      picker = _init_picker(
        $(element)
          .wrap $("<div id=#{wrapper_id}></div>")
          .wrap $("<div class='input-group'></div>")
      )

      $(element)[clear_button_addon_position] $clear_button_addon
      $(element)[clock_addon_position] $clock_addon

      if options.clock_addon
        $clock_addon.on "click", (event) ->
          picker.open()
          event.stopPropagation()
          event.preventDefault()

      if options.clear_button_addon
        $clear_button_addon.on "click", (event) ->
          picker.set('clear')
          event.stopPropagation()
          event.preventDefault()
    else
      picker = _init_picker $(element)

    picker.on 'set', (context) ->
      item = picker.get('select')
      if item
        if item isnt value()
          value picker.get()
      else
        value item

    ko.utils.domNodeDisposal.addDisposeCallback element, ->

      if options.clock_addon
        $clock_addon.off 'click'

      if options.clear_button_addon
        $clear_button_addon.off 'click'

      picker.stop() if picker.get('start')

    return

  update: (element, valueAccessor, allBindings) ->
    value   = valueAccessor()
    new_val = ko.unwrap value
    picker  = $(element).pickatime('picker')

    # observable updated with a blank time means we empty the input
    if not new_val? or new_val is ''
      picker.set('clear')
      return

    # Try setting picker to whatever was passed in
    #
    # Pickadate seems to convert anything it can't handle (e.g. errors, NaN) to current time
    # TODO: Maybe there's something more sensible than that?
    picker.set 'select', new_val

    return
