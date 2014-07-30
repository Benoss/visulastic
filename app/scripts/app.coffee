ViewOneController = require 'controllers/view1'
ViewTwoController = require 'controllers/view2'
EsRestController = require 'controllers/rest'
EsTable = require 'directive/es_table'

`JSON.flatten = function(data, max_depth) {
    var result = {};
    var depth = 0;
    max_depth = max_depth || -1;
    function recurse (cur, prop) {

        if (Object(cur) !== cur) {
            result[prop] = cur;
        } else if (Array.isArray(cur)) {
             for(var i=0, l=cur.length; i<l; i++)
                 recurse(cur[i], prop + "." + i);
            if (l == 0)
                result[prop] = "[]";
        } else {
            var isEmpty = true;
            for (var p in cur) {
                isEmpty = false;
                recurse(cur[p], prop ? prop+"."+p : p);
            }
            if (isEmpty && prop)
                result[prop] = {};
        }
        depth = depth + 1
        if (max_depth > -1 && depth > max_depth) {
          return
        }
    }
    recurse(data, "");
    return result;
    }`

app = angular.module 'Visualistic', ['ngRoute', 'ui.ace', 'ui.bootstrap', 'ngStorage', 'ngGrid']

app.directive('estable', EsTable)

app.config ['$routeProvider', ($routeProvider) ->
              $routeProvider
                .when '/view1',
                  templateUrl: 'partials/view1.html'
                  controller: ViewOneController
                .when '/view2',
                  templateUrl: 'partials/view2.html'
                  controller: ViewTwoController
                .when '/about',
                  templateUrl: 'partials/rest.html'
                  controller: EsRestController
                .otherwise
                  redirectTo: '/view1'
]
