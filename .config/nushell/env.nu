#
# ssh-agent configuration
#

let sshAgentFilePath = $"/tmp/ssh-agent-($env.USER).nuon"

if ($sshAgentFilePath | path exists) and ($"/proc/((open $sshAgentFilePath).SSH_AGENT_PID)" | path exists) {
    # loading it
    load-env (open $sshAgentFilePath)
} else {
    # creating it
    ^ssh-agent -c
        | lines
        | first 2
        | parse "setenv {name} {value};"
        | transpose -r
        | into record
        | save --force $sshAgentFilePath
    load-env (open $sshAgentFilePath)
}


#
# fnm configuration
#

if not (which fnm | is-empty) {
  ^fnm env --json | from json | load-env
  let node_path = $"($env.FNM_MULTISHELL_PATH)/bin"
  $env.PATH = ($env.PATH | split row (char esep) | prepend $node_path)
}
