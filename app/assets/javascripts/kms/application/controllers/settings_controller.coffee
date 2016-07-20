# TODO: seems the same as HelpController
SettingsController = ($scope, $state, Restangular, Alertify, ErrorsService) ->
  Restangular.all('settings').customGET().then (settings) ->
    $scope.settings = settings

  $scope.activeTab = 0

  $scope.isActiveTab = (index)->
    $scope.activeTab == index

  $scope.setActive = (index)->
    $scope.activeTab = index

  $scope.update = ->
    $scope.settings.put().then ->
      $state.go('settings')
    ,(response)->
      Alertify.error(ErrorsService.prepareErrorsString(response.data.errors))

angular.module('KMS')
    .controller('SettingsController', ['$scope', '$state', 'Restangular', 'Alertify', 'ErrorsService', SettingsController])
