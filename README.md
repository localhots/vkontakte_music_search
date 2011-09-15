# Vkontakte (VK.com) API music search tool

Don't forget to log in to [vk.com API](http://vk.com/developers.php?oid=-17680044&p=Open_API)

### CoffeeScript example
```coffeescript
vk_music = new VkontakteMusic
vk_music.search "Kasabian", "L.S.F. (Lost Souls Forever)", "2:17", (url) ->
  audio = document.createElement "audio"
  audio.setAttribute "src", url
  document.getElementsByTagName("body")[0].appendChild audio
  audio.play()
  false
```

### JavaScript example
```javascript
var vk_music;
vk_music = new VkontakteMusic;
vk_music.search("Kasabian", "L.S.F. (Lost Souls Forever)", "2:17", function(url) {
  var audio;
  audio = document.createElement("audio");
  audio.setAttribute("src", url);
  document.getElementsByTagName("body")[0].appendChild(audio);
  audio.play();
  return false;
});
```