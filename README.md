This Bash script automatically creates and organizes split panes in a screen session, running
specified commands in each pane. It is useful for visualizing multiple command outputs in an
organized terminal layout.



1)Run the script within a screen session:
screen
./script.sh [splits and moves] [commands]

2)Parameters:
v# — Number of vertical splits (e.g., v1 for one vertical split).
h# — Number of horizontal splits (e.g., h1 for one horizontal split).
m# — Move focus across splits by the specified count.
Any additional arguments after these parameters are treated as commands 
to be executed in the respective windows.

3)Example:
./script.sh v1 h1 m2 h1 top free free top

![image](https://github.com/user-attachments/assets/f60331aa-6047-43bb-86f8-3d5aaadf5689)

v1 creates one vertical split.
h1 creates one horizontal split in the right pane.
m2 moves the focus to another pane.
top, free, and top run in the respective panes created.

Setup in Virtual Machine
1/Clone the repository:
git clone https://github.com/your-username/ScreenSplitRunner.git

2/Navigate to the directory:
cd ScreenSplitRunner

3/Make the script executable:
chmod +x script.sh


