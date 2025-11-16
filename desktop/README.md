
### Custom desktop apps and file associations

```
sudo cp swayimg.desktop /usr/share/applications/
xdg-mime query default image/jpeg
xdg-mime default swayimg.desktop image/jpeg
```
