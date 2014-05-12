module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-less'

  grunt.registerTask 'build', 'build app', () ->
    grunt.task.run [
      'clean:all'
      'copy:haml'
      'coffee',
      'less:dev'
    ]

  grunt.initConfig
    watch:
      configFiles:
        files: ['Gruntfile.coffee']
        options:
          reload: true
      coffeeIndex:
        files: 'src/server/index.coffee'
        tasks: [
          'coffeelint:index'
          'coffee:compileIndex'
        ]
      coffeeServer:
        files: 'src/server/coffee/*.coffee'
        tasks: [
          'coffeelint:server'
          'coffee:compileServer'
        ]
      coffeeClient:
        files: 'src/client/coffee/*.coffee'
        tasks: [
          'coffeelint:client'
          'coffee:compileClient'
        ]
      hamlChanged:
        files: 'src/server/haml/*.haml'
        tasks: [
          'clean:haml'
          'copy:haml'
        ]
      lessChanged:
        files: 'src/client/less/*.less'
        tasks: [
          'clean:less'
          'less'
        ]

    coffee:
      compileServer:
        expand: true,
        flatten: true,
        cwd: "#{__dirname}/src/server/coffee/"
        dest: "#{__dirname}/app/libs/"
        ext: '.js',
        src: ['*.coffee']
      compileClient:
        expand: true,
        flatten: true,
        cwd: "#{__dirname}/src/client/coffee/"
        dest: "#{__dirname}/app/js/"
        ext: '.js',
        src: ['*.coffee']
      compileIndex:
        files:
          'app/index.js': 'src/server/index.coffee'

    coffeelint:
      options:
        configFile: 'coffeelint.json'
      server: ['src/server/coffee/**/*']
      client: ['src/client/coffee/**/*']
      index: ['src/server/index.coffee']

    copy:
      haml:
        files: [
          expand: true
          cwd: 'src/server/haml/'
          src: ['**']
          dest: 'app/haml/'
          filter: 'isFile'
        ]
    clean:
      all: ['app/']
      haml: ['app/haml/']
      less: ['app/css/']

    less:
      dev:
        options:
          paths: ['src/client/less/']
        files:
          'app/css/main.css': 'src/client/less/main.less'

