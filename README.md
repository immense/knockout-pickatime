# Knockout Pickatime Binding

This binding adds a [pickadate.js timepicker](http://amsul.ca/pickadate.js) and
binds it to a knockout observable.

## Demo

Check out the [demo](http://rawgit.com/immense/knockout-pickatime/master/demo.html)
to get a quick idea of how it works and how to use it.

## Installation

The knockout-pickatime binding is available in the bower repository. To install
it in your bower enabled project, just do:

`bower install knockout-pickatime-binding`

## Usage

Bind to a text input:

```html
<input type='text' data-bind='pickatime: observable'>
```

Refer to the [demo](http://rawgit.com/immense/knockout-pickatime/master/demo.html)
page for detailed usage instructions.

## Building

To build knockout-pickatime from coffeescript source, do the
following in a node.js enabled environment:

```
npm install -g grunt-cli
npm install
grunt
```
## License

The knockout-pickatime binding is released under the MIT License. Please see the
LICENSE file for details.
