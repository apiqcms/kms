angular.module('KMS').factory 'ErrorsService', ->
  {
    prepareErrorsString: (errorsData)->
      result = []
      for field, errors of errorsData
        result.push "#{field}: #{errors.join(',')}"
      result.join('\n')
  }
