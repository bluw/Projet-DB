angular.module('webAPI', ['ngRoute'])
    .config(['$routeProvider',
    function ($routeProvider) {
        $routeProvider
        .when('/Risk', {
            templateUrl: 'partials/Medit/RiskPage.html',
            controller: 'PostController'
        })
        .when('/Exam', {
            templateUrl: 'partials/Medit/ExamPage.html',
            controller: 'PostController'
        })
        .otherwise({ redirectTo: '/Exam' });
    }])
    .controller('PostController', function ($scope, $http) {
        $scope.data = {
            fkJob : null,
            fkRisk : null,
            fkExam : null
        }

        $scope.postSubmission = function () {
            var subJSON = { "FkJob": "" + $scope.data.fkJob, "FkExam": "" + $scope.data.fkExam };

            $http.post('api/Submissions', subJSON).
                success(function (data, status, headers, config) {
                    alert("New submission submitted !");
                    console.log(data);
                }).
                error(function (data, status, header, config) {
                    alert("Something went wrong !");
                    console.log(data)
            });
        }

        $scope.postExposition = function () {
            var expoJSON = { "FkJob": "" + $scope.data.fkJob, "FkRisk": "" + $scope.data.fkRisk };

            $http.post('api/Expositions', expoJSON).
                success(function (data, status, headers, config) {
                    alert("New exposition submitted !");
                    console.log(data);
                }).
                error(function (data, status, header, config) {
                    alert("Something went wrong !");
                    console.log(data)
                });
        }

        $http.get("/api/TypeExams/?language=EN").success(function (data, status, headers, config) {
            $scope.exams = data;
        }).error(function (data, status, headers, config) {
            console.log("Something went wrong !");
        });

        $http.get("/api/Risks/?language=EN").success(function (data, status, headers, config) {
            $scope.risks = data;
        }).error(function (data, status, headers, config) {
            console.log("Something went wrong !");
        });

        $http.get("/api/SubmittedJobs/?language=EN").success(function (data, status, headers, config) {
            $scope.jobs = data;
        }).error(function (data, status, headers, config) {
            console.log("Something went wrong !");
        });
    });