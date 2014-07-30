module.exports =
  ['$http', '$scope', '$localStorage', '$window', '$timeout', ($http, $scope, $localStorage, $window, $timeout) ->




    $scope.$storage = $localStorage.$default({
        es_url: 'http://localhost:9200/_search'
        result_tabs: {
          "json": false,
          "yaml": true,
          "grid": false
        }
        last_query: {}
    })

    $scope.verb = 'POST'
    $scope.parse_error = ''
    #_validate/query?explain=true

    $scope.queries = {}
    $scope.queries.query = $localStorage.last_query
    $scope.gridOptions = {
      data: 'myData',
      enableColumnResize: true,
      enableColumnReordering: true,
      showColumnMenu: true
    }

    $scope.myData = ["t"]

    setQueryFromJsonString = (jsonString) ->
      $scope.queries.query = JSON.parse(jsonString)

    setQueryFromYamlString = (yamlString) ->
      $scope.queries.query = jsyaml.load(yamlString)

    $scope.getJsonQuery = ->
      $scope.queries.query_json = JSON.stringify($scope.queries.query, null, 2)

    $scope.getJsonQuery()

    $scope.getYamlQuery = ->
      $scope.queries.query_yaml = jsyaml.dump($scope.queries.query)

    $scope.getYamlQuery()

    $scope.json_to_yaml = ->
      $scope.parse_error = ''
      error = false
      try
        setQueryFromJsonString($scope.queries.query_json )
      catch e
        $scope.parse_error = e
        error = true

      if !error
        onQueryChanged()

    $scope.yaml_to_json = ->
      $scope.parse_error = ''
      error = false
      try
        setQueryFromYamlString($scope.queries.query_yaml)
      catch e
        $scope.parse_error = e
        error = true

      if !error
        onQueryChanged()

    $scope.aceLoad =  (_editor)->
      _editor.renderer.setShowGutter(true)
      _editor.getSession().setTabSize(2)
      _editor.getSession().setUseSoftTabs(true)


    onQueryChanged = ->
      console.log "onQueryChanged ->" + JSON.stringify($scope.queries.query)
      $scope.exec_query()

    $scope.transphormResultForTab = ->
      $timeout( ->
        if $scope.$storage.result_tabs.json
          $scope.queries.result = JSON.stringify(
                                      $scope.queries.result_obj,
                                      null, 2)
        if $scope.$storage.result_tabs.yaml
          $scope.queries.result = jsyaml.dump($scope.queries.result_obj)
        if $scope.$storage.result_tabs.grid
          $scope.queries.result = ''
          $scope.myData = $scope.queries.result_obj
          console.log($scope.myData)
        $scope.$apply()
      , 100)

    $scope.exec_query = ->
      try
        $http(
            method: $scope.verb
            url: $scope.$storage.es_url
            data: $scope.queries.query
          )
          .success (data, status, headers, config) ->
            $scope.queries.result_obj = data
            $scope.transphormResultForTab()
          .error (data, status, headers, config) ->
            $scope.queries.result_obj = data
            $scope.transphormResultForTab()
      catch e
        $scope.queries.result_obj = e
        $scope.transphormResultForTab()


    resizeEditors = ->
      $("div.ace_result").height($window.innerHeight - 120)
      $("div.ace_query").height(($window.innerHeight - 140)/2)
      $("div.grid_result").height($window.innerHeight - 120)

    angular.element($window).bind 'resize', ->
      resizeEditors()

    onQueryChanged()
    $timeout(resizeEditors, 100)
  ]
