# My Linux environment configuration files


## Installing these files on your system

+ Add the repository folder to a .gitignore in your home folder to avoid recursion problems

```bash
echo '.dotconfig' >> .gitignore
```

+ Clone this repository as bare into the .dotconfig folder

```bash
git clone --bare https://github.com/Eihen/dotconfig
```

+ Define the alias in your current shell scope to make your life easier

```bash
alias config="/usr/bin/git --git-dir=$HOME/.dotconfig --work-tree=$HOME"
```

+ Checkout the actual repository content

```bash
config checkout
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

+ Set the repository configuration to don't show untracked files (otherwise every file on your home folder will be showed)

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

##### Based on this [Atlassian Developer Blog Post](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/) by [Nicola Paolucci](https://developer.atlassian.com/blog/authors/npaolucci/).