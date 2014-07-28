module.exports =
  ['$http', '$scope', ($http, $scope) ->
    $scope.es_url = 'http://localhost:9200/_search'
    $scope.verb = 'POST'
    $scope.query_yaml = 'greeting: hello\nname: world\ntest:\n  kk: hello'
    $scope.query_json = JSON.stringify(jsyaml.load($scope.query_yaml), null, 2)
    $scope.parse_error = ''
    $scope.result = ''
    #_validate/query?explain=true

    $scope.json_to_yaml = ->
      $scope.parse_error = ''
      try
          $scope.query_yaml = jsyaml.dump(JSON.parse($scope.query_json))
      catch e
         $scope.parse_error = e
    $scope.yaml_to_json = ->
      $scope.parse_error = ''
      try
        $scope.query_json = JSON.stringify(jsyaml.load($scope.query_yaml), null, 2)
      catch e
        $scope.parse_error = e

    $scope.aceJson =  (_editor)->
      _editor.renderer.setShowGutter(true)
      _editor.getSession().setTabSize(2)
      _editor.getSession().setUseSoftTabs(true)

    $scope.aceYaml =  (_editor)->
      _editor.renderer.setShowGutter(true)
      _editor.getSession().setTabSize(2)
      _editor.getSession().setUseSoftTabs(true)

    $scope.exec_query = ->
      es_obj = JSON.parse($scope.query_json)
      try
        $http(
            method: $scope.verb
            url: $scope.es_url
            data: es_obj
          )
          .success (data, status, headers, config) ->
            $scope.result = JSON.stringify(data, null, 2)
          .error (data, status, headers, config) ->
            $scope.result = data.error.replace(/(;)/g, "\n")
      catch e
        $scope.result = e

    $scope.exec_query()
  ]
