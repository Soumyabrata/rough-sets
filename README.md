# Rough-set Based Color Channel Selection

With the spirit of reproducible research, this repository contains all the codes required to produce the results in the manuscript: S. Dev, F. M. Savoy, Y. H. Lee, S. Winkler, Rough-set Based Visible Color Channel Selection, *IEEE Geoscience and Remote Sensing Letters*, accepted, 2016. 

Please cite the above paper if you intend to use whole/part of the code. This code is only for academic and research purposes.

## Manuscript
The preprint version of this manuscript is `preprint.PDF`. 

## Code Organization
All codes are written in MATLAB. 

This entire repository is structured as follows. The folder `helperScripts` contains all the helper functions necessary for various tasks, the folder `preComputed` contains a few pre-computed results for reproducible purposes, and the folder `roughSetScripts` contains all the rough-set related scripts that can be used in any contexts.

### Dataset
The dataset used in this manuscript is HYTA dataset from Li et. al, A Hybrid Thresholding Algorithm for Cloud Detection on Ground-Based Color Images, *Journal of Atmospheric and Oceanic Technology*, 2011. Please contact the respective authors for the dataset.

### Helper functions
* `accuracy.m` Calculates the Precision, Recall, F-score and Accuracy values for any binary thresholded image, when the corresponding binary ground-truth map is present. 
* `color16_struct.m` Generates the 16 different color channels for a sample image. The results are stored in a structure array.
* `generate_KL.m` Generates the KL divergence values for HYTA images.
* `generate_LF.m` Generates the Loading Factors for HYTA images.
* `generate_ROC.m` Generates the ROC values for HYTA images.
* `generate_SVMresults.m` Generates the SVM results for the 16 color channels.
* `normalize.m` Normalizes any given array.
* `RGBPlane.m` Outputs the Red, Green, and Blue plane of a sample image.
* `showasImage.m` Normalizes any given matrix in range [0,255] such that it can be visualizes as an image.

### Rough-set functions
* `indisc_att.m` Partitions the decision table based on indiscernibility of the attributes.
* `positive_region.m` Generates the positive region for an attribute and its gamma-value.

### Reproducibility
In order to reproduce the figures and tables in the associated manuscript, please run the following scripts. The scripts: `Fig2.m`, `Fig3.m`, `Table2.m`, `Table3.m` and `Fig4.m` generates the various figures and tables of the manuscript. 

## Illustrative example to explain the various rough-set terminologies and definitions.
Please run the script `roughSetIllustration.m` for the illustrative example.

Suppose there are 7 observations viz. x<sub>1</sub>, x<sub>2</sub>, x<sub>3</sub>, x<sub>4</sub>, x<sub>5</sub>, x<sub>6</sub> and x<sub>7</sub>. Each observation has two conditional attributes: AGE and LEMS, and one decision attribute: WALK. The AGE indicates the age of the observation, and LEMS indicate Lower Extremity Motor Score of the observation (a higher LEMS value is conducive for walking). The decision attribute WALK is binary in nature: 1 indicates TRUE and 0 indicates FALSE - it indicates whether the person is able to walk or not.

In this illustration, we will walk through the various common terminologies used in rough set theory. 

Let the decision table be as follows:

|               	| AGE 	| LEMS 	| WALK 	|
|:-------------:	|:---:	|:----:	|:----:	|
| x<sub>1</sub> 	|  16 	|  50  	|   1  	|
| x<sub>2</sub> 	|  16 	|   0  	|   0  	|
| x<sub>3</sub> 	|  31 	|   1  	|   0  	|
| x<sub>4</sub> 	|  31 	|   1  	|   1  	|
| x<sub>5</sub> 	|  46 	|  26  	|   0  	|
| x<sub>6</sub> 	|  16 	|  26  	|   1  	|
| x<sub>7</sub> 	|  46 	|  26  	|   0  	|

For example, the partition created by indiscernibility of the first attribute (AGE) is executed via `[IND_att1] =  indisc_att(dec_table , 1);` (described in `roughSetIllustration.m`). Here, `dec_table` is the matrix representing the decision table, and `1` indicates the column number of the particular conditional attribute.

The generated output is as follows:
```
The partitions created by AGE attribute is:
   [3x1 double]
   [2x1 double]
   [2x1 double]  
   
```
The individual double vectors indicates the various partitions generated using AGE attribute, viz. [x<sub>1</sub>,x<sub>2</sub>,x<sub>6</sub>], [x<sub>3</sub>,x<sub>4</sub>] and [x<sub>5</sub>,x<sub>7</sub>].   

Moreover, we can also compute the dependence value of an attribute with respect to the decision attribute. It is executed via `[POS_att , gamma_att] =  positive_region(dec_table , 1 , 3);` (described in `roughSetIllustration.m`). Here, `1` indicates the column number of the particular conditional attribute, and `3` indicates the column number of the decision attribute. 

The generated output is as follows:
```
The observations that fall under positive region are:
   5
   7
The dependence value of the queried attribute w.r.t. decision attribute is:
   0.2857
   
```
This indicates the observations x<sub>5</sub> and x<sub>7</sub>, and the corresponding dependence value of AGE attribute w.r.t. WALK attribute is 0.28.
