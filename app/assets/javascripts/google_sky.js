
var mapTypes = {};

    // set up the map types

    mapTypes['sky'] = {
      getTileUrl: function(coord, zoom) {
        return getHorizontallyRepeatingTileUrl(coord, zoom, function(coord, zoom) {
          return "http://mw1.google.com/mw-planetary/sky/skytiles_v1/" +
          coord.x + "_" + coord.y + '_' + zoom + '.jpg';

        });
      },
      tileSize: new google.maps.Size(256, 256),
      isPng: false,
      maxZoom: 13,
      radius: 57.2957763671875,
      name: 'Sky',
      credit: 'Image Credit: SDSS, DSS Consortium, NASA/ESA/STScI'
    };

    // Normalizes the tile URL so that tiles repeat across the x axis (horizontally) like the
    // standard Google map tiles.
    function getHorizontallyRepeatingTileUrl(coord, zoom, urlfunc) {
      var y = coord.y;
      var x = coord.x;

      // tile range in one direction range is dependent on zoom level
      // 0 = 1 tile, 1 = 2 tiles, 2 = 4 tiles, 3 = 8 tiles, etc
      var tileRange = 1 << zoom;

      // don't repeat across y-axis (vertically)
      if (y < 0 || y >= tileRange) {
        return null;
      }

      // repeat across x-axis
      if (x < 0 || x >= tileRange) {
        x = (x % tileRange + tileRange) % tileRange;
      }

      return urlfunc({x:x,y:y}, zoom)
    }

    function getMarsTileUrl(baseUrl, coord, zoom) {
      var bound = Math.pow(2, zoom);
      var x = coord.x;
      var y = coord.y;
      var quads = ['t'];

      for (var z = 0; z < zoom; z++) {
        bound = bound / 2;
        if (y < bound) {
          if (x < bound) {
            quads.push('q');
          } else {
            quads.push('r');
            x -= bound;
          }
        } else {
          if (x < bound) {
            quads.push('t');
            y -= bound;
          } else {
            quads.push('s');
            x -= bound;
            y -= bound;
          }
        }
      }

      return baseUrl + quads.join('') + ".jpg";
    }

    var map;
    var mapTypeIds = [];

    // Setup a copyright/credit line, emulating the standard Google style
    var creditNode = document.createElement('div');
    creditNode.id = 'credit-control';
    creditNode.style.fontSize = '11px';
    creditNode.style.fontFamily = 'Arial, sans-serif';
    creditNode.style.margin = '0 2px 2px 0';
    creditNode.style.whitespace = 'nowrap';
    creditNode.index = 0;

    function setCredit(credit) {
      creditNode.innerHTML = credit + ' -';
    }

    function initialize() {

      // push all mapType keys in to a mapTypeId array to set in the mapTypeControlOptions
      for (var key in mapTypes) {
        mapTypeIds.push(key);
      }

      var myLatLng = {lat: -25.2882777, lng: -168.11233330000005};


      var mapOptions = {
        zoom: 10,
        center: new google.maps.LatLng(myLatLng),
        mapTypeControlOptions: {
          mapTypeIds: mapTypeIds,
          style: google.maps.MapTypeControlStyle.DROPDOWN_MENU
        }
      };
      map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);

      // push the credit/copyright custom control
      map.controls[google.maps.ControlPosition.BOTTOM_RIGHT].push(creditNode);

      // add the new map types to map.mapTypes
      for (key in mapTypes) {
        map.mapTypes.set(key, new google.maps.ImageMapType(mapTypes[key]));
      }

      // handle maptypeid_changed event to set the credit line
      google.maps.event.addListener(map, 'maptypeid_changed', function() {
        setCredit(mapTypes[map.getMapTypeId()].credit);
      });

      // start with the moon map type
      map.setMapTypeId('sky');


      var marker = new google.maps.Marker({
        position: myLatLng,
        map: map,
        title: 'Hello World!'
      });
    }


    $( document ).ready(function() {
      initialize();
    });
