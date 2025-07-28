function clone
    if string match '*/*' $argv
        git clone git@github.com:$argv.git
    else
        git clone git@github.com:joshsurber/$argv.git
    end
end
