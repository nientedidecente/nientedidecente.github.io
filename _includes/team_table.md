{% assign sorted = site.authors | where:"lang", site.defaults[0].values.lang | sort: 'name' %}
| Name | Role  | Github | Discord | Reddit |
| :--- | :---: | :----: | :-----: | :----: |
{% for p in sorted -%}
    {%- assign lang_author = site.authors | where: "short_name", p.short_name | where: "lang-ref", p.lang-ref | where: "lang", page.lang -%}
    {%- capture name_entry -%}
        {%- if lang_author.size > 0 -%}[{{p.name}}]({{lang_author[0].url}})
        {%- else -%}{{p.name}}
        {%- endif -%}
    {%- endcapture -%}
{%- capture el -%}
  | {% if p.name %}    {{ name_entry | strip_newlines}} {% endif %}
  | {% if p.role %}    {{ p.role }} {% endif %}
  | {% if p.github %}  [{{ p.github }}](https://www.github.com/{{p.github}}) {% endif %}
  | {% if p.discord %} @{{ p.discord }} {% endif %}
  | {% if p.reddit %}  [/u/{{ p.reddit }}](https://www.reddit.com/user/{{p.reddit}}) {% endif %}
{%- endcapture -%}
{{ el | strip_newlines }}
{% endfor -%}
