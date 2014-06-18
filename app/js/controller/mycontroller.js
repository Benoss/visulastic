

visulastic.controller('VisulasticCtrl', ['$scope','es', function($scope, es) {
  $scope.status = "Undifined";

  es.ping({
      requestTimeout: 1000,
      hello: "elasticsearch!"
    }).then(
  function(value){$scope.status = value;},
  function(value) {$scope.status = value.message;}
);



    $scope.cluster = "Undif";

    es.cluster.state().then(function(value){$scope.cluster = value;});

  }]);
