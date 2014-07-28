visulastic.service 'es', (esFactory, $timeout) ->
  options = {
    host:'localhost:9200'
  }
  client = null
  cluster_state = {}
  calls = 0
  connection_error = false

  setClient = ->
    client = esFactory(angular.copy(options))
  setClient()

  getClient = ->
    client

  refreshClusterState = ->
    client.cluster.state().then (data) ->
      cluster_state = data
      console.log(data)
      refreshIndicesKeys()
      return

  indicesInfos = {'indicesKeys':[]}
  getIndicesInfos = ->
    indicesInfos

  pingServer = ->
    error = false
    client.ping().then(
      (info) ->
        error = false
      (info) ->
        alert info
        error = info
    )

  refreshIndicesKeys = ->
    if not cluster_state.metadata.indices
      return indicesInfos
    indicesInfos.indicesKeys = []
    angular.forEach cluster_state.metadata.indices, (value, key) ->
      this.push(key)
    , indicesInfos.indicesKeys
    return

  getHost = ->
    options.host

  setHost = (host) ->
    options.host = host
    setClient()

  getCalls = ->
    calls

  refreshCalls = ->
    calls += 1
    #console.log(calls)
    connection_error = pingServer()
    alert connection_error
    if not connection_error?
      refreshClusterState()
      $timeout(refreshCalls, 1000)

  refreshCalls()

  {getClient, getIndicesInfos, getHost, setHost, calls, getCalls}
