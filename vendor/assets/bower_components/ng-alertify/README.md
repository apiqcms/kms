# ng-alertify

> AngularJS wrapper around [alertify.js](http://fabien-d.github.io/alertify.js/)

[![NPM][ng-alertify-icon] ][ng-alertify-url]

[![Build status][ng-alertify-ci-image] ][ng-alertify-ci-url]
[![dependencies][ng-alertify-dependencies-image] ][ng-alertify-dependencies-url]
[![devdependencies][ng-alertify-devdependencies-image] ][ng-alertify-devdependencies-url]

[ng-alertify-icon]: https://nodei.co/npm/ng-alertify.png?downloads=true
[ng-alertify-url]: https://npmjs.org/package/ng-alertify
[ng-alertify-ci-image]: https://travis-ci.org/kensho/ng-alertify.png?branch=master
[ng-alertify-ci-url]: https://travis-ci.org/kensho/ng-alertify
[ng-alertify-dependencies-image]: https://david-dm.org/kensho/ng-alertify.png
[ng-alertify-dependencies-url]: https://david-dm.org/kensho/ng-alertify
[ng-alertify-devdependencies-image]: https://david-dm.org/kensho/ng-alertify/dev-status.png
[ng-alertify-devdependencies-url]: https://david-dm.org/kensho/ng-alertify#info=devDependencies

[Demo](http://kensho.github.io/ng-alertify/)

## Install and use

`npm install ng-alertify --save` or `bower install ng-alertify`.
Include the `ng-alertify.js` script in your page and use `Alertify` module and dependency

```js
angular.module('MyApp', ['Alertify'])
  .run(function (Alertify) {
    Alertify.success('Hello world!');
    Alertify.log('Neutral message');
    Alertify.error('Something went wrong', 'multiple params, including', new Error('are ok'));
    // displays "Something went wrong multiple params, including are ok"
    Alertify.confirm('Are you sure?').then(
        function onOk() {...}, 
        function onCancel() { ... }
    );
    Alertify.prompt('Your age', 21).then(
        function onOk(answer) {...}, 
        function onCancel() { ... }
    );
  });
```

Tested with [alertify.js](http://fabien-d.github.io/alertify.js/) v0.3.11

Works well with [confirm-click](https://github.com/bahmutov/confirm-click).

## License

Author: Kensho &copy; 2015

* [@kensho](https://twitter.com/kensho)
* [kensho.com](http://kensho.com)

Support: if you find any problems with this library,
[open issue](https://github.com/kensho/ng-alertify/issues) on Github


The MIT License (MIT)

Copyright (c) 2015 Kensho

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



