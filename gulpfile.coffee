gulp = require "gulp"
coffee = require "gulp-coffee"
uglify = require "gulp-uglify"
clean = require "gulp-clean"
concat = require "gulp-concat"
jade = require "gulp-jade"
connect = require "gulp-connect"
watch = require "gulp-watch"
styl = require "gulp-stylus"
deploy = require "gulp-gh-pages"

gulp.task "default", ["coffee", "concat", "jade", "styl"], ->

gulp.task "coffee", ->
  gulp.src "src/*.coffee"
    .pipe watch()
    .pipe coffee()
    .pipe gulp.dest "tmp/"
    .pipe connect.reload()

gulp.task "concat", ->
  gulp.src ["bower_components/jquery/dist/jquery.js", "bower_components/moment/moment.js", "tmp/app.js"]
    .pipe concat "app.min.js"
    .pipe uglify()
    .pipe gulp.dest "build/"

gulp.task "jade", ->
  gulp.src "src/*.jade"
    .pipe watch()
    .pipe jade()
    .pipe gulp.dest "build/"
    .pipe connect.reload()

gulp.task "styl", ->
  gulp.src "src/*.styl"
    .pipe watch()
    .pipe styl()
    .pipe gulp.dest "build/"
    .pipe connect.reload()

gulp.task "connect", connect.server(
  root: "#{__dirname}/build/"
  port: 3000
  livereload: true
  open:
    browser: "chrome"
)

gulp.task "clean", ->
  gulp.src ["tmp/", "build/"]
    .pipe clean()

gulp.task "deploy", ["default"], ->
  gulp.src ["build/*"]
    .pipe deploy()

gulp.watch "tmp/app.js", ["concat"]
