make:
	pip install -r requirements.txt

update:
	pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | \
	xargs pip install -U

db:
	sqlite3 lastmile.db < lastmile.sql

run:
	jupyter notebook

pull:
	git submodule foreach git pull origin master
	git pull
