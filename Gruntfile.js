module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json')
  });

  // Load the plugin that provides the "jquery-mobile" task.
  grunt.loadNpmTasks('grunt-contrib-jquery-mobile');

  // Default task(s).
  grunt.registerTask('default', ['jquery-mobile']);

};
