.ONESHELL:
.DEFAULT_GOAL = help
.EXPORT_ALL_VARIABLES:

PATH := venv/bin:$(PATH)

ENV = .env.example
include $(ENV)


help:
	@ # Print help commands
	echo "Welcome to 'waka-readme-stats' GitHub Actions!"
	echo "The action can be tested locally with: 'make run-locally'."
	echo "NB! For local testing Python version 3.8+ is required."
	echo "The action build files can be cleaned with: 'make clean'."
.PHONY: help

venv:
	@ # Install Python virtual environment and dependencies
	python3 -m venv venv
	pip install --upgrade pip
	pip install -r requirements.txt


run-locally: venv
	@ # Run action locally
	mkdir ./assets/ 2>/dev/null || true
	python3 ./sources/main.py
.PHONY: run-locally


lint: venv
	@ # Run flake8 and black linters
	flake8 --max-line-length=160 --exclude venv,assets .
	black --line-length=160 --exclude='/venv/|/assets/' .
.PHONY: lint

clean:
	@ # Clean all build files, including: libraries and package manager configs
	rm -rf venv
	rm -rf repo
	rm -rf assets
	rm -f package*.json
.PHONY: clean
