[Dissecting Last-mile Latency Characteristics &rarr;](https://doi.org/10.1145/3155055.3155059)  
[ACM SIGCOMM Computer Communication Review &rarr;](http://www.sigcomm.org/publications/computer-communication-review)  
October 2017  

---  

### Dataset

The raw dataset is available [here &rarr;](http://doi.org/10.14459/2017mp1506300)  

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
notebook fills in entries in one table. This includes mechanics to
provision measurements on RIPE Atlas, fetch measurement results and dump
them in the database tables while also augmenting the metadata with
third-party datasets such as peeringDB and RIPE stat APIs. Once all the
tables are filled in `plot-*` can be used to reproduce results on a
different dataset.


### Contact

Please feel welcome to contact the authors for further details.

- Vaibhav Bajpai <bajpaiv@in.tum.de>  
- Steffie Jacob Eravuchira <steffie@samknows.com>  
- Jürgen Schönwälder <j.schoenwaelder@jacobs-university.de>  


