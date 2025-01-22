# Interactive Sessions

Using Open OnDemand (OOD), you can start interactive sessions on a high-performance computing cluster through a browser.

See the [Yale Center for Research Computing page](https://docs.ycrc.yale.edu/clusters-at-yale/access/ood) to access this at Yale.

As part of starting an interactive session, you may need to set a few parameters, which will determine what hardware and software is available in the session, as well as the session length.

If you're starting an interactive app (such as RStudio), the first thing you may need to select is the software version.
It is generally best to select the latest version.

## Hardware

Other parameters relate to the hardware, for instance:

- **Partition**: These may have different hardware (such as CPU types, or GPUs) and different limitations (such as number of CPU cores and amount of memory).
  For instance, the Grace cluster at Yale has several partitions (listed on the [Grace page](https://docs.ycrc.yale.edu/clusters/grace/)), with `day` being appropriate in most cases.
- **CPU cores**: This will determine how many cores / threads you will be able to use, and, if memory is tied to cores, how much total memory you have available.
- **Memory**: This will determine the amount of memory / RAM you will be able to use, which will be particularly relevant if you're wanting to loading in large portions of data into memory.

The appropriate settings will depend on what you're doing, but if you run into issues (such as if things are running slowly or crashing), you might try adjusting these.

## Software

Additional software can by loaded through modules. From a terminal (e.g., accessible from Clusters > Shell Access on an OOD dashboard), you can use the `module spider` command to find specific module names.

For instance, you might need [Arrow](https://arrow.apache.org/docs/index.html), so you could search through available modules:

```sh
 module -r spider 'Arrow.*'
```
