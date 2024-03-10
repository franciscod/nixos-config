if status is-interactive
    set -g fish_greeting

    function fish_vcs_prompt
        # sloooow!
        #
        #         $ fish --profile prompt.prof -ic 'fish_prompt; exit'; cat prompt.prof | sort -nk 2
    end
end
