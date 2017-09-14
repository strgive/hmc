/**
 * Created by bjwsl-001 on 2017/8/2.
 */

//创建一个自定义模块，并指定依赖于ng ngRoute
var app = angular.module('hmc',
    ['ng', 'ngRoute']);

//定义一个输入防抖动的服务
app.factory('$debounce',
    ['$rootScope', '$browser', '$q', '$exceptionHandler',
        function($rootScope, $browser, $q, $exceptionHandler) {
            var deferreds = {},
                methods = {},
                uuid = 0;

            function debounce(fn, delay, invokeApply) {
                var deferred = $q.defer(),
                    promise = deferred.promise,
                    skipApply = (angular.isDefined(invokeApply) && !invokeApply),
                    timeoutId, cleanup,
                    methodId, bouncing = false;

                // check we dont have this method already registered
                angular.forEach(methods, function(value, key) {
                    if (angular.equals(methods[key].fn, fn)) {
                        bouncing = true;
                        methodId = key;
                    }
                });

                // not bouncing, then register new instance
                if (!bouncing) {
                    methodId = uuid++;
                    methods[methodId] = { fn: fn };
                } else {
                    // clear the old timeout
                    deferreds[methods[methodId].timeoutId].reject('bounced');
                    $browser.defer.cancel(methods[methodId].timeoutId);
                }

                var debounced = function() {
                    // actually executing? clean method bank
                    delete methods[methodId];

                    try {
                        deferred.resolve(fn());
                    } catch (e) {
                        deferred.reject(e);
                        $exceptionHandler(e);
                    }

                    if (!skipApply) $rootScope.$apply();
                };

                timeoutId = $browser.defer(debounced, delay);

                // track id with method
                methods[methodId].timeoutId = timeoutId;

                cleanup = function(reason) {
                    delete deferreds[promise.$$timeoutId];
                };

                promise.$$timeoutId = timeoutId;
                deferreds[timeoutId] = deferred;
                promise.then(cleanup, cleanup);

                return promise;
            }


            // similar to angular's $timeout cancel
            debounce.cancel = function(promise) {
                if (promise && promise.$$timeoutId in deferreds) {
                    deferreds[promise.$$timeoutId].reject('canceled');
                    return $browser.defer.cancel(promise.$$timeoutId);
                }
                return false;
            };

            return debounce;
        }
    ]);



//配置路由词典
app.config(function ($routeProvider) {
    $routeProvider
        .when('/hmcStart', {
            templateUrl: 'tpl/start.html'
        })
        .when('/hmcMain', {
            templateUrl: 'tpl/main.html',
            controller: 'mainCtrl'
        })
        .when('/hmcDetail/:did', {
            templateUrl: 'tpl/detail.html',
            controller: 'detailCtrl'
        })
        .when('/hmcOrder/:did', {
            templateUrl: 'tpl/order.html',
            controller: 'orderCtrl'
        })
        .when('/hmcMyOrder', {
            templateUrl: 'tpl/myOrder.html',
            controller: 'myOrderCtrl'
        })
        .otherwise({redirectTo: '/hmcStart'})
})


//创建一个控制器 给body
// 里边封装一个跳转的方法
app.controller('bodyCtrl',
    ['$scope', '$location',
        function ($scope, $location) {
            $scope.jump = function (desPath) {
                $location.path(desPath);
            }
        }
    ]
)

//给main页面 创建一个控制器
app.controller('mainCtrl',
    ['$scope', '$http','$debounce',
        function ($scope, $http,$debounce) {
            $scope.hasMore = true;
            $scope.myKw = "";

            //初始化菜品列表
            //发起网络请求，拿到数据，绑定到视图
            $http
                .get('data/dish_getbypage.php?start=0')
                .success(function (data) {
                    console.log(data);
                    $scope.dishList = data;
                })
            //定义一个加载更多的方法
            $scope.loadMore = function () {
                $http.get(
                    'data/dish_getbypage.php?start='
                    + $scope.dishList.length)
                    .success(function (data) {
                        //当返回的数据不到5条时候，
                        // 认为按钮可以隐藏，显示提示信息
                        if (data.length < 5) {
                            $scope.hasMore = false;
                        }
                        //将返回的新的数据和之前的列表拼在一起
                        $scope.dishList =
                            $scope.dishList.concat(data);
                    })
            }

            watchHandler = function (newValue, oldValue) {
                //$scope.myKw / newValue
                console.log($scope.myKw);
                //发起网络请求
                // dish_getbykw.php
                if ($scope.myKw.length > 0) {
                    $http.get(
                        'data/dish_getbykw.php?kw='
                        + $scope.myKw)
                        .success(function (data) {
                            console.log(data);
                            if (data.length > 0) {
                                $scope.dishList = data;
                            }
                        })
                }

            };

            //监听用户的输入，发起网络请求将
            // 搜索到的数据显示显示在列表
            $scope.$watch('myKw', function () {
                $debounce(watchHandler,300);
            });


        }]);

//给detail创建控制器 接收参数 发起网络请求
app.controller('detailCtrl',
    ['$scope', '$http', '$routeParams',
        function ($scope, $http, $routeParams) {
            $scope.did = $routeParams.did;
            //console.log($routeParams);
            //拿到传递来的参数 发起请求 dish_getbyid.php
            $http.get(
                'data/dish_getbyid.php?did='
                + $routeParams.did)
                .success(function (data) {
                    console.log(data);
                    $scope.dish = data[0];
                })
        }])

app.controller('orderCtrl',
    ['$scope', '$http', '$routeParams', '$httpParamSerializerJQLike',
        function ($scope, $http, $routeParams, $httpParamSerializerJQLike) {
            $scope.showForm = true;
            $scope.submitResult = "";

            $scope.order = {userDid: $routeParams.did};

            //console.log($routeParams);
            //获取用户所输入的其它信息 ngModel
            //定义一个下单的方法
            $scope.submitOrder = function () {
                //将用户所输入的数据打印
                console.log($scope.order);
                /*console.log('用户名:'+$scope.userName);
                 console.log('手机号:'+$scope.userPhone);
                 console.log('性别:'+$scope.userSex);
                 console.log('住址:'+$scope.userAddr);*/
                //发给服务器
                //准备要发送的参数
                //在ng中提供了一个服务
                /*var params = "userName="
                 +$scope.userName+
                 "&userSex="+$scope.userSex
                 +"&userPhone="+$scope.userPhone+
                 "&userAddr="+$scope.userAddr+
                 "&userDid="+$routeParams.did
                 console.log(params);*/

                var params =
                    $httpParamSerializerJQLike($scope.order);
                console.log(params);
                $http.get('data/order_add.php?' + params)
                    .success(function (data) {
                        $scope.showForm = false;
                        console.log(data);
                        result = data[0];
                        if (result.msg == 'success') {
                            $scope.submitResult = "下单成功，订单编号:" + result.oid;
                            //存储手机号 sessionStorage
                            sessionStorage.setItem
                            ('userPhone', $scope.order.userPhone)
                        }
                        else {
                            $scope.submitResult = "下单失败";
                        }
                    })
            }
        }
    ]);

app.controller('myOrderCtrl',
    ['$scope', '$http',
        function ($scope, $http) {
            //读取存储在sessionStorage的phone
            var phone = sessionStorage.getItem('userPhone');

            //根据手机号 发起网络请求
            $http
                .get('data/order_getbyphone.php?phone='+phone)
                .success(function (data) {
                    console.log(data);
                    $scope.orderList = data;
                })

        }
    ]
)