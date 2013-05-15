include:
  - sls.python
  - sls.user-group-folders

uwsgi:
  pkg:
    - installed
    - require:
      - pkg: python


{% for site, args in pillar["websites"].iteritems() %}

{{ args['site_identifier'] }}_uwsgi_rotate_config:
  file.managed:
    - name: /etc/logrotate.d/{{ args['site_identifier'] }}-uwsgi
    - source: salt://files/rotate/uwsgi-rotate
    - template: jinja
    - contect:
      user: {{ args['user'] }}
      group: {{ args['group'] }}
    - user: root
    - group: root
    - mode: 644

{% endfor %}
