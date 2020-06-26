# dotfiles
my .dotfiles

## Git Aliases
- Common
    - `cm` for `commit`
    - `cme` to add everything and commit
    - `co` for `checkout`
    - `cob` for `checkout -b`
    - `fixup` for `commit --amend`
    - `cp` for `cherry-pick`
    - `st` for `status`
    - `br` for `branch`
- Specific for my development
    - `cobf` for `checkout -b feature/<arg name of the branch>`
    - `cobb` for `checkout -b hotfix/<arg name of the branch>`
    - `cobh` for `checkout -b bugfix/<arg name of the branch>`
    - `cobr` for `checkout -b release/<arg name of the branch>`
    - `cof` for `checkout feature/<arg name of the branch>`
    - `coh` for `checkout hotfix/<arg name of the branch>`
    - `cor` for `checkout release/<arg name of the branch>`
    - `return` to checkout to the main branch
    - `glog` to get a good log
    - `slog` to get a good short log
    - `sdlog` same as above but includes dates
    - `save` to add all changes including untracked files and do a temporal commit, I typically use this along with `undo` or `amend`
    - `wip` same to `save` but doesn't add untracked files
    - `undo` to reset the previous commit
    - `wipe` to commit everything in the working directory and then does a hard reset to remove that commit, but that commit can be restored.
    - `up` to update the current branch, it's possible this will removed and instead use `ruffwd` or `rupffwd`
    - `sync` to synchronize the repo, it uses `up` to pull and `git push`
    - `aliases` shows all git aliases
    - Complex
        - `ruffwd` and `rupffwd` do `remote update`, the later one with `--prune` and updates all tracking branches, see helper `ffwd`
        - `brclean` deletes every branch that’s been merged into the specified branch except the branch, when no branch is specified, it uses the default branch
        - `brunsafed` deletes every branch using `-D` that aren't the default, 'master', 'development', 'develop' or 'dev', stands for **BR**anch **UNSAFE D**elete
        - `brd` deletes every branch whose remote tracking branch is gone, this also uses `-D`
        - `brdone` goes to the main branch, updates with `git up` and cleans with `brclean`
        - `migrate` explanation from [this post](https://haacked.com/archive/2015/06/29/git-migrate/):

If I’m on a branch and want to migrate the local only commits over to master, I can just run `$ git migrate new-branch-name`. This works whether I’m on master or some other wrong branch.

I can also migrate the commits to a branch created off of something other than master using this command: `$ git migrate new-branch other-branch`

And finally, if I want to just migrate the last commit to a new branch created off of master, I can do this.

`$ git migrate new-branch master HEAD~1`

| Parameter     | Type     | Description                                                             |
|---------------|----------|-------------------------------------------------------------------------|
| branch-name   | required | Name of the new branch.                                                 |
| target-branch | optional | Defaults to "master". The branch that the new branch is created off of. |
| commit-range  | optional | The commits to migrate. Defaults to the current remote tracking branch. |

- Helpers
	- `default` prints the main branch
    - `ffwd` to update all tracking branches, [more info](http://stackoverflow.com/questions/9076361)

## Bash Aliases
- `ist` for **I**nternet usage **ST**atistic, it requires `vnstat`
- `onegai` to execute the previous command as `sudo`
- `baka` for `git` e.g. `baka pull master`, `baka push master`.
- `gt` for `git`, this may overlap with other commands in your environment
- `phpl` for `php artisan`
- `d7`, `d4`, `d3`, `d2`, goes to Downloads folder and downloads videos using [youtube-dl](https://github.com/ytdl-org/youtube-dl) in 720p, 480p, 360p or 240p if available
- `dm7`, `dm4`, `dm3`, `dm2` same as above but goes to Music instead.

## How I configured my terminal

This is from [Coder's Tape Deployment Guide](https://gist.github.com/vicgonvt/cd0431a5cdc043ebab7f4954f7b4d471#extra-credit):

Let's make the prompt pretty

+ `sudo apt-get install zsh` to install ZSH
+ `zsh --version` to confirm install
+ `whereis zsh` to find out where it is
+ `sudo usermod -s /usr/bin/zsh $(whoami)` to make Zsh default
+ `sudo reboot` to reapply all changes
+ `2` to populate a default file
+ `sudo apt-get install powerline fonts-powerline` to install powerline
+ `sudo apt-get install zsh-theme-powerlevel9k` to install Theme
+ `echo "source /usr/share/powerlevel9k/powerlevel9k.zsh-theme" >> ~/.zshrc` to enable the theme in your Zshrc
+ `exit` and login again to see the new theme
+ `sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"` for Oh My Zsh
+ `echo "source /usr/share/powerlevel9k/powerlevel9k.zsh-theme" >> ~/.zshrc` to re-enable 9K

## References
- For `brdone`, `brclean`, `wip`, `save`, `wipe`, `up` and `migrate` are from [haacked](https://haacked.com/archive/2014/07/28/github-flow-aliases)
- For `ffwd`, `ruffwd` and `rupffwd` are from [muhqu](https://github.com/muhqu/dotfiles)
- For [How I configured my terminal](#how-i-configured-my-terminal) section is from [Coder's Tape Deployment Guide](https://gist.github.com/vicgonvt/cd0431a5cdc043ebab7f4954f7b4d471#extra-credit)

## License
MIT
