{% for site, args in pillar["websites"].iteritems() %}

{{ args['group'] }}-group:
  group.present:
    - name: {{ args['group'] }}

{{ args['user'] }}-user:
  user.present:
  - name: {{ args['user'] }}
  - fullname: {{ args['user'] }} user
  - shell: /bin/bash
  - home: /home/{{ args['user'] }}
  - groups:
    - {{ args['group'] }}
  - require:
    - group: {{ args['group'] }}-group

{{ args['user'] }}-log-dir:
  file:
    - name: 
      - /home/{{ args['user'] }}/log
    - directory
    - mode: 770
    - user: {{ args['user'] }}
    - group: {{ args['group'] }}

{{ args['user'] }}-log-sub-dirs:
  file:
    - names: 
      - /home/{{ args['user'] }}/log/nginx
      - /home/{{ args['user'] }}/log/uwsgi
    - directory
    - mode: 770
    - user: {{ args['user'] }}
    - group: {{ args['group'] }}
    - require:
      - file: {{ args['user'] }}-log-dir

{{ args['user'] }}-site-dir:
  file:
    - name: /home/{{ args['user'] }}/site
    - directory
    - mode: 740
    - user: {{ args['user'] }}
    - group: {{ args['group'] }}

{{ args['user'] }}-run-dir:
  file:
    - name: /home/{{ args['user'] }}/run
    - directory
    - mode: 770
    - user: {{ args['user'] }}
    - group: {{ args['group'] }}

{% endfor %}
