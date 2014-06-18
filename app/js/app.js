var visulastic = angular.module('visulastic', ['ui.bootstrap', 'elasticsearch']);

visulastic.service('es', function (esFactory) {
  return esFactory({
    host: 'localhost:9200'
  });
});
