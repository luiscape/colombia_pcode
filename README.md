Colombia P-codes Lists
======================

This repo has a small script that downloads a file from the national statistical office from Colombia ([DANE](http://www.dane.gov.co/Divipola/)), reads it and creates flat CSV files with each of the administrative divisions.

The advantage of using this script is that it downloads the **latest** version of the administrative boundaries from DANE's website by issuing a time-specific query. This makes it easier to always have the latest official list.


Usage
-----

Just run the `run.sh` script from the terminal:

```bash
bash run.sh
```

Output
------
The resulting files are in the [data](https://github.com/luiscape/colombia_pcode/tree/master/data) folder.
