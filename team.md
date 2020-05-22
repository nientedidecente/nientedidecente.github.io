---
layout: page
title: Team
permalink: /team/
---

{% assign sorted = site.authors | sort: 'name' %}
| Name | Role  | Github | Discord | Reddit |
| :--- | :---: | :----: | :-----: | :----: |
{% for p in sorted -%}
{%- capture el -%}
  | {% if p.name %}    [{{ p.name }}]({{ p.url }}) {% endif %}
  | {% if p.role %}    {{ p.role }} {% endif %}
  | {% if p.github %}  [{{ p.github }}](https://www.github.com/{{p.github}}) {% endif %}
  | {% if p.discord %} @{{ p.discord }} {% endif %}
  | {% if p.reddit %}  [/u/{{ p.reddit }}](https://www.reddit.com/user/{{p.reddit}}) {% endif %}
{%- endcapture -%}
{{ el | strip_newlines}}
{% endfor -%}