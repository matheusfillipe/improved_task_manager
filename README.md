#  Improved Task Manager

Is just the standart task manager of KDE Plasma 5 but it remembers the order of
you set for your tasks.

## Description

Whenever you drag a task in the task bar it will save your current ordering for
all tasks that you currently have per virtual desktop and activity, so it will
compare and sort automatically whenever you open one of the saved applications
again.

I created this because I like to use the meta keys to switch between tasks and
like to have things always at the same place. This is useful if you always have
the same applications open. Basically this is an attempt to make my DE a bit more
tilling window manager like.

This will only workd if you enable manual sort under the improved task manager
tab and the layout is saved once you drag any item in the virtual desktop.

## Getting Started

### Dependencies

Nothing, I only edited the qml code of the default task manager, do you just
need plasma DE running. This was tested on:

KDE Plasma Version: 5.18.5
KDE Frameworks Version: 5.70.0
Qt Version: 5.14.2


### Installing

To install run:

`plasmapkg2 -i improved_plasma_taskmanager`

To update or reinstall:

`plasmapkg2 -r improved_plasma_taskmanager && plasmapkg2 -i improved_plasma_taskmanager`

Then use the improved task manager widget, or replace your task current task
manager with this.
