# Setting Up

1. Install Bash on Ubuntu on Windows or Git Bash
2. Create a new Minecraft instance or mod profile.
3. Go to instance folder. If you are using curseforge the path should look like `C:\Users\<your name>\curseforge\minecraft\Instances\<your new profile>`.
4. Open your bash to this folder.
  a. You might be able to right click in the folder (not on any folder or file, on the background or on the folder itself from its parent) and select "Open Git Bash here" or "Open in Terminal". If you do "Open in Terminal" make sure it's using Bash on Ubuntu by typing `ls`. This is a valid command on Bash on Ubuntu and is not a valid command on regular Windows terminal.
  b. You can also navigate to this directory using bash. If you're using Git Bash run `cd  ~/curseforge/minecraft/Instances/<your new profile>`. cd is the command to change your directory.
  c. If you're using Bash on Ubuntu instead, the command is probably `cd /mnt/c/Users/<your name>/curseforge/minecraft/Instances/<your new profile>`. This is because Bash on Ubuntu puts your whole windows file system in the `/mnt/` directory of the Ubuntu subsystem.
5. When you're in the right place type `ls`, the "list" command, to see what's in the directory. You should see minecraft related folders and files.
6. Run `git init`. This will set up a Git repository in the instance folder.
7. Run `git remote add origin https://github.com/jlillioja/distant-horizons.git`. This tells Git that your local Git repository should get changes from another Git repository located at that URL.
8. Delete the `mods` folder of the instance, if it exists. We are going to overwrite it with the mods in the remote repository.
9. Run `git pull origin master`. This will download all the latest mods from this repository - you should see the `mods` folder get recreated, and a bunch of mods go in there. It might take a little time to download.
10. Launch through curseforge as usual. The Curseforge launcher will recognize many but not all of the mods in the folder, but don't mess with anything like updating them.

## Updating
If you've already set up, you can update by following step 4 to go to the folder in your bash, and then step 9 `git pull origin master` to get the latest changes.
