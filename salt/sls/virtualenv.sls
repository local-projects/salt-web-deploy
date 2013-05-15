python:
  pkg:
    - installed

python-pip:
  pkg:
    - installed
    - require:
      - pkg: python

python-virtualenv:
  pkg:
    - installed
    - require:
      - pkg: python-pip   
