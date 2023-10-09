(function () {
    'use strict';
    var mapApp = cobis.createModule("MapModule", ["oc.lazyLoad", cobis.modules.FPM, 'ui.bootstrap', "designerModule", "ngResource"]);

    mapApp.config(function ($controllerProvider, $compileProvider, $routeProvider, $filterProvider) {
        app.controllerProvider = $controllerProvider;
        app.compileProvider = $compileProvider;
        app.routeProvider = $routeProvider;
        app.filterProvider = $filterProvider;
    });
    
      mapApp.controller("MapsController", ['$scope','$http', '$filter', '$modal', '$routeParams', "designer", "dsgnrCommons",
     function ($scope,$http, $filter, $modal, $routeParams, designer, dsgnrCommons) {

        $scope.vc = designer.initCustomViewContainer('MapView');

    $scope.closeModal=function(){
        $scope.vc.closeModal($scope.result);
    }
   $scope.initData=function(){
        var api = new dsgnrCommons.API($scope.vc),
        nav = api.navigation,
        searchData = nav.getCustomDialogParameters().searchData;
        var lat = searchData.latitude;
        var lon = searchData.longitude;

        //var searchCriteria=searchData.reference+","+searchData.neighborhood+","+searchData.street+","+searchData.city+","+searchData.province+","+searchData.country;
       // var searchCriteria=searchData.reference+","+searchData.city+","+searchData.province+","+searchData.country;
	   var searchCriteria=searchData.reference+","+searchData.city+","+searchData.country;
	   var key = 'AIzaSyBRdzwaUFdmAGF8ExiNkTG3upBjWqIyP0c';
        
		if(lat == 0 && lon ==0){
           var url='https://maps.googleapis.com/maps/api/geocode/json?address='+searchCriteria+'&key=' + key;
           console.log("",$scope.vc);
           //var searchCriteria=$scope.loc.direccion+","+$scope.loc.ciudad;
           // url+=searchCriteria
           console.log("Criterios de busqueda",searchCriteria);
           //TODO: cuando se implemente la modificacion, ahi se colocaria latitud y longitud que trae de la base
           $scope.result={}
           $scope.showMap(url);
        }
        else{
           $scope.result={};
           $scope.viewCoordinates(lat, lon);
        }
        
   }
   $scope.viewCoordinates=function(lat, lon){
	   
	  $scope.result.latitude=lat;
	  $scope.result.longitude=lon;
      var marker;
      var point={lat:lat,lng:lon}
    
      if(marker!=undefined){
         marker.setMap(null);
      }
      var map = new google.maps.Map(document.getElementById('map'), {
         zoom: 16,
         center: point
      });
      marker = new google.maps.Marker({
         position: point,
         map: map,
         title: 'Punto encontrado!',
         draggable:true
      });
      google.maps.event.addListener(marker,'dragend',function(event){
         $scope.result.latitude=event.latLng.lat();
         $scope.result.longitude=event.latLng.lng();
         console.log("LATITUD:"+$scope.result.latitude);
         console.log("LONGITUD:"+$scope.result.longitude);
      });
   }
   
   $scope.showMap=function(url){
        $http.get(url,{headers:{'If-Modified-Since':undefined,'Access-Control-Request-Headers':undefined}}).
        then(function(response) {
            console.log("respuesta:" , response.data);
            
            if(response.data.status=="ZERO_RESULTS"){
                alert("posicion no encontrada");
            }else if(response.data.status=="OK"){
                var marker;
                var point={lat:response.data.results[0].geometry.location.lat,lng:response.data.results[0].geometry.location.lng}
                //center={lat:$scope.result.latitud,lng:$scope.result.longitud};
                $scope.result.latitude=response.data.results[0].geometry.location.lat;
                $scope.result.longitude=response.data.results[0].geometry.location.lng;
                //marker.setMap(null);
               // marker.position.lng=$scope.result.latitud;
            //    marker.position.lat= $scope.result.longitud;
               // map.setCenter(point);
                if(marker!=undefined){
                    marker.setMap(null);
                }
                
                var map = new google.maps.Map(document.getElementById('map'), {
                    zoom: 16,
                    center: point
                });
                marker = new google.maps.Marker({
                    position: point,
                    map: map,
                    title: 'Punto encontrado!',
                    draggable:true
                });
                google.maps.event.addListener(marker,'dragend',function(event) 
        {
            //console.log("dragend");
           $scope.result.latitude=event.latLng.lat();
           $scope.result.longitude=event.latLng.lng();
            console.log("LATITUD:"+$scope.result.latitude);
            console.log("LONGITUD:"+$scope.result.longitude);
            
        });

              //  map.setCenter({lat:$scope.result.latitud,lng:$scope.result.longitud});
                //console.log("geometry:" , response.data.results[0].geometry);
            }
          
            
        });
    }


   
   // $scope.vc = designer.initCustomViewContainer('VC_PROSPECTMI_213684', $scope.customEvents);
    
  //  $scope.$watch('$viewContentLoaded', function(){
        
 //});
    /*var center={lat: -0.2464766, lng: -78.4879325};
    

  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 16,
    center: center
  });

  var marker = new google.maps.Marker({
    position: center,
    map: map,
    title: 'Hello World!'
  });

    $scope.loc={
        pais:"Ecuador",
        provincia:"Pichincha",
        ciudad:"Quito",
        direccion:"xx"
    }
    $scope.result={
        
    }
    
    $scope.consultar=function(){
        
        var url='https://maps.googleapis.com/maps/api/geocode/json?address=';
        url+=$scope.loc.direccion+","+$scope.loc.ciudad;
    //$http.get('https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=AIzaSyBeK8BWXsKDTMtwV_bC2FI4GADQklc-nuA').
        console.log("url consultada:",url);
        $http.get(url).
        then(function(response) {
            console.log("respuesta:" , response.data);
            if(response.data.status=="ZERO_RESULTS"){
                alert("posicion no encontrada");
                
            }else if(response.data.status=="OK"){
                 map.setZoom(16);
                var point={lat:response.data.results[0].geometry.location.lat,lng:response.data.results[0].geometry.location.lng}
                //center={lat:$scope.result.latitud,lng:$scope.result.longitud};
                $scope.result.latitud=response.data.results[0].geometry.location.lat;
                $scope.result.longitud=response.data.results[0].geometry.location.lng;
                //marker.setMap(null);
               // marker.position.lng=$scope.result.latitud;
            //    marker.position.lat= $scope.result.longitud;
                map.setCenter(point);
                marker.setMap(null);
                marker = new google.maps.Marker({
                    position: point,
                    map: map,
                    title: 'Punto encontrado!',
                    draggable:true
                });
                google.maps.event.addListener(marker,'dragend',function(event) 
        {
            console.log("dragend");
            $scope.result.latitud=event.latLng.lat();
            $scope.result.longitud=event.latLng.lng();
            console.log("LATITUD:"+$scope.result.latitud);
            console.log("LONGITUD:"+$scope.result.longitud);
            
        });

                map.setCenter({lat:$scope.result.latitud,lng:$scope.result.longitud});
                console.log("geometry:" , response.data.results[0].geometry);
            }
          
            
        });
    }
    refrescar=function(marker){
            console.log("dispara el evento");
            $scope.result.latitud=marker.position.lat();
            $scope.result.longitud=marker.position.lng();
    }
    
    $scope.cerrar=function(){
        $scope.vc.closeModal(response);
    }/*/
}]);

}());

