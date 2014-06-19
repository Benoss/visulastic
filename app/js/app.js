var visulastic = angular.module('visulastic', ['ui.bootstrap', 'elasticsearch']);

visulastic.service('es', function (esFactory) {
    'use strict';

    var host = '10.50.20.208:9200';
    var esClient = esFactory({ host: host });

    var setHost = function (h){
        host = h;
        esClient = esFactory({ host: host });
    };


    var state = {}

    return {
        getClient: function(){ return esClient; },
        getHost: function (){ return host; },
        setHost: setHost
    };
});