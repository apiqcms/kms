SnippetsController = ($scope, $state, Restangular, $stateParams, Alertify, ErrorsService) ->
  $scope.editorOptions =
    lineNumbers: true
    mode:'htmlmixed'
    autoCloseTags: true
    extraKeys:
      "F11": (cm)->
        cm.setOption("fullScreen", !cm.getOption("fullScreen"))
      "Esc": (cm)->
        if cm.getOption("fullScreen") then cm.setOption("fullScreen", false)

  $scope.store = Restangular.all('snippets')
  $scope.store.getList().then (snippets)->
    $scope.snippets = snippets

  Restangular.all('users').customGET('kms_user').then (current_user) ->
    $scope.currentUser = current_user
    $scope.currentUser.admin = $scope.currentUser.role == 'admin'

  if $stateParams.id
    $scope.store.get($stateParams.id).then (snippet)->
      $scope.snippet = snippet
  else
    $scope.snippet = {}

  $scope.create = ->
    $scope.store.post($scope.snippet).then ->
      $state.go('snippets')
    , (response)->
      Alertify.error(ErrorsService.prepareErrorsString(response.data.errors))

  $scope.update = ->
    $scope.snippet.put().then ->
      $state.go('snippets')
    ,(response)->
      Alertify.error(ErrorsService.prepareErrorsString(response.data.errors))

  $scope.destroy = (snippet)->
    if(confirm('Вы уверены?'))
      snippet.remove().then ->
        $scope.snippets = _.without($scope.snippets, snippet)

angular.module('KMS')
    .controller('SnippetsController', ['$scope', '$state', 'Restangular', '$stateParams', 'Alertify', 'ErrorsService', SnippetsController])
