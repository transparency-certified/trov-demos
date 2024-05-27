# TROV Demonstration

This repository demonstrates the _Transparent Research Object Vocabulary_ (__TROV__) for describing _Transparent Research Objects_ (__TROs__) and the _Transparent Research Systems_ (__TRS__'s) that produce them.

This repository is itself structured as a _Reproducible Every-Place Research Object_ (__REPRO__). It is associated with a public Docker image that aims to enable the the products of the demonstration to be reproduced at a Unix-like shell prompt on any computer that has Git, GNU Make, and Docker installed.

The demo is associated with a public Docker image, which enables the examples to be reproduced on any operating system that has Git, Docker, GNU Make, and Graphviz installed. Make commands issued in the top-level directory of the demo repository enable pulling Docker image from Docker Hub (`pull-image`), building the Docker image locally (`build-image`), running all demonstrations in the demo folder (`run-demo`), deleting all artifacts created by these demonstrations (`clean-demo`), starting an interactive session (`start-repro`), and exiting current session (`exit`). Before running these demonstrations, related Python packages such as Geist and Pandas should be installed within an interactive session. To run and confirm the reproducibility of these demonstrations, issuing the commands `make clean-demo` and `make run-demo`, then confirming the products have been restored by git status. Furthermore, an individual example within these demonstrations can be run by starting an interactive session and running `make` under a particular example directory. Similarly, all artifacts created by this example will be deleted after running `make clean` under the same example directory.

## Setup the environment

First pull the parent image from Docker Hub using the `make pull-parent` command and build this REPRO's Docker image using the `make build-image` command.

Then start the REPRO in interactive mode using the `make start-repro` command (or the shorthand `make start`).

Next, install the related Python packages using the `pip install .` command.

Finally, exit the REPRO using the `exit` command.

## Run and confirm the reproducibility of the demonstration

The demonstration and its products are stored in the `demo` directory tree:
```
trov-demos$ tree demo
demo
|-- 01-vocab
|   |-- Makefile
|   |-- products
|   |   |-- img.gv
|   |   |-- img.svg
|   |   `-- report_subclass.html
|   |-- run.sh
|   |-- run.txt
|   `-- templates.geist
|-- 02-tro-examples
|   |-- 01-two-artifacts-no-trp
|   |   |-- Makefile
|   |   |-- products
|   |   |-- run.sh
|   |   |-- run.txt
|   |   |-- tro
|   |   |   |-- file1
.
. (additional output removed for brevity)
.
|-- 03-validate-tro-declaration
|   |-- Makefile
|   |-- data
|   |   |-- mappings.json
|   |   |-- tro.schema.ttl
|   |   |-- tro1.jsonld
|   |   |-- tro2.jsonld
|   |   |-- tro3.jsonld
|   |   |-- tro4.jsonld
|   |   `-- tro5.jsonld
|   |-- products
|   |   |-- tro1.html
|   |   |-- tro2.html
|   |   |-- tro3.html
|   |   |-- tro4.html
|   |   `-- tro5.html
|   |-- run.sh
|   `-- run.txt
`-- Makefile
```

Below gives a brief description of these demonstrations:
- __01-vocab__: query the _Transparent Research Object Vocabulary_ (__TROV__) and visualize the subclass relationship (check [report](https://transparency-certified.github.io/trov-demos/demo/01-vocab/products/report_subclass.html)).
- __02-tro-examples__: query three _Transparent Research Objects_ (__TROs__), _01-two-artifacts-no-trp_, _02-three-artifacts-one-trp_, and _03-skope-lbda-processing_ (check [TRO report](https://transparency-certified.github.io/trov-demos/demo/02-tro-examples/03-skope-lbda-processing/products/report.html)).
- __03-validate-tro-declaration__ demonstrates how a TRO declaration can be validated through 5 examples.

To establish that the demonstrations can be reproduced, first use the `make clean-demo` command to delete the files produced by the demo:
```
trov-demos$ make clean-demo
------- Cleaning example 01-vocab/ ----------------
removed './run.txt'
removed './products/img.gv'
removed './products/img.svg'
removed './products/report_subclass.html'
rmdir: removing directory, './products'

------- Cleaning example 02-tro-examples/ ----------------

------- Cleaning example 01-two-artifacts-no-trp/ ----------------
removed './run.txt'
.
. (additional output removed for brevity)
.
------- Cleaning example 03-validate-tro-declaration/ ----------------
removed './run.txt'
removed './products/tro1.html'
removed './products/tro2.html'
removed './products/tro3.html'
removed './products/tro4.html'
removed './products/tro5.html'
rmdir: removing directory, './products'
```

Confirm with `git status` that version-controlled files have been deleted locally:
```
trov-demos$ git status
On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    demo/01-vocab/products/img.gv
        deleted:    demo/01-vocab/products/img.svg
        deleted:    demo/01-vocab/products/report_subclass.html
        deleted:    demo/01-vocab/run.txt
        deleted:    demo/02-tro-examples/01-two-artifacts-no-trp/run.txt
        .
        . (additional output removed for brevity)
        .
        deleted:    demo/05-validate-tro-declaration/products/tro5.html
        deleted:    demo/05-validate-tro-declaration/run.txt

no changes added to commit (use "git add" and/or "git commit -a")
```

Now run the demonstration with the `make run-demo` command:
```
trov-demos$ make run-demo
---------- Running example 01-vocab/ -------------

---------- Running example 02-tro-examples/ -------------

---------- Running example 01-two-artifacts-no-trp/ -------------
.
. (additional output removed for brevity)
.
---------- Running example 03-validate-tro-declaration/ -------------
```

Finally, use `git status` to confirm that the demostration products have been restored:

```
trov-demos$ git status
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

## Running a single example

An individual example within the demonstration can be run by starting an interactive REPRO session.

First start the REPRO in interactive mode using the `make start-repro` command (or the shorthand `make start`).
```
trov-demos$ make start-repro
repro@a6c7a4e443a8:/mnt/trov-demos$
```

Set the working directory to a particular example directory:
```
repro@a6c7a4e443a8:/mnt/trov-demos$ cd demo/01-vocab/
repro@a6c7a4e443a8:/mnt/trov-demos/demo/01-vocab$

repro@a6c7a4e443a8:/mnt/trov-demos/demo/01-vocab$ pwd
/mnt/trov-demos/demo/01-vocab
```

Type `make` to run the example:
```
repro@a6c7a4e443a8:/mnt/trov-demos/demo/01-vocab$ make
bash run.sh > run.txt
```

Use the `tree` command to list the files associated with the example, including the temporary files in the `tmp` subdirectory:

```
repro@a6c7a4e443a8:/mnt/trov-demos/demo/01-vocab$ tree
.
|-- Makefile
|-- products
|   |-- img.gv
|   |-- img.svg
|   `-- report_subclass.html
|-- run.sh
|-- run.txt
|-- templates.geist
`-- tmp
    |-- query subclass vocab.sh
    |-- query subclass vocab.txt
    |-- load trov vocabulary without inferences.sh
    `-- load trov vocabulary without inferences.txt

2 directories, 11 files
```

The `make clean` command deletes the temporary files, the example output file, `run.txt`, and the products folder:
```
repro@a6c7a4e443a8:/mnt/trov-demos/demo/01-vocab$ make clean
if [[ -f ./"run.txt" ]] ; then                       \
    rm -v ./"run.txt" ;                              \
fi
removed './run.txt'
if [[ -d ./"tmp" ]] ; then                              \
    rm -vf ./"tmp"/* ;                            \
    rmdir -v ./"tmp" ;                            \
fi
removed './tmp/query subclass vocab.sh'
removed './tmp/query subclass vocab.txt'
removed './tmp/load trov vocabulary without inferences.sh'
removed './tmp/load trov vocabulary without inferences.txt'
rmdir: removing directory, './tmp'
if [[ -d ./"products" ]] ; then                       \
    rm -vf ./"products"/* ;                           \
    rmdir -v ./"products" ;                           \
fi
removed './products/img.gv'
removed './products/img.svg'
removed './products/report_subclass.html'
rmdir: removing directory, './products'

repro@a6c7a4e443a8:/mnt/trov-demos/demo/01-vocab$ tree
.
|-- Makefile
|-- run.sh
`-- templates.geist

0 directories, 3 files
```

Confirm that the `run.txt` file and the `products` folder are the version-controlled files associated with this example that has been deleted:
```
repro@a6c7a4e443a8:/mnt/trov-demos/demo/01-vocab$ git status .
On branch idcc24
Your branch is up to date with 'origin/idcc24'.

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    products/img.gv
        deleted:    products/img.svg
        deleted:    products/report_subclass.html
        deleted:    run.txt

no changes added to commit (use "git add" and/or "git commit -a")
```

Re-run this example and confirm the `run.txt` file and the `products` folder were restored:
```
repro@a6c7a4e443a8:/mnt/trov-demos/demo/01-vocab$ make
bash run.sh > run.txt

repro@a6c7a4e443a8:/mnt/trov-demos/demo/01-vocab$ git status .
On branch idcc24
Your branch is up to date with 'origin/idcc24'.

nothing to commit, working tree clean

```
