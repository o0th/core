def remove [file] {
  if ($file | path exists) {
    print -n $"Removing file ($file)\n"
    let operation = (^rm ($file) | complete)
    if ($operation | get exit_code) != 0 {
      print -n $"Failed to remove file $(file)\n"
      exit 1
    }
  }
}

def copy [source, destination] {
  print -n $"Creating file ($source)\n"
  let operation = (^ln -s ($source) ($destination) | complete)
  if ($operation | get exit_code) != 0 {
    print -n $"Failed to create file $(destination)\n"
    exit 1
  }
}

#
# core
#

let home = "/home/o0th"
let core = $"($env.PWD)($home)"

#
# kitty
#

let kitty_source = $"($core)/.config/kitty"
let kitty_destination = $"($home)/.config/kitty"

remove $kitty_destination
copy $kitty_source $kitty_destination

#
# nushell 
#

let nushell_source = $"($core)/.config/nushell"
let nushell_destination = $"($home)/.config/nushell"

remove $nushell_destination
copy $nushell_source $nushell_destination

#
# ssh config
#

let ssh_source = $"($core)/.ssh/config"
let ssh_destination = $"($home)/.ssh/config"

remove $ssh_destination
copy $ssh_source $ssh_destination
