# ----------------------------------------------
# Init gulp
# ----------------------------------------------

CONFIG = require( "./gulp-config.json" )
PATHS = require( "./gulp-paths.json" )
gulp = require( "gulp" )
$ = require( "gulp-load-plugins" )()

# ----------------------------------------------
# Load misc plugins
# ----------------------------------------------

$.path = require("path")
$._ = require("lodash")
$.runSequence = require("run-sequence")
$.eventStream = require("event-stream")
$.del = require('del')
$.vinylPaths = require('vinyl-paths')

# ----------------------------------------------
# Clean /public dir
# ----------------------------------------------
#
# - Removes all resources from /public
# - Included in "gulp [default]"

cleanPublic = ->
  gulp.src( PATHS.PUBLIC.SRC, read: false )
    .pipe( $.vinylPaths($.del) )

gulp.task( "cleanPublic", cleanPublic )

# ----------------------------------------------
# Remove previous versioned files
# ----------------------------------------------

cleanRevs = ->
  gulp.src( PATHS.REV.SRC, read: false )
    .pipe( $.revOutdated(1) )
    .pipe( $.vinylPaths($.del) )

gulp.task( "cleanRevs", cleanRevs )

# ----------------------------------------------
# Copy/rev fonts to /public/assets/fonts
# ----------------------------------------------

gulp.task( "fonts", ->
  gulp.src( PATHS.FONTS.SRC )
    .pipe( $.changed( PATHS.FONTS.DEST ) )
    .pipe( $.flatten() )
    .pipe( $.rev() )
    .pipe( gulp.dest( PATHS.FONTS.DEST ) )
    .pipe( $.rev.manifest() )
    .pipe( gulp.dest( "./rev/fonts/" ) )
)

# ----------------------------------------------
# Copy/rev images to /public/assets/images
# ----------------------------------------------

gulp.task( "images", ->
  gulp.src( PATHS.IMAGES.SRC )
    .pipe( $.changed( PATHS.IMAGES.DEST ) )
    .pipe( $.flatten() )
    .pipe( $.rev() )
    .pipe( gulp.dest( PATHS.IMAGES.DEST ) )
    .pipe( $.rev.manifest() )
    .pipe( gulp.dest( "./rev/images/" ) )
)

# ----------------------------------------------
# Copy/rev templates to /public/templates
# ----------------------------------------------

# gulp.task( "templates", ->
#   gulp.src( PATHS.TEMPLATES.SRC, { base: './' } )
#     .pipe( $.changed( PATHS.TEMPLATES.DEST ) )
#     .pipe( $.flatten() )
#     .pipe( $.rev() )
#     .pipe( gulp.dest( PATHS.TEMPLATES.DEST ) )
#     .pipe( $.rev.manifest() )
#     .pipe( gulp.dest( "./rev/templates/" ) )
# )

# ----------------------------------------------
# Copy locales to /config/locales
# ----------------------------------------------
#
# - Parses locales for each language set in
#   gulp-config.json.LOCALES.LANG

locales = ->
  for locale in CONFIG.LOCALES
    fileName = "#{locale}.yml"
    localeSrc = $._.map( PATHS.LOCALES.SRC, (url) ->
      url.replace(/\*\.yml/g, fileName)
    )
    gulp.src( localeSrc )
      .pipe( gulp.dest( PATHS.LOCALES.DEST ) )

gulp.task( "locales", locales )

# ----------------------------------------------
# Compile/concat SASS to /public/assets/css
# ----------------------------------------------

# Init vendor css stream
vendorCss = ->
  gulp.src( PATHS.CSS.VENDOR.SRC )

# Init app css stream
appCss = ->
  gulp.src( PATHS.CSS.APP.SRC )
    .pipe( $.sass() )

# Join vendor/app css streams
css = ->
  $.eventStream.merge( vendorCss(), appCss() )
    .pipe( $.changed( PATHS.CSS.DEST ) )
    .pipe( $.concat( PATHS.CSS.FILE_NAME ) )
    .pipe( $.minifyCss() )
    .pipe( $.rev() )
    .pipe( gulp.dest( PATHS.CSS.DEST ) )
    .pipe( $.rev.manifest() )
    .pipe( gulp.dest( "./rev/css/" ) )

gulp.task( "css", css )

# ----------------------------------------------
# Process app CoffeeScript
# ----------------------------------------------

appTemplates = ->
  gulp.src( PATHS.TEMPLATES.SRC )
    .pipe( $.changed( PATHS.TEMPLATES.DEST ) )
    .pipe( $.flatten() )
    .pipe( $.angularTemplatecache() )

appCoffee = ->
  gulp.src( PATHS.JS.APP.SRC )
    .pipe( $.changed( PATHS.JS.DEST ) )
    .pipe( $.coffee() )
    .pipe( $.ngAnnotate() )
    .pipe( $.uglify() )
    #.pipe( $.sourcemaps.init() )
    #.pipe( $.sourcemaps.write() )

appJs = ->
  $.eventStream.merge( appTemplates(), appCoffee() )
    .pipe( $.concat( PATHS.JS.APP.FILE_NAME ) )
    .pipe( $.rev() )
    .pipe( gulp.dest( PATHS.JS.DEST ) )
    .pipe( $.rev.manifest() )
    .pipe( gulp.dest( "./rev/appjs/" ) )

gulp.task( "appJs", appJs )

# appJs = ->
#   gulp.src( PATHS.JS.APP.SRC )
#     .pipe( $.changed( PATHS.JS.DEST ) )
#     .pipe( $.coffee() )
#     .pipe( $.concat( PATHS.JS.APP.FILE_NAME ) )
#     .pipe( $.ngAnnotate() )
#     .pipe( $.uglify() )
#     .pipe( $.sourcemaps.init() )
#     .pipe( $.rev() )
#     .pipe( $.sourcemaps.write() )
#     .pipe( gulp.dest( PATHS.JS.DEST ) )
#     .pipe( $.rev.manifest() )
#     .pipe( gulp.dest( "./rev/appjs/" ) )
# 
# gulp.task( "appJs", appJs )

# ----------------------------------------------
# Process vendor javascript
# ----------------------------------------------

vendorJs = ->
  gulp.src( PATHS.JS.VENDOR.SRC )
    .pipe( $.changed( PATHS.JS.DEST ) )
    .pipe( $.concat( PATHS.JS.VENDOR.FILE_NAME ) )
    .pipe( $.ngAnnotate() )
    .pipe( $.sourcemaps.init() )
    .pipe( $.rev() )
    .pipe( $.sourcemaps.write() )
    .pipe( gulp.dest( PATHS.JS.DEST ) )
    .pipe( $.rev.manifest() )
    .pipe( gulp.dest( "./rev/vendorjs/" ) )

gulp.task( "vendorJs", vendorJs )

# ----------------------------------------------
# Index changes
# ----------------------------------------------

index = ->
  gulp.src( PATHS.INDEX.SRC )

gulp.task( "index", index )

# ----------------------------------------------
# Rev resource URLS
# ----------------------------------------------

# Rev JS/CSS URLs in application.html.erb
revIndex = ->
  gulp.src( ["./rev/{css,appjs,vendorjs}/rev-manifest.json","./app/views/layouts/application.html.erb"] )
    .pipe( $.revCollector( replaceReved: true ) )
    .pipe( gulp.dest( "./app/views/layouts/" ) )
gulp.task( "revIndex", revIndex )

# Rev image/font URLs in CSS
revCss = ->
  gulp.src( ["./rev/{images,fonts}/rev-manifest.json", "./public/css/*.css"] )
    .pipe( $.revCollector( replaceReved: true ) )
    .pipe( gulp.dest( PATHS.CSS.DEST ) )
gulp.task( "revCss", revCss )

# Rev template URLs in JS
revJs = ->
  gulp.src( ["./rev/templates/rev-manifest.json", "./public/javascripts/app-*.js"] )
    .pipe( $.revCollector( replaceReved: true ) )
    .pipe( gulp.dest( PATHS.JS.DEST ) )
gulp.task( "revJs", revJs )

# Rev template URLs in html
# revTemplates = ->
#   gulp.src( ["./rev/templates/rev-manifest.json", "./public/templates/*.html"] )
#     .pipe( $.revCollector( replaceReved: true ) )
#     .pipe( gulp.dest( PATHS.TEMPLATES.DEST ) )
# gulp.task( "revTemplates", revTemplates )

# ----------------------------------------------
# Trigger livereload
# ----------------------------------------------

liveReload = ->
  $.livereload.changed()

gulp.task( "liveReload", liveReload )

# ----------------------------------------------
# Clean & Rebuild
# ----------------------------------------------

defaultTask = ->
  $.runSequence(
    "cleanPublic",
    ["locales", "images", "fonts", "vendorJs", "appJs", "css"],
    #["locales", "images", "fonts", "vendorJs", "appJs", "css", "templates"],
    "cleanRevs",
    ["revIndex", "revCss", "revJs"]
    #["revIndex", "revCss", "revJs", "revTemplates"]
  )

gulp.task( "default", defaultTask )

# ----------------------------------------------
# Watch
# ----------------------------------------------

watchTask = ->
  $.livereload.listen()
  gulp.watch( PATHS.INDEX.SRC, -> $.runSequence( "index", "liveReload") )
  gulp.watch( PATHS.LOCALES.SRC, -> $.runSequence( "locales", "liveReload") )
  gulp.watch( PATHS.IMAGES.SRC, -> $.runSequence( "images", "cleanRevs", "revCss", "liveReload") )
  gulp.watch( PATHS.CSS.APP.SRC, -> $.runSequence( "css", "cleanRevs", ["revIndex", "revCss"], "liveReload") )
  gulp.watch( PATHS.JS.APP.SRC, -> $.runSequence( "appJs", "cleanRevs", ["revIndex", "revJs"], "liveReload") )
  gulp.watch( PATHS.JS.VENDOR.SRC, -> $.runSequence( "vendorJs", "cleanRevs", "revIndex", "liveReload") )
  gulp.watch( PATHS.TEMPLATES.SRC, -> $.runSequence( "appJs", "cleanRevs", ["revIndex", "revJs"], "liveReload") )
#   gulp.watch( PATHS.TEMPLATES.SRC, -> $.runSequence( "templates", "cleanRevs", ["revJs", "revTemplates"], "liveReload") )

gulp.task( "watch", watchTask )
