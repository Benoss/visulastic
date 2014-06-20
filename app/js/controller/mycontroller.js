

visulastic.controller('VisulasticCtrl', ['$scope','es', function($scope, es) {
  $scope.status = "Undifined";
  $scope.searchIndex = "";
  es.getClient().ping({
      requestTimeout: 1000,
      hello: "elasticsearch!"
    }).then(
  function(value){$scope.status = value;},
  function(value) {$scope.status = value.message;}
);

    $scope.indexes = es.getIndexes();

    $scope.cluster = "Undif";



  }]);

    visulastic.controller('HeaderCtrl', ['$scope','es', function($scope, es) {
        $scope.host = es.getHost();

        $scope.setServer = function(h){
            es.setHost(h);
            console.log(h);
        }




}]);
