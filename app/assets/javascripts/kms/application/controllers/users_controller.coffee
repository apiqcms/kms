UsersController = ($scope, $state, $cookieStore, Restangular, $stateParams, Alertify, ErrorsService) ->
  $scope.store = Restangular.all('users')
  $scope.store.getList().then (users)->
    $scope.users = users

  if $stateParams.id
    $scope.store.get($stateParams.id).then (user)->
      $scope.user = user
  else
    $scope.user = {role: 'content_manager'}

  $scope.create = ->
    $scope.store.customPOST($scope.user, 'from_kms').then ->
      $state.go('users')
    , (response)->
      Alertify.error(ErrorsService.prepareErrorsString(response.data.errors))

  $scope.update = ->
    $scope.user.put().then ->
      $state.go('users')
    , (response) ->
      Alertify.error(ErrorsService.prepareErrorsString(response.data.errors))

  $scope.destroy = (user)->
    if(confirm('<%= I18n.t(:are_you_sure) %>'))
      user.remove().then ->
        $scope.users = _.without($scope.users, user)


angular.module('KMS')
    .controller('UsersController', ['$scope', '$state', '$cookieStore', 'Restangular', '$stateParams', 'Alertify', 'ErrorsService', UsersController])
