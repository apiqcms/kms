HelpController = ($scope) ->
  $scope.activeTab = 0

  $scope.isActiveTab = (index)->
    $scope.activeTab == index

  $scope.setActive = (index)->
    $scope.activeTab = index


angular.module('KMS')
    .controller('HelpController', ['$scope', HelpController])
