
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Authors

Denis Valle, Carlos Silva, Marcos Longo, Paulo Brando

<!-- badges: start -->
<!-- badges: end -->

# Goal

The goal of this repository is store the scripts that were used for the
article “The Latent Dirichlet Allocation model applied to airborne LiDAR
data: a case study on mapping forest degradation associated with
fragmentation and fire in the Amazon region”.

This repository is organized in multiple thematic folders, each of which
may contain a variety of types of files. For example, most folders
contain scripts, results (e.g., csv files), and figures. These folders
are described below:

-   CHM: this folder stores all scripts, results, and figures related to
    the Canopy Height Model (CHM) comparison.
-   comparison field: this folder stores all scripts, results, and
    figures related to the comparison between tree inventory data and
    LidarLDA results.
-   derived 2014: this folder stores the main scripts, results, and
    figures derived from summarizing the LidarLDA results for the 2014
    LiDAR data.
-   derived 2018: this folder stores the main scripts, results, and
    figures derived from summarizing the LidarLDA results for the 2018
    LiDAR data.
-   edited data: this folder contains the LiDAR data for 2014 and 2018.
    These data have already been edited so that they are ready to be
    analyzed using LidarLDA.
-   GIS TAN: this folder contains shapefiles that were used to create
    some of our maps.
-   grass: this folder stores all the scripts, results, and figures
    related to the comparison between the grass invasion assessed in the
    field and the near surface cluster.
-   results 2014: this folder contains the output from LidarLDA based on
    the 2014 LiDAR data set.
-   results 2018: this folder contains the output from LidarLDA based on
    the 2018 LiDAR data set.
-   simplex: this folder contains the scripts, results, and figures
    associated with the barycentric coordinates figure.
-   simul: this folder contains the scripts, results, and figures for
    the simulated datasets. Within this folder, there are 3 folders:
    -   fake data: stores all scripts used to generate the simulated
        datasets together with the corresponding datasets.
    -   results: stores all the output from running LidarLDA on the
        simulated datasets.
    -   derived: stores all the scripts, results, and figures derived
        from LidarLDA results as well as the hierarchical clustering
        method.

Because some analyses may require the use of a series of scripts, we
have included a power point file in some of these folders that
schematically represents the order in which these scripts should be run,
their outputs, and their dependencies.
