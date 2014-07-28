
visulastic.controller 'VisulasticCtrl', ($scope, es) ->
  $scope.status = "Undifined"
  $scope.searchIndex = ""

  es.getClient().ping({
    requestTimeout: 1000,
    hello: "elasticsearch!"
    }).then(
    (value) ->
      $scope.status = value
    (value) ->
      $scope.status = value.message
    )

  $scope.getIndicesInfos = es.getIndicesInfos
  $scope.cluster = es.getCalls


visulastic.controller 'HeaderCtrl', ($scope, es) ->
  $scope.host = es.getHost()

  $scope.setServer = (h) ->
    es.setHost(h)
    console.log(h)
