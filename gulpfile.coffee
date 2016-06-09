_ = require 'lodash'
loader = (modules, f) ->
  bindings = {}
  _.forIn modules, (modulePath, key) ->
    bindings[key] = require modulePath
  f.apply bindings
modules =
  gulp: 'gulp'
  babelToJs: "gulp-babel"
  vulcanize: "gulp-vulcanize"
  toCoffee: 'gulp-coffee'
  path: 'path'
  jade: 'gulp-jade'
  plumber: 'gulp-plumber'
loader modules, ->
  src = "./src"
  dist = "./dist"
  file = (ext) -> "**/*.#{ext}"
  filesrc = (ext) => @path.join src, file(ext)
  babelsrc = filesrc('babel')
  htmlsrc = filesrc('html')
  coffeesrc = filesrc('coffee')
  jadesrc = filesrc('jade')
  registerTask = (obj) =>
    _.forIn obj, (task, taskName) =>
      @gulp.task(taskName, task)

  tasks =
    'babel': =>
      @gulp.src(babelsrc).pipe(@plumber()).pipe(@babelToJs()).pipe(@gulp.dest(dist))
    'coffee': =>
      @gulp.src(coffeesrc).pipe(@plumber()).pipe(@toCoffee()).pipe(@gulp.dest(dist))
    'copy': =>
      @gulp.src(htmlsrc, base: 'src').pipe(@gulp.dest(dist))
    'watch': =>
      @gulp.watch(babelsrc, ['babel'])
      @gulp.watch(htmlsrc, ['copy'])
      @gulp.watch(coffeesrc, ['coffee'])
      @gulp.watch(jadesrc, ['jade'])
    'vulcanize': =>
      @gulp.src('./dist/index.html')
      .pipe(@vulcanize(
        inlineScripts: true,
        inlineCss: true,
        stripExcludes: true
      )).pipe(@gulp.dest('./vulcanized/'))
    'jade': =>
      @gulp.src(jadesrc).pipe(@plumber()).pipe(@jade(pretty: true)).pipe(@gulp.dest(dist))

  registerTask(tasks)
  @gulp.task('default', ['coffee','jade' ,'copy', 'watch'])
