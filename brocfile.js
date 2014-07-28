var mergeTrees = require('broccoli-merge-trees');
var env = require('broccoli-env').getEnv();
var select = require('broccoli-select');
var pickFiles = require('broccoli-static-compiler');
var concat = require('broccoli-concat');
var csso = require('broccoli-csso');
var uglifyJavaScript = require('broccoli-uglify-js');
var filterCoffeeScript = require('broccoli-coffee');

var htmlTree = pickFiles('app', {
  srcDir: '/',
  files: ['*.html'],
  destDir: '/'
});

// var imagesTree = pickFiles('bower_components/', {
//   srcDir: '/images',
//   files: ['*.*'],
//   destDir: '/static/images'
// });
//
// var fontTree = pickFiles('bower_components/', {
//   srcDir: '/fonts',
//   files: ['*.*'],
//   destDir: '/static/fonts'
// });

var cssConcatenated = concat('app', {
  inputFiles: [
    'css/vendor/bootstrap.css',
    'css/*.css'
  ],
  outputFile: '/static/css/app.css'
});

var jsVendorConcatenated = concat('bower_components', {
  inputFiles: [
    'angular/angular.js',
    'angular-route/angular-route.js',
    'angular-mocks/angular-mocks.js',
    'angular-bootstrap/ui-bootstrap.js',
    'elasticsearch/elasticsearch.angular.js',
    'vendor/ng-grid-2.0.11.debug.js'
  ],
  outputFile: '/static/js/vendor.js'
});



var myJsConcat = filterCoffeeScript('app/js', {});

myJsConcat = concat(myJsConcat, {
  inputFiles: ['**/*.js'],
  outputFile: '/static/js/app.js'
});

//if (env === 'development') {
//    var copyMaps = pickFiles('app', {
//        srcDir: '/',
//        files: ['**/*.map'],
//        destDir: '/static/'
//    });
//};


//Minified css and js in prod only
if (env === 'production') {
  jsVendorConcatenated = uglifyJavaScript(jsVendorConcatenated, {
    // mangle: false,
    // compress: false
  });
  myJsConcat = uglifyJavaScript(myJsConcat, {
  // mangle: false,
  // compress: false
  });
  cssConcatenated = csso(cssConcatenated, {});
}

module.exports = mergeTrees([htmlTree, cssConcatenated, jsVendorConcatenated, myJsConcat]);
