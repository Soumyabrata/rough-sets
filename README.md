# Rough-set Based Color Channel Selection

With the spirit of reproducible research, this repository contains all the codes required to generate figures and tables in the manuscript: S. Dev, F. M. Savoy, Y. H. Lee, S. Winkler, Rough-set Based Visible Color Channel Selection, *IEEE Geoscience and Remote Sensing Letters*, accepted, 2016. 

## Manuscript
The preprint version of this manuscript is `preprint.PDF`. 

## Code Organization
All codes are written in MATLAB. 

This entire repository is structured as follows. The folder `helperScripts` contains all the helper functions necessary for various tasks, the folder `preComputed` contains a few pre-computed results for reproducible purposes, and the folder `roughSetScripts` contains all the rough-set related scripts that can be used in any contexts.

### Dataset
The dataset used in this manuscript is HYTA dataset from Li et. al, A Hybrid Thresholding Algorithm for Cloud Detection on Ground-Based Color Images, *Journal of Atmospheric and Oceanic Technology*, 2011. Please contact the respective authors for the dataset.

### Helper functions
* `accuracy.m` Calculates the Precision, Recall, F-score and Accuracy values for any binary thresholded image, when the corresponding binary ground-truth map is present. 

### Rough-set functions
* `indisc_att.m` Partitions the decision table based on indiscernibility of the attributes.

### Reproducibility
In order to reproduce the figures and tables in the associated manuscript, please run the following scripts. The scripts: `Fig2.m`, `Fig3.m`, `Table2.m`, `Table3.m` and `Fig4.m` generates the various figures and tables of the manuscript. 

## Illustrative example to explain the various rough-set terminologies and definitions.
Please run the script `roughSetIllustration.m` for the illustrative example.
 
