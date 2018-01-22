angular.module('KMS').factory 'ErrorsService', ->
  {
    prepareErrorsString: (errorsData)->
      errorsData.join('\n')
  }
