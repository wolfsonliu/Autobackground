# autobackground #

Generate xml file used by gnome desktop environment to change background automatically.


## Usage ##

```
usage: autobackground [-h] [-d FIGURE_DIRECTORY] [-o OUTPUT]  
                      [-wd WORKING_DIRECTORY]  
                      [-t [DURATION_TIME [DURATION_TIME ...]]] [-r]  
                      [-x {overlay}]  
                      [figname [figname ...]]  

Make auto change background of gnome desktop  

positional arguments:  
  figname               an integer for the accumulator  

optional arguments:  
  -h, --help            show this help message and exit  
  -d FIGURE_DIRECTORY, --figure-directory FIGURE_DIRECTORY  
                        The directory to store all the background figures.  
  -o OUTPUT, --output OUTPUT  
                        The output xml file name.  
  -wd WORKING_DIRECTORY, --working-directory WORKING_DIRECTORY  
                        The working directory, where is the default place to  
                        save xml file.  
  -t [DURATION_TIME [DURATION_TIME ...]], --duration-time [DURATION_TIME [DURATION_TIME ...]]  
                        Duration time for each background.  
  -r, --random-time     Set duration time to random time.  
  -x {overlay}, --transition {overlay}  
                        Set duration time to random time.  
```

## Example ##


In order to use this tool, download the autobackground file.

Then:
```
$ chmod u+x autobackground
$ ./autobackground -d Background
```

# bing_daily #

* Download bing daily figures and change background.
* The osx file is used for Mac OS.

# nasa_daily #

* Donwload NASA image of the day and change background.
* The osx file is used for Mac OS.
