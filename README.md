# GPS scripts

A collection of simple bash shell scripts for manipulating GPS files.  Folder teqc contains scripts for working with raw GPS observation data in rinex or SBF formats.  Folder etrex has scripts for converting .gpx files  from a handheld Garmin eTrex GPS device (or likely other similar brands) to .shp format.

## Getting Started

These scripts will not run off the shelf on your system, since they were made in a hurry for my environment!  Some debugging will be required to change pathnames to executables and data files.  In some cases, this will mess up filename parsing.

### Prerequisites

```
Linux operating system to run bash scripts.
For teqc: install teqc from UNAVCO
For etrex: install gdal
```
Windows Subsystem for Linux can be installed from the microsoft store.  More info [here](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

teqc installation [link](https://www.unavco.org/software/data-processing/teqc/teqc.html)

gdal installation [link](https://gdal.org/download.html)

## Authors

* **Ethan Kyzivat**

## Acknowledgments

* Thanks to UNAVCO for developing the free software teqc.
