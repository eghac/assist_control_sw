<!DOCTYPE html>
<html lang="en">
<!--metadatos-->
<head>
    <meta charset="UTF-8">
    <TItle>documento</TItle>
    <meta name="description" content="es una pagina de software" />
    <!--Para llamar mis arhivos css-->
   
    <script src='https://api.mapbox.com/mapbox-gl-js/v0.54.0/mapbox-gl.js'></script>
    <link href='https://api.mapbox.com/mapbox-gl-js/v0.54.0/mapbox-gl.css' rel='stylesheet' />

<style>
#map{
    height: 500px;
    width: 500px;
    }


</style>
</head>


<body>

        <style>
                .coordinates {
                background: rgba(0,0,0,0.5);
                color: #fff;
                position: absolute;
                bottom: 40px;
                left: 10px;
                padding:5px 10px;
                margin: 0;
                font-size: 11px;
                line-height: 18px;
                border-radius: 3px;
                display: none;
                }

                body {
  background: #404040;
  color: #f8f8f8;
  font: 500 20px/26px 'Helvetica Neue', Helvetica, Arial, Sans-serif;
  margin: 0;
  padding: 0;
  -webkit-font-smoothing: antialiased;
}
.sidebar {
  width: 33.3333%;
}

.pad2 {
  padding: 20px;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
}
                </style>
        
        
        <div class='sidebar pad2'>Listing</div>
        <div id='map' class='map pad2' style='width: 400px; height: 300px;'>map</div>
        <pre id='coordinates' class='coordinates'></pre>

        <form id="demo-form2"  action="{{route('personal.store')}}" method="POST" enctype="multipart/form-data"  data-parsley-validate class="form-horizontal form-label-left">
            <input type="hidden" name="_token" id="csrf-token" value="{{ Session::token() }}" />
          <div class="form-group">
            <label id="" class="control-label col-md-3 col-sm-3 col-xs-12" for="nombre">x1 <span class="required">*</span>
            </label>
            <div class="col-md-6 col-sm-6 col-xs-12">
              <input type="text" id="x1" name="nombre" required="required" value="-63.188496" class="form-control col-md-7 col-xs-12">
            </div>
          </div>

          <div class="form-group">
            <label id="" class="control-label col-md-3 col-sm-3 col-xs-12" for="nombre">x2 <span class="required">*</span>
            </label>
            <div class="col-md-6 col-sm-6 col-xs-12">
              <input type="text" id="x2" name="nombre" required="required" value="-17.790127" class="form-control col-md-7 col-xs-12">
            </div>
          </div>


          <div class="form-group">
            <label  class="control-label col-md-3 col-sm-3 col-xs-12" for="cedula">Latitud <span class="required">*</span>
            </label>
            <div class="col-md-6 col-sm-6 col-xs-12">
              <input type="text" id="y" name="y" required="required" class="form-control col-md-7 col-xs-12">
            </div>
          </div>
          <div class="form-group">
            <label  class="control-label col-md-3 col-sm-3 col-xs-12" for="huella">Longitud <span class="required">*</span>
            </label>
            <div class="col-md-6 col-sm-6 col-xs-12">
              <input type="text" id="x" name="x" required="required" class="form-control col-md-7 col-xs-12">
            </div>
          </div>

          <div class="ln_solid"></div>
          <div class="form-group">
            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
             
              
              <button class="btn btn-primary" type="reset">Reset</button>
              <button type="submit" class="btn btn-success">Registrar</button>
            </div>
          </div>

        </form>


    </section>
    <!--PIE DE PAGINA -->
    <footer>
        <p>Luis Velez - 72121241</p>

    </footer>

</body>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://unpkg.com/leaflet@1.0.3/dist/leaflet.js"></script>
<script>
 


  var x1=document.getElementById('x1').value;
     var x2=document.getElementById('x2').value;
    mapboxgl.accessToken = 'pk.eyJ1IjoibHVpczM0NjE1ODAiLCJhIjoiY2p2czNmOGhxMDQwdzQ5bWl6OGw4bDFzaiJ9.a59-BpifTcoNeLOVSTl53Q';
    var map = new mapboxgl.Map({
    container: 'map',
     style: 'mapbox://styles/mapbox/streets-v10',

     //center: [-63.188496,-17.790127],
     center: [x1,x2],
     zoom:13
     });


//https://docs.mapbox.com/help/tutorials/building-a-store-locator/

     var marker=new mapboxgl.Marker({
    draggable: true
    }).setLngLat({
         lng:-63.188496,
         lat:-17.790127
     }).addTo(map)

     function onDragEnd() {
            var lngLat = marker.getLngLat();
            
            document.getElementById('x').value =lngLat.lng;;
            document.getElementById('y').value =lngLat.lat;
            }
            
            marker.on('dragend', onDragEnd);




            var pack = {
                "type": "FeatureCollection",
                "features": [
                  {
                    "type": "Feature",
                    "geometry": {
                      "type": "Point",
                      "coordinates": [
                        -77.034084142948,
                        38.909671288923
                      ]
                    },
                    "properties": {
                      "phoneFormatted": "(202) 234-7336",
                      "phone": "2022347336",
                      "address": "1471 P St NW",
                      "city": "Washington DC",
                      "country": "United States",
                      "crossStreet": "at 15th St NW",
                      "postalCode": "20005",
                      "state": "D.C."
                    }
                  },
                  {
                    "type": "Feature",
                    "geometry": {
                      "type": "Point",
                      "coordinates": [
                        -77.049766,
                        38.900772
                      ]
                    },
                    "properties": {
                      "phoneFormatted": "(202) 507-8357",
                      "phone": "2025078357",
                      "address": "2221 I St NW",
                      "city": "Washington DC",
                      "country": "United States",
                      "crossStreet": "at 22nd St NW",
                      "postalCode": "20037",
                      "state": "D.C."
                    }
                  },
                  {
                    "type": "Feature",
                    "geometry": {
                      "type": "Point",
                      "coordinates": [
                        -63.19047010582818,
                        -17.79053563173207
                      ]
                    },
                    "properties": {
                      "phoneFormatted": "(202) 387-9338",
                      "phone": "2023879338",
                      "address": "1512 Connecticut Ave NW",
                      "city": "Washington DC",
                      "country": "United States",
                      "crossStreet": "at Dupont Circle",
                      "postalCode": "20036",
                      "state": "D.C."
                    }
                  },
                  {
                    "type": "Feature",
                    "geometry": {
                      "type": "Point",
                      "coordinates": [
                        -77.0672,
                        38.90516896
                      ]
                    },
                    "properties": {
                      "phoneFormatted": "(202) 337-9338",
                      "phone": "2023379338",
                      "address": "3333 M St NW",
                      "city": "Washington DC",
                      "country": "United States",
                      "crossStreet": "at 34th St NW",
                      "postalCode": "20007",
                      "state": "D.C."
                    }
                  },
                  {
                    "type": "Feature",
                    "geometry": {
                      "type": "Point",
                      "coordinates": [
                        -77.002583742142,
                        38.887041080933
                      ]
                    },
                    "properties": {
                      "phoneFormatted": "(202) 547-9338",
                      "phone": "2025479338",
                      "address": "221 Pennsylvania Ave SE",
                      "city": "Washington DC",
                      "country": "United States",
                      "crossStreet": "btwn 2nd & 3rd Sts. SE",
                      "postalCode": "20003",
                      "state": "D.C."
                    }
                  },
                  {
                    "type": "Feature",
                    "geometry": {
                      "type": "Point",
                      "coordinates": [
                        -76.933492720127,
                        38.99225245786
                      ]
                    },
                    "properties": {
                      "address": "8204 Baltimore Ave",
                      "city": "College Park",
                      "country": "United States",
                      "postalCode": "20740",
                      "state": "MD"
                    }
                  },
                  {
                    "type": "Feature",
                    "geometry": {
                      "type": "Point",
                      "coordinates": [
                        -77.097083330154,
                        38.980979
                      ]
                    },
                    "properties": {
                      "phoneFormatted": "(301) 654-7336",
                      "phone": "3016547336",
                      "address": "4831 Bethesda Ave",
                      "cc": "US",
                      "city": "Bethesda",
                      "country": "United States",
                      "postalCode": "20814",
                      "state": "MD"
                    }
                  },
                  {
                    "type": "Feature",
                    "geometry": {
                      "type": "Point",
                      "coordinates": [
                        -77.359425054188,
                        38.958058116661
                      ]
                    },
                    "properties": {
                      "phoneFormatted": "(571) 203-0082",
                      "phone": "5712030082",
                      "address": "11935 Democracy Dr",
                      "city": "Reston",
                      "country": "United States",
                      "crossStreet": "btw Explorer & Library",
                      "postalCode": "20190",
                      "state": "VA"
                    }
                  },
                  {
                    "type": "Feature",
                    "geometry": {
                      "type": "Point",
                      "coordinates": [
                        -77.10853099823,
                        38.880100922392
                      ]
                    },
                    "properties": {
                      "phoneFormatted": "(703) 522-2016",
                      "phone": "7035222016",
                      "address": "4075 Wilson Blvd",
                      "city": "Arlington",
                      "country": "United States",
                      "crossStreet": "at N Randolph St.",
                      "postalCode": "22203",
                      "state": "VA"
                    }
                  },
                  {
                    "type": "Feature",
                    "geometry": {
                      "type": "Point",
                      "coordinates": [
                        -75.28784,
                        40.008008
                      ]
                    },
                    "properties": {
                      "phoneFormatted": "(610) 642-9400",
                      "phone": "6106429400",
                      "address": "68 Coulter Ave",
                      "city": "Ardmore",
                      "country": "United States",
                      "postalCode": "19003",
                      "state": "PA"
                    }
                  },
                  {
                    "type": "Feature",
                    "geometry": {
                      "type": "Point",
                      "coordinates": [
                        -75.20121216774,
                        39.954030175164
                      ]
                    },
                    "properties": {
                      "phoneFormatted": "(215) 386-1365",
                      "phone": "2153861365",
                      "address": "3925 Walnut St",
                      "city": "Philadelphia",
                      "country": "United States",
                      "postalCode": "19104",
                      "state": "PA"
                    }
                  },
                  {
                    "type": "Feature",
                    "geometry": {
                      "type": "Point",
                      "coordinates": [
                        -17.79821773436113,
                        -63.20875204248205
                      ]
                    },
                    "properties": {
                      "phoneFormatted": "(202) 331-3355",
                      "phone": "2023313355",
                      "address": "1901 L St. NW",
                      "city": "Washington DC",
                      "country": "United States",
                      "crossStreet": "at 19th St",
                      "postalCode": "20036",
                      "state": "D.C."
                    }
                  }
                ]
              };
 
              var stores
              document.write('hoal');
              document.write(pack);

            /*  $.ajax({
                    url: 'person',
                    type: 'get',
                    data:'_token = <?php echo csrf_token() ?>',
                    success: function (data) {
                         stores = data;
              }});*/
              

                /* function getJson(url) {
                  return JSON.parse($.ajax({
                      type: 'GET',
                      url: url,
                      dataType: "json",
                      global: false,
                    
                      success: function(data) {
                          
                        return data;
                      }
                  }).responseText);
                  }
                */  

                var urls=JSON.parse($.ajax({
                      type: 'GET',
                      url: 'person',
                      global: false,
                      async: true,
  
                  }).responseText);
                  //document.write(url);
                   //var x = getJson('person');
                   //stores= geoJSON (x.responseJSON)

             // document.write(stores);
             console.log(urls);
             console.log(pack);
             map.on('load', function(e) {
                // Add the data to your map as a layer
                map.addLayer({
                  id: 'locations',
                  type: 'symbol',
                  // Add a GeoJSON source containing place coordinates and information.
                  source: {
                    type: 'geojson',
                    data: urls,
                  },
                  layout: {
                    'icon-image': 'restaurant-15',
                    'icon-allow-overlap': true,
                  }
                });
              });


</script>
</html>