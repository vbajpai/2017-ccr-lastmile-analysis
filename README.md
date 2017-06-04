Dissecting Last-mile Latency Characteristics  
[ACM SIGCOMM Computer Communication Review &rarr;](http://www.sigcomm.org/publications/computer-communication-review)  
XXX 2017 (to appear)  

---  

### Dataset

The raw dataset is available [here
&rarr;](http://cnds.eecs.jacobs-university.de/users/vbajpai/lm-ccr-2017/)  
It includes the SQL schema `lastmile.sql` and the dataset in sqlite3
format `lastmile.db`

### Installation

`make` will install the python dependencies required to run the jupyter
notebooks. `make run` will run jupyter.


### Repeating the results

`plot-*` notebooks can be used to repeat the analysis on the existing
dataset. Each such notebook produces a single plot in the paper.


### Reproducing the results

`make db` will bootstrap a new database using the `lastmile.sql` schema.
`db-insert-*` notebooks can be used to fill in the dataset. Each such
notebook fills in entries in one table. Once all the tables are filled
in `plot-*` can be used to reproduce results on a different dataset.


### Contact

Please feel welcome to contact the authors for further details.

- Vaibhav Bajpai <bajpaiv@in.tum.de>  
- Steffie Jacob Eravuchira <s.eravuchira@jacobs-university.de>  
- Jürgen Schönwälder <j.schoenwaelder@jacobs-university.de>  


