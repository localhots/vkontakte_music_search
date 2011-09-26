###
 * Vkontakte (VK.com) API music search tool
 * https://github.com/magnolia-fan/vkontakte_music_search
 *
 * Copyright 2011, Gregory Eremin
 * Licensed under the MIT license.
 * https://raw.github.com/magnolia-fan/vkontakte_music_search/master/LICENSE
 ###
class window.VkontakteMusic
  query_results: {}
  
  search: (artist, track, duration, callback, return_all = false) ->
    query = this.prepareQuery artist, track
    if @query_results[query]? and not return_all
      callback @query_results[query]
    that = this
    VK.Api.call 'audio.search', q: query, (r) ->
      results = that.range r.response, artist, track, duration
      top_result = null
      if results.length > 0
        top_result = results[0].url
      that.query_results[query] = results
      callback if return_all then results else top_result
  
  range: (data, artist, track, duration) ->
    if typeof duration is 'string'
      duration = duration.split ':'
      duration = parseInt(duration[0], 10) * 60 + parseInt(duration[1], 10)
    for item, i in data
      if typeof item isnt 'object'
        continue
      item.score = 0;
      item.artist = this.trim(item.artist);
      item.title = this.trim(item.title);
      score = 0
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
      data[i].score = score
    if data.length > 0 and typeof data[0] isnt 'object'
      data.splice 0, 1
      data.sort (a, b) ->
        b.score - a.score
    data
  
  prepareQuery: (artist, track) ->
    artist+" "+track.replace(/\(.*\)/i, '').split('/')[0]
  
  trim: (str) ->
    while str.indexOf('  ') isnt -1
      str = str.replace '  ', ' '
    if str.charAt(0) is ' '
      str = str.substring 1
    if str.charAt(str.length - 1) is ' '
      str = str.substring 0, str.length - 1
    str
