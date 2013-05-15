include:
  - sls.nginx
  - sls.supervisor
  - sls.git
  - sls.cbu-user-group-folders
  - sls.uwsgi
  - sls.virtualenv



{% for site, args in pillar["websites"].iteritems() %}

{{ args['site_identifier'] }}_git:
  git.latest:
    - name: {{ args['git_repo'] }}
    - rev: {{ args['git_revision'] }}
    - target: /home/{{ args['user'] }}/site/{{ args['site_identifier'] }}
    - runas: {{ args['user'] }}
    #- identity: /home/{{ args['user'] }}/git_cbu_key.rsa
    - require:
      - pkg: git

# TODO add the virtual env file
/home/{{ args['user'] }}/site/virtualenv:
  virtualenv.managed:
    - no_site_packages: True
    - requirements: /home/{{ args['user'] }}/site/{{ args['site_identifier'] }}/{{ args['requirements_file'] }}
    - require:
      - git: {{ args['site_identifier'] }}_git 
    - watch:
      - git: {{ args['site_identifier'] }}_git

{% endfor %}