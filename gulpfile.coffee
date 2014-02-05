gulp = require "gulp"
coffee = require "gulp-coffee"
uglify = require "gulp-uglify"
clean = require "gulp-clean"
concat = require "gulp-concat"
jade = require "gulp-jade"
connect = require "gulp-connect"
watch = require "gulp-watch"
styl = require "gulp-stylus"

gulp.task "default", ["connect", "coffee", "concat", "jade", "styl"], ->

gulp.task "coffee", ->
  gulp.src "src/*.coffee"
    .pipe watch()
    .pipe coffee()
    .pipe gulp.dest "javascripts"
    .pipe connect.reload()

gulp.task "concat", ->
  gulp.src ["bower_components/jquery/jquery.js", "bower_components/moment/moment.js", "javascripts/app.js"]
    .pipe concat "app.min.js"
    .pipe uglify()
    .pipe gulp.dest "javascripts/"

gulp.task "jade", ->
  gulp.src "src/*.jade"
    .pipe watch()
    .pipe jade()
    .pipe gulp.dest ""
    .pipe connect.reload()

gulp.task "styl", ->
  gulp.src "src/*.styl"
    .pipe watch()
    .pipe styl()
    .pipe gulp.dest "stylesheets/"
    .pipe connect.reload()

gulp.task "connect", connect.server(
  root: __dirname
  port: 3000
  livereload: true
  open:
    browser: "chrome"
)

gulp.task "clean javascripts", ->
  gulp.src "javascripts/"
    .pipe clean()

gulp.task "clean app.js", ->
  gulp.src "javascripts/app.js"
    .pipe clean()

gulp.task "clean", ["clean javascripts"], ->

gulp.watch "javascripts/app.js", ["concat"]
