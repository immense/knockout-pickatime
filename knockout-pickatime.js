(function() {
  ko.bindingHandlers.pickatime = {
    init: function(element, valueAccessor, allBindings) {
      var $clear_button_addon, $clock_addon, key, options, options_from_binding, pickatime_options, picker, val, value, wrapper_id, _init_picker;
      value = valueAccessor();
      options = {
        clear: 'Clear',
        format: 'h:i A',
        formatLabel: void 0,
        formatSubmit: void 0,
        hiddenPrefix: void 0,
        hiddenSuffix: '_submit',
        editable: void 0,
        interval: 30,
        min: void 0,
        max: void 0,
        disable: void 0,
        container: void 0,
        onStart: void 0,
        onRender: void 0,
        onOpen: void 0,
        onClose: void 0,
        onSet: void 0,
        onStop: void 0,
        klass: {
          input: 'picker__input',
          active: 'picker__input--active',
          picker: 'picker picker--time',
          opened: 'picker--opened',
          focused: 'picker--focused',
          holder: 'picker__holder',
          frame: 'picker__frame',
          wrap: 'picker__wrap',
          box: 'picker__box',
          list: 'picker__list',
          listItem: 'picker__list-item',
          disabled: 'picker__list-item--disabled',
          selected: 'picker__list-item--selected',
          highlighted: 'picker__list-item--highlighted',
          viewset: 'picker__list-item--viewset',
          now: 'picker__list-item--now',
          buttonClear: 'picker__button--clear'
        }
      };
      pickatime_options = allBindings.get('pickatime_options');
      if ('function' === typeof pickatime_options) {
        options_from_binding = pickatime_options();
      } else {
        options_from_binding = pickatime_options || {};
      }
      for (key in options_from_binding) {
        val = options_from_binding[key];
        options[key] = val;
      }
      _init_picker = function($elem) {
        return $elem.attr('autocomplete', 'off').pickatime(options).pickatime('picker');
      };
      if (options.clear_button_addon || options.clock_addon) {
        wrapper_id = new Date().getTime();
        options.container = "#" + wrapper_id;
        $clock_addon = options.clock_addon ? $("<span class='input-group-addon'>" + "<i style='color: navy; cursor: pointer'" + "title='A time picker appears when interacting with this field'" + "class='fa fa-clock-o'>" + "</i>" + "</span>") : void 0;
        $clear_button_addon = options.clear_button_addon ? $("<span class='input-group-addon'>" + "<i style='color: navy; cursor: pointer'" + "title='Click to clear time'" + "class='fa fa-times'>" + "</i>" + "</span>") : void 0;
        picker = _init_picker($(element).wrap($("<div id=" + wrapper_id + "></div>")).wrap($("<div class='input-group'></div>")).after($clear_button_addon).after($clock_addon));
        if (options.clock_addon) {
          $clock_addon.on("click", function(event) {
            picker.open();
            event.stopPropagation();
            return event.preventDefault();
          });
        }
        if (options.clear_button_addon) {
          $clear_button_addon.on("click", function(event) {
            picker.set('clear');
            event.stopPropagation();
            return event.preventDefault();
          });
        }
      } else {
        picker = _init_picker($(element));
      }
      picker.on('set', function(context) {
        var item;
        item = picker.get('select');
        if (item) {
          if (item !== value()) {
            return value(picker.get());
          }
        } else {
          return value(item);
        }
      });
      ko.utils.domNodeDisposal.addDisposeCallback(element, function() {
        if (options.clock_addon) {
          $clock_addon.off('click');
        }
        if (picker.get('start')) {
          return picker.stop();
        }
      });
    },
    update: function(element, valueAccessor, allBindings) {
      var new_val, picker, value;
      value = valueAccessor();
      new_val = ko.unwrap(value);
      picker = $(element).pickatime('picker');
      if ((new_val == null) || new_val === '') {
        picker.set('clear');
        return;
      }
      picker.set('select', new_val);
    }
  };

}).call(this);
