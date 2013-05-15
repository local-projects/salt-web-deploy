include:
  - user-group-folders

python:
  pkg:
    - installed

supervisor:
  pkg:
    - installed
    - require:
      - pkg: python

supervisor_conf:
  file.managed:
    - name: /etc/supervisor/supervisord.conf
    - source: salt://files/supervisor/supervisord.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: supervisor

{% for site, args in pillar["websites"].iteritems() %}

supervisor_{{ args['site_identifier'] }}_task_config:
  file.managed:
    - name: /etc/supervisor/conf.d/{{ args['site_identifier'] }}_uwsgi_task.conf
    - source: salt://files/supervisor/conf.d/uwsgi_task.conf
    - template: jinja
    - context:
      site_identifier: {{ args['site_identifier'] }}
      user: {{ args['user'] }}
      group: {{ args['group'] }}
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: supervisor

supervisor_{{ args['site_identifier'] }}_task:
  supervisord:
    - name: {{ args['site_identifier'] }}_task
    - running
    - restart: False
    - require:
      - file: supervisor_{{ args['site_identifier'] }}_task_config

{% endfor %}