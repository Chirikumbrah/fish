function o
  if count $argv > /dev/null
    if test "$argv[1]" = "$HOME/" || test "$argv[1]" = "$HOME" || test "$argv[1]" = "/"
      set FILE "$(fd . "$argv[1]" --hidden -a -tf --color=always | fzf --ansi -m)"
    else
      set FILE "$argv"
    end
  else
    set FILE "$(fd --hidden -a -tf --color=always | fzf --ansi -m)"
  end
  if test $FILE != ''
    if test "$(echo $FILE | grep -iE '\.(jpg|jpe?g|png|gif|svg|webp|tiff|heif|heic|avif|ico|bmp)$')"
      set APP $IMAGE_VIEWER
    else
      set APP xdg-open
    end
  end
  echo $FILE | nohup xargs $APP &> /dev/null & disown
end
