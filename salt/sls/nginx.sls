include:
  - sls.user-group-folders

nginx:
  pkg:
    - installed
  service:
    - running

{% for site, args in pillar["websites"].iteritems() %}

nginx_site_config:
  file.managed:
    - name: /etc/nginx/sites-enabled/{{ args['site_identifier'] }}
    - source: salt://files/nginx/nginx-server-entry
    - template: jinja
    - context:
      server_name: {{ args['server_name'] }}
      user: {{ args['user'] }}
      site_identifier: {{ args['site_identifier'] }}
      uwsgi_module: {{ args['uwsgi_module'] }}
      uwsgi_callable: {{ args['uwsgi_callable'] }}
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx

nginx_rotate_config:
  file.managed:
    - name: /etc/logrotate.d/{{ args['site_identifier'] }}-nginx
    - source: salt://files/rotate/nginx-rotate
    - template: jinja
    - context:
      user: {{ args['user'] }}
      group: {{ args['group'] }}
    - user: root
    - group: root
    - mode: 644

{% endfor %}
