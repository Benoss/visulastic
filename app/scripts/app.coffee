ViewOneController = require 'controllers/view1'
ViewTwoController = require 'controllers/view2'
EsRestController = require 'controllers/rest'

app = angular.module 'Visualistic', ['ngRoute', 'ui.ace', 'ui.bootstrap']

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
