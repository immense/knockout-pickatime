module.exports = (grunt) ->
  grunt.initConfig {

    # compile coffeescript files
    coffee:
      pickatime:
        files:
          'knockout-pickatime.js': 'knockout-pickatime.coffee'

    # uglifyjs files
    uglify:
      pickatime:
        src: 'knockout-pickatime.js'
        dest: 'knockout-pickatime.min.js'
  }

  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask('default', [
    'coffee',
    'uglify'
  ])
