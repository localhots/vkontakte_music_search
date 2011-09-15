# Vkontakte (VK.com) API music search tool

Don't forget to log in to [vk.com API](http://vk.com/developers.php?oid=-17680044&p=Open_API)

```coffeescript
vk_music = new VkontakteMusic
url = vk_music.search "Kasabian", "L.S.F. (Lost Souls Forever)", 197

audio = document.createElement "audio"
audio.setAttribute "src", url
document.getElementsByTagName("body")[0].appendChild audio
audio.play()
```
