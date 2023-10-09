
  //var cobisMainModule = cobis.createModule("MAP", []);
  
var mapApp=angular.module('VC_PROSPECTMI_213684');
  console.log("cargando en el modulo...",mapApp);

mapApp.controller('MapsController', function($scope, $http) {
   
    var center={lat: -0.2464766, lng: -78.4879325};
    

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
    $scope.resultado={
        
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
                //center={lat:$scope.resultado.latitud,lng:$scope.resultado.longitud};
                $scope.resultado.latitud=response.data.results[0].geometry.location.lat;
                $scope.resultado.longitud=response.data.results[0].geometry.location.lng;
                //marker.setMap(null);
               // marker.position.lng=$scope.resultado.latitud;
            //    marker.position.lat= $scope.resultado.longitud;
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
            $scope.resultado.latitud=event.latLng.lat();
            $scope.resultado.longitud=event.latLng.lng();
            console.log("LATITUD:"+$scope.resultado.latitud);
            console.log("LONGITUD:"+$scope.resultado.longitud);
            
        });

                map.setCenter({lat:$scope.resultado.latitud,lng:$scope.resultado.longitud});
                console.log("geometry:" , response.data.results[0].geometry);
            }
          
            
        });
    }
    refrescar=function(marker){
            console.log("dispara el evento");
            $scope.resultado.latitud=marker.position.lat();
            $scope.resultado.longitud=marker.position.lng();
    }
	
	$scope.cerrar=function(){
		$scope.vc.closeModal(response);
	}
});


