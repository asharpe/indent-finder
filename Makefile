check:
	pep8 indent_finder.py
	pylint \
		--rcfile=/dev/null \
		--reports=no \
		--disable=bad-continuation \
		--disable=deprecated-module \
		--disable=invalid-name \
		--disable=missing-docstring \
		--disable=no-else-return \
		--disable=too-few-public-methods \
		--disable=too-many-branches \
		--disable=too-many-return-statements \
		--disable=unbalanced-tuple-unpacking \
		--disable=unpacking-non-sequence \
		indent_finder.py
	rstcheck README.rst
	scspell indent_finder.py README.rst

coverage:
	@rm -f .coverage
	@coverage run --parallel-mode run_tests.py
	@coverage run --parallel-mode \
		indent_finder.py indent_finder.py Makefile missing_file
	@coverage run --parallel-mode \
		indent_finder.py --vim-output indent_finder.py && echo
	@coverage combine
	@coverage report
	@coverage html
	@rm -f .coverage
	@python -m webbrowser -n "file://${PWD}/htmlcov/index.html"

readme:
	@restview --strict README.rst

test:
	python2.4 run_tests.py
	python3.6 run_tests.py

.PHONY: check coverage readme test
