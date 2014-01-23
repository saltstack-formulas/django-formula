iptables:
  pkg:
    - installed

# Set the index so we can try to insert this at the right offset
{% set ipt_idx = salt['cmd.run']('iptables -L INPUT --line-numbers -n | grep ACCEPT | grep "tcp dpt:22" | awk "{print \$1}"') %}
{% set ipt_idx = ipt_idx if ipt_idx else '0' %}

iptables -I INPUT {{ ipt_idx }} -p tcp --dport 80 -m state --state NEW -j ACCEPT:
  cmd:
    - run
    - unless: 'iptables -L INPUT -n | grep ACCEPT | grep "tcp dpt:80"'
    - require:
      - pkg: iptables
