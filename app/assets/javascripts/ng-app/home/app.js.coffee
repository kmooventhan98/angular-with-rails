app = angular.module("HomeAdmin",[
  "ngResource"
  "ngAnimate"
  "ngSanitize"
  "ui.router"
  "ui.select"
  "ui.bootstrap"
  "ui.highlight"
  "templates"
  "ngIdle"
  "sampleAdminCompany"
  "HomeAdminSerivce"
])


app.config ['$stateProvider','$urlRouterProvider','$locationProvider', ($stateProvider, $urlRouterProvider, $locationProvider) ->
  $stateProvider.state "adminCompany",
    url: "/company"
    templateUrl: "home/dashboard.html"
    controller: "CompanyCtr"

  $stateProvider.state "admin",
    url: "/db"
    templateUrl: "home/db.html"
    controller: "dbCtr"

    

  $urlRouterProvider.otherwise('/company');
  return

]

app.factory "authInterceptor", ['$rootScope', '$q', '$location', ($rootScope, $q, $location) -> 
  responseError: (response) -> 
    if (response.status == 401 && response.config.url != "/users/sign_in.json")
      window.location ="/"
      # console.log("Not authrorized ........")
      return false
    return $q.reject(response)
]

app.config ['$httpProvider',($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  $httpProvider.interceptors.push('authInterceptor')
]      
