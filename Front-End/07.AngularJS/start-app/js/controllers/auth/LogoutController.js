'use strict';

myApp.controller('LogoutController',
    function LogoutController($rootScope, $scope, $resource, $location, appData, auth, notifier) {
        
        $scope.logout = function () {            
            appData.logout(auth.access_token())
                .then(function () {
                    notifier.success('Logout successful!');           
                }, function (data) {
                    ModalDialog.show("The request is invalid.", data.Message);
                });
            
                // log out even if request fails, so user can login
                auth.logout();                    
                $rootScope.isLoggedIn = false;
                $location.path('/login'); 
        }
    }
);
