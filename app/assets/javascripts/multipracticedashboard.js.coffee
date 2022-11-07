# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
app = angular.module("HealthPlotterMultiPracticeDashboard", [
  "ngResource"
  "ngAnimate"
  "ngSanitize"
  "ui.select"
  "ui.router"
  "templates"
  "toaster"
  "ngIdle"
  "cgBusy"
  "ui.bootstrap"
  "ui.highlight"
  "Devise"
  "HealthPlotterPractitionerSerivce"
  "HealthPlotterReportsSerivce"
  "HealthPlotterPractitionerSelectEmployer"
  "HealthPlotterPractitionerMenu"
  "HealthPlotterPractitionerSelectMember"
  "HealthPlotterWellnessMember"
  "PractitionerMemberDetail"

  "HealthPlotterChronicCare"
  "HealthPlotterChronicAddWorklist"
  "HealthPlotterChronicCareEnrollment"
  "HealthPlotterChronicCareCancelRequest"
  "HealthPlotterChronicCareScript"
  "HealthPlotterChronicCareTeam"
  "HealthPlotterChronicCurrentService"
  "HealthPlotterChronicPastService"
  "HealthPlotterWellnessCurrentVisit"
  "HealthPlotterWellnessPastVisit"
  "HealthPlotterChronicCareDashboard"
  "HealthPlotterChronicCareBilling"
  "HealthPlotterChronicCarePerformWorklist"
  "HealthPlotterChronicCareEnrollWorklist"
  "HealthPlotterChronicCareSpecialVisit"
  "HealthPlotterChronicCareCallManagement"

  "HealthPlotterAssesmentPerformWorklist"
  "HealthPlotterAssesmentBilling"
  "HealthPlotterAssesmentAWVSetting"

  "HealthPlotterClinicalBMIModel"
  "HealthPlotterClinicalData"
  "HealthPlotterClinicalSummary"
  "HealthPlotterClinicalEncounter"
  "HealthPlotterClinicalCareplan"
  "HealthPlotterClinicalRisk"
  "HealthPlotterClinicalPastRisk"
  "HealthPlotterClinicalPastEntry"
  "HealthPlotterClinicalBMIReport"
  "HealthPlotterClinicalA1CReport"
  "HealthPlotterClinicalBloodSugarReport"
  "HealthPlotterClinicalBloodPressureReport"
  "HealthPlotterClinicalCholesterolReport"
  "HealthPlotterClinicalTriglyceridesReport"
  "HealthPlotterLastSeenFilter"
  "HealthPlotterAgeFilter"
  "HealthPlotterArrayFilter"
  "HealthPlotterCapitalizeFilter"
  "HealthPlotterCurrencyFilter"
  "FloatDirectives"
  "totalTimeDirectives"
  "visitTimeDirectives"
  "convRateDirectives"
  "clinicalGraphDirectives"
  "clinicalGraphPulseDirectives"
  "clinicalGraphWeightDirectives"
  "clinicalGraphSugarDirectives"
  "clinicalRisksGraphDirectives"
  "pressureDirectives"
  "cholesterolDirectives"
  "IntegerDirectives"
  "lipidsGraphDirectives"
  "bmiGraphDirectives"
  "pharmaDrugDirectives"
  "icdAnalyticsDirectives"
  "angularUtils.directives.dirPagination"
  "confirmDialogDirectives"
  "EnrollconfirmDialogDirectives"
  "confirmDialogDirectivesYesNo"
  "popupDialogDirectives"
  "clinicalComparisonDirectives"
  "membershipDirectives"
  "allmembershipDirectives"
  "HealthPlotterLockScreen"
  "HealthPlotterCreatemember"

])

app.config ['$idleProvider', '$keepaliveProvider', 'paginationTemplateProvider', ($idleProvider, $keepaliveProvider, paginationTemplateProvider) -> 
  paginationTemplateProvider.setPath "directives/dirPagination.html"
]

app.controller "MultipracticedashboardCtr", ["$scope", "$resource", "$http", "$location", "$stateParams", "$state", "$Practitioner", "$filter","$modal","$window", "$timeout","toaster","$rootScope", ($scope, $resource, $http, $location, $stateParams, $state, $Practitioner, $filter,$modal, $window, $timeout, toaster) ->

  $scope.dashboard = {}
  date = new Date()
  $scope.maxDate = new Date()
  $scope.currentEmployerId = $state.params.id
  $scope.Dashboard_data = {}
  $scope.search = {}
  $scope.dashboard.provider = "All"
  $scope.dashboard.role = "All"
  $scope.dashboard.dasboard_type = "Basic"
  $scope.dashboard.dasboard_table = false
  $scope.dashboard.title = ""
  $scope.dashboard.dasboard_member_detail = false
  $scope.search.selectedEmployer = $scope.currentEmployerId
  $scope.search.selectedLocation =""
  $scope.todayDate = new Date
  $scope.ageOption = ["<1 year","1-12", "13-17", "18-29","30-39", "40-49","50-59","60-69", "70+"]
  $scope.ageLimit =""
  #$scope.dtOptions = {searching:false}
  $scope.dtInstance = {}
  $scope.downloadbutton = false
  
  
   
  
  time_zone = Intl.DateTimeFormat().resolvedOptions().timeZone


  $scope.search = {}
  $scope.report_duration = "predefined"
  $scope.search.selectDuration = 'This Month'
  $scope.currentUserId =  JSON.parse($window.sessionStorage.currentUser).id
  
  
  

  getQueryStr = () ->
    $scope.start_date = $filter('date')($scope.start_date, 'MM/dd/yyyy')
    $scope.end_date = $filter('date')($scope.end_date, 'MM/dd/yyyy')
    param = {id: $state.params.id,start_date: $scope.start_date,end_date: $scope.end_date,time_zone: time_zone}


    str = ''
    for key of param
      if str != ''
        str += '&'
      str += key + '=' + encodeURIComponent(param[key]) 

    console.log(str)  
    return str



  
  
  $scope.getDate = () ->
    console.log("i am in .....")
    getStartEndDate = () ->
      console.log("i am in startend date")
      _today = new Date
      cur_m = _today.getMonth()
      y = _today.getFullYear()
      if $scope.search.selectDuration == 'Last Month'
        firstDay = new Date(y,cur_m, 0)
        firstDay = firstDay.setDate(1)
        lastDay = new Date(y,cur_m, 0)
      else  
        firstDay = new Date(y, cur_m, 1);
        lastDay = new Date(y,cur_m+1, 0)
     
      return {start: firstDay, end: lastDay}

    $scope.dateRange = $scope.search.selectDuration + ": "
    today_date = new Date
    data = getStartEndDate()
    $scope.start_date = $filter('date')(data['start'], 'yyyy-MM-dd')
    
    $scope.end_date = $filter('date')(data['end'], 'yyyy-MM-dd') 

    
    

    console.log($scope.start_date)
    console.log($scope.end_date)

    param = {start_date: $scope.start_date,end_date: $scope.end_date}

    str = ''
    for key of param
      if str != ''
        str += '&'
      str += key + '=' + encodeURIComponent(param[key]) 

    console.log(str)
    return str

    

  
  
  $scope.getRpmReport = (result)->
    $('.showVisibility').css 'visibility', 'visible'
    $('.showVisibility1').css 'visibility', 'hidden'
    $scope.showThis = true;
    $scope.showThis1 = false;

    $scope.getDate()
    $scope.exportcsvDashboardLink = '/employers_companies/'+$scope.currentUserId+'/get_rpm_export_report.csv?'+$scope.getDate()
    getRpmReportSuccess = (result)->
     
      console.log("i am in side main")
      console.log($scope.start_date)
      $scope.rpm_data = result.response

      console.log(result.response)
      console.log($scope.currentUserId)
      console.log($scope.exportcsvDashboardLink)
      return

    getRpmReportError =(result) ->
      toaster.pop('error',"","Error in rpm report")
      return

    $Practitioner.getRpmReport.get(company_id: $stateParams.id,start_date: $scope.start_date, end_date: $scope.end_date).$promise.then getRpmReportSuccess,getRpmReportError

    return

  $scope.getUserReport = (result)->
    $('.showVisibility').css 'visibility', 'visible'
    $scope.showThis = true;
    $scope.getDate()

    getUserReportSuccess = (result)->
     
      console.log("i am in side main")
      console.log($scope.start_date)
      $scope.user_data = result.response

      console.log(result.response)
      console.log($scope.currentUserId)
      return

    getUserReportError =(result) ->
      toaster.pop('error',"","Error in rpm report")
      return

    $Practitioner.getUserReport.get(company_id: $stateParams.id,start_date: $scope.start_date, end_date: $scope.end_date).$promise.then getUserReportSuccess,getUserReportError


    return

  

  $scope.getActivelyEnrolled = (result) ->
    $('.showVisibility1').css 'visibility', 'visible'
    $('.showVisibility').css 'visibility', 'hidden'
    $scope.showThis = false;
    $scope.showThis1 = true;
    $scope.getDate()
    $scope.exportcsvDashboardLink1 = '/employers_companies/'+$scope.currentUserId+'/get_actively_enrolled_report.csv?'+$scope.getDate()

    return


  $scope.getRpmReport()

  $scope.getCompanyExecutive = ()->
    getCompanyExecutiveSuccess = (result) ->
      $scope.executives = result.response.company_executive_data
      $scope.active_user = result.response.active_user
      $scope.user_role = result.response.role
      $scope.assigned_company_id = result.response.company_id
      return

    getCompanyExecutiveError = (result) ->
      toaster.pop('error', "", "Error in fetching tag data!")
      return

    $Practitioner.getCompanyExecutive.get(company_id: $stateParams.id,company_admin_user_id: JSON.parse($window.sessionStorage.currentUser).id).$promise.then getCompanyExecutiveSuccess, getCompanyExecutiveError

    return  

  $scope.getCompanyExecutive()

  
  
  
]

