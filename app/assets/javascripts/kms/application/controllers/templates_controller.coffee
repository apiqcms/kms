TemplatesController = ($scope, $state, $cookieStore, Restangular, $stateParams, Alertify, ErrorsService) ->
  $scope.editorOptions =
    lineNumbers: true
    mode:'htmlmixed'
    autoCloseTags: true
    extraKeys:
      "F11": (cm)->
        cm.setOption("fullScreen", !cm.getOption("fullScreen"))
      "Esc": (cm)->
        if cm.getOption("fullScreen") then cm.setOption("fullScreen", false)

  $scope.store = Restangular.all('templates')
  $scope.store.getList().then (templates)->
    $scope.templates = templates

  Restangular.all('users').customGET('kms_user').then (current_user) ->
    $scope.currentUser = current_user
    $scope.currentUser.admin = $scope.currentUser.role == 'admin'

  if $stateParams.id
    $scope.store.get($stateParams.id).then (template)->
      $scope.template = template
  else
    $scope.template = {}

  $scope.create = ->
    $scope.store.post($scope.template).then ->
      $state.go('templates')
    , (response)->
      Alertify.error(ErrorsService.prepareErrorsString(response.data.errors))

  $scope.update = ($event)->
    $scope.template.put().then ->
      if $event.target.attributes['data-redirect']
        $state.go('templates')
    ,(response)->
      Alertify.error(ErrorsService.prepareErrorsString(response.data.errors))

  $scope.destroy = (template)->
    if(confirm('Вы уверены?'))
      template.remove().then ->
        $scope.templates = _.without($scope.templates, template)


angular.module('KMS')
    .controller('TemplatesController', ['$scope', '$state', '$cookieStore', 'Restangular', '$stateParams', 'Alertify', 'ErrorsService', TemplatesController])
