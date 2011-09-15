class VkontakteMusic
  query_results = {}
  
  search: (artist, track, duration, callback) ->
    query = this.prepareQuery artist, track
    if @query_results[query]
      callback @query_results[query]
    that = this
    VK.Api.call 'audio.search', q: query, (r) ->
      best_result = that.matchPerfectResult(r.response)
      that.query_results[query] = best_result
      callback best_result
  
  matchPerfectResult: (data, artist, track, duration) ->
    duration = duration.split ':'
    duration = parseInt(duration[0], 10) * 60 + parseInt(duration[1], 10)
    best_score = 0;
    best_result = null;
    for item in data
      if typeof item is 'object'
        score = 0;
        item.artist = item.artist.trim();
        item.title = item.title.trim();
        if item.artist.length > 0
          if item.artist == artist
            score += 10
          else if item.artist.split(artist).length is 2
            score += 5
          else if item.title.split(artist).length is 2
            score += 4
        if item.artist.length > 0
          if item.title == track
            score += 10
          else if item.title.split(track).length is 2
            score += 5
        if parseInt(item.duration, 10) == duration
          score += 15
        else
          delta = Math.abs parseInt(item.duration, 10) - duration
          score += (10 - delta) if delta < 10
        if score > best_score
          best_score = score
          best_result = item.url
        if score is 35
          return best_result
    best_result
  
  prepareQuery: (artist, track) ->
    artist+" "+track.replace(/\(.*\)/i, '').split('/')[0]
  
  trim: (str) ->
  	while str.indexOf('  ') != -1
  		str = str.replace('  ', ' ')
  	if str.charAt(0) == ' '
  		str = str.substring 1
  	if str.charAt(str.length - 1) == ' '
  		str = str.substring(0, str.length - 1)
  	str