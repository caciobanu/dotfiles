on run argv
    # Determine the hosts file.
    set hostsFile to item 1 of argv

    # Read hosts from file.
    set hosts to paragraphs of (read hostsFile as «class utf8»)

    set n to count of hosts
    set found to false
    set sqrt to n ^ 0.5
    set i to sqrt as integer

    set columns_ to 0
    set rows_ to 0
    repeat until found
    if n mod i is 0 then
        set rows_ to i
        set columns_ to n div i
        set found to true
    else
        set i to i - 1
    end if
    end repeat

    tell application "iTerm"
        activate
        create window with default profile

        tell current session of current window
            set i to 1
            repeat until i = columns_
            split vertically with default profile
            set i to i + 1
            end repeat
        end tell

        set j to 1
        repeat until j = rows_
            set i to 1
            repeat until i = columns_ * (j + 1)
                if i mod (j + 1) is 0 then
                    tell session i of current tab of current window
                    split horizontally with default profile
                    end tell
                end if
                set i to i + 1
            end repeat
            set j to j + 1
            tell first session of current tab of current window
            split horizontally with default profile
            end tell
        end repeat

        set i to 1
        repeat until i = n + 1
            tell session i of current tab of current window
                write text "ssh " & (item i of hosts)
            end tell
            set i to i + 1
        end repeat
    end tell
end run
