AssetsController = ($scope, $state, $cookieStore, $cookies, Restangular, $stateParams, Alertify, ErrorsService) ->

  $scope.editorOptions = (asset)->
    lineNumbers: true
    mode: $scope.getMode(asset)
    extraKeys:
      "F11": (cm)->
        cm.setOption("fullScreen", !cm.getOption("fullScreen"))
      "Esc": (cm)->
        if cm.getOption("fullScreen") then cm.setOption("fullScreen", false)


  $scope.store = Restangular.all('assets')
  $scope.store.getList().then (assets)->
    $scope.assets = _.groupBy(assets, 'content_type')

  if $stateParams.id
    $scope.store.get($stateParams.id).then (asset)->
      $scope.asset = asset
      if /javascript/.test($scope.asset.content_type) or /css/.test($scope.asset.content_type) or /text\//.test($scope.asset.content_type)
        $scope.asset.performing_plain_text = true
  else
    {}

  $scope.create = ->
    $scope.store.post($scope.asset).then ->
      $state.go('assets')
    ,(response)->
      Alertify.error(ErrorsService.prepareErrorsString(response.data.errors))

  $scope.update = ($event)->
    $scope.asset.put().then ->
      if $event.target.attributes['data-redirect']
        $state.go('assets')
    ,(response)->
      Alertify.error(ErrorsService.prepareErrorsString(response.data.errors))

  $scope.destroy = (asset)->
    if(confirm('Вы уверены?'))
      asset.remove().then ->
        for content_type, values of $scope.assets
          $scope.assets[content_type] = _.without($scope.assets[content_type], asset)

  $scope.setHeaders = ->
    'X-XSRF-TOKEN': $cookies["XSRF-TOKEN"] # call func for getting a cookie

  $scope.getMode = (asset)->
    if /javascript/.test(asset.content_type)
      "javascript"
    else if /css/.test(asset.content_type)
      "css"
    else
      "htmlmixed"

  $scope.isImageType = (file)->
    ['jpg', 'jpeg', 'gif','png'].indexOf(file.getType()) >= 0


angular.module('KMS')
    .controller('AssetsController', ['$scope', '$state', '$cookieStore', '$cookies', 'Restangular', '$stateParams', 'Alertify', 'ErrorsService', AssetsController])
