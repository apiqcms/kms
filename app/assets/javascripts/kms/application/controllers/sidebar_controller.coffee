SidebarController = ($scope, $cookieStore) ->
     #* Sidebar Toggle & Cookie Control
    mobileView = 992

    $scope.getWidth = -> return window.innerWidth

    $scope.$watch $scope.getWidth, (newValue, oldValue)->
      if newValue >= mobileView
        if angular.isDefined($cookieStore.get('toggle'))
          if $cookieStore.get('toggle') == false
            $scope.toggle = false
          else
            $scope.toggle = true
        else
          $scope.toggle = true
      else
        $scope.toggle = false

    $scope.toggleSidebar = ->
      $scope.toggle = ! $scope.toggle
      $cookieStore.put('toggle', $scope.toggle)

    window.onresize = -> $scope.$apply()
angular.module('KMS')
    .controller('SidebarController', ['$scope', '$cookieStore', SidebarController])

