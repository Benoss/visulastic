

visulastic.controller('VisulasticCtrl', ['$scope','es', function($scope, es) {
  $scope.status = "Undifined";

  es.getClient().ping({
      requestTimeout: 1000,
      hello: "elasticsearch!"
    }).then(
  function(value){$scope.status = value;},
  function(value) {$scope.status = value.message;}
);



    $scope.cluster = "Undif";

    es.getClient().cluster.state().then(function(value){$scope.cluster = value;});

  }]);

    visulastic.controller('HeaderCtrl', ['$scope','es', function($scope, es) {
        $scope.host = es.getHost();

        $scope.setServer = function(h){
            es.setHost(h);
            console.log(h);
        }


}]);
