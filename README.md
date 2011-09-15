# Vkontakte (VK.com) API music search tool

Don't forget to log in to [vk.com API](http://vk.com/developers.php?oid=-17680044&p=Open_API)

```coffeescript
vk_music = new VkontakteMusic
vk_music.search "Kasabian", "L.S.F. (Lost Souls Forever)", "2:17", (url) ->
  audio = document.createElement "audio"
  audio.setAttribute "src", url
  document.getElementsByTagName("body")[0].appendChild audio
  audio.play()
```

If you need a compiled JavaScript version, feel free to compile it yourself on [CoffeeScript's home page](http://jashkenas.github.com/coffee-script/).
