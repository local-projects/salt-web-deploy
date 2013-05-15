uwsgi:
  pkg:
    - installed
    - require:
      - pkg: python


{% for site, args in pillar["files"].iteritems() %}

{{ args['site_identifier]' }}_uwsgi_rotate_config:
  file.managed:
    - name: /etc/logrotate.d/args['site_identifier_' }}-uwsgi
    - source: salt://files/rotate/uwsgi-rotate
    - template: jinja
    - contect:
      user: {{ args['user'] }}
      group: {{ args['group'] }}
    - user: root
    - group: root
    - mode: 644

{% endfor %}
