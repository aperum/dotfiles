function copyfile {
  [[ "$#" != 1 ]] && return 1
  local file_to_copy=$1
  xclip -sel clip < $file_to_copy
}
