$(document).ready ->
  class window.Map

    constructor: (@el, @collection, template = "", @shadow = "") ->
      @options =
        zoom: 13
        mapTypeId: google.maps.MapTypeId.ROADMAP
      @map = new google.maps.Map @el, @options
      @setTemplate template

    setTemplate: (template)->
      @template = _.template(template)

    setMarkers: (collection) ->
      c = collection || @collection
      c = @chompCollection c
      @markers = []
      for o in c
        latlng = new google.maps.LatLng o.lat, o.lng
        options = 
          position: latlng
          content: @template(o)
          shadow: @shadow
        marker = null
        if not (options.content)
          marker = new google.maps.Marker(options)
        else
          marker = new RichMarker(options)
        @markers.push(marker)

      mcOptions = 
        gridSize: 50
        maxZoom: 15
      mc = new MarkerClusterer(@map, @markers, mcOptions)

      @fitBoundsWithMarkers()
      
    fitBoundsWithMarkers: (markers) ->
      markers ||= @markers
      bounds = new google.maps.LatLngBounds()
      for o in markers
        bounds.extend o.position
      @map.fitBounds bounds

    chompCollection: (collection) ->
      _.chain(collection)
        .reject( (o)->
          # 去掉没有经纬度的活动
          not (o.lat and o.lng)
        )
        .reject( (o)->
          # 去掉不是被访问用户的活动, 如果指定了用户
          return user_id != o.user.id unless typeof user_id == 'undefined'

          false
        )
        .value()






        

