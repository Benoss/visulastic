module.exports = ->
  {
    restrict: "E",
    scope: { esData: "=" },
    templateUrl: "partials/es-table.html",
    link: (scope, element, attrs) ->

      scope.onHandleClick = (row) ->


      scope.$watch "esData", (newValue,oldValue) ->
        scope.original = []
        if scope.esData.hasOwnProperty("hits")
          if scope.esData.hits.hasOwnProperty("hits")
            scope.original = scope.esData.hits.hits

        scope.table_headers = []
        scope.rows = []
        heads = []

        flat_rows = []
        for row in scope.original
          flat_row = JSON.flatten(row)
          flat_rows.push(flat_row)
          angular.extend(heads, flat_row)

        for header, val of heads
          scope.table_headers.push(header)

        for row in flat_rows
          row_vals = []
          for header, val of heads
            if row.hasOwnProperty(header)
              row_vals.push(row[header])
            else
              row_vals.push("(undef)")

          scope.rows.push(row_vals)

  }
