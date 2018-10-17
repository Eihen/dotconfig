# My Windows Subsystem for Linux (WSL) Environment

This branch holds a tweaked version of the master branch for using in the Microsoft's [WSL](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux).

Note that to clone this branch you need to use a command slightly different from usual (which is noted below), since it's a pain to change branches in a bare repository after cloned.
Also, this banch has submodules so there's an additional step.

## Installing these files on your system

+ Add the repository folder to a .gitignore in your home folder to avoid recursion problems

```bash
echo '.dotconfig' >> $HOME/.gitignore
```

+ Clone this repository as bare into the .dotconfig folder

```bash
git clone --bare -b wsl https://github.com/Eihen/dotconfig $HOME/.dotconfig
```

+ Define the alias in your current shell scope to make your life easier

```bash
alias config="/usr/bin/git --git-dir=$HOME/.dotconfig --work-tree=$HOME"
```

+ Set the local repository configuration to don't show untracked files (otherwise every file on your home folder will be showed)

```bash
config config --local status.showUntrackedFiles no
```

+ Checkout the actual repository content

```bash
config checkout
```

+ Init and clone the submodules

```bash
config submodule init
config submodule update
```

+ If one or more configuration files already exists the above command will fail with a message about those files being overwritten. To solve this you need to move the list files to a backup folder or just remove them if you don't care.

## Set up your own .config repository

+ Init a bare repository on your $HOME folder

```bash
git init --bare $HOME/.dotconfig
```

+ Set an alias for the repository to make your life easier (it would be pretty painful writing the full command all the time)

```bash
alias config="/usr/bin/git --git-dir=$HOME/.dotconfig --work-tree=$HOME"
```

+ Set the local repository configuration to don't show untracked files (otherwise every file on your home folder will be showed)

```bash
config config --local status.showUntrackedFiles no
```

+ Put the alias we used before in your .bashrc for future use

```bash
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotconfig --work-tree=$HOME'" >> $HOME/.bashrc
```

## How to use it

+ You use it just like a git repository, replacing the `git` with the `config` alias

### Examples

+ Display changed tracked files

```bash
config status
```

+ Add a new file or stage changes on already tracked files

```bash
config add .bashrc
```

+ Commit the changes to the repository

```bash
config commit
```

+ Push changes to upstream

```bash
config push
```

## Credits

+ [Nicola Paolucci](https://developer.atlassian.com/blog/authors/npaolucci/) for this [Atlassian Developer Blog Post](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/) in which this repository structure and instructions are based.

+ [Chris Kempson](https://github.com/chriskempson) for the awesome [base16](https://github.com/chriskempson/base16) theme architecture and the [base16-shell](https://github.com/chriskempson/base16-shell) that is included in this configuration as a submodule.

+ [Seth Wright](http://sethawright.com) for the **base16-google-dark** for shell in the above repository.
