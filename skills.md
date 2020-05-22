---
title: Skills
---

{%- assign langs_framework_misc = "langs,frameworks,misc" | split: "," -%}
{%- assign self_want = "self,want" | split: "," -%}

{% for stype in langs_framework_misc -%}

<h1> {{ site.data.skillset["titles"][stype] }} </h1>

    {%- for skill_ in site.data.skillset[stype] -%}
        {%- assign skill_name = skill_[0] -%} {%- comment -%} skill name we are searching for {%- endcomment -%}
        {%- assign skill = skill_[1] -%} {%- comment -%} possible skill-related skills {%- endcomment -%}

        {%- comment -%} Search if there is at least an author holding skills for this skill
                        and continues to next skill if there is no one {%- endcomment -%}
        {%- assign skill_found = false -%}
        {%- for author in site.authors -%}
            {%- for a_skill in author[stype] -%}
                {%- if a_skill.name == skill_name -%}
                    {%- assign skill_found = a_skill -%}
                    {%- break -%}
                {%- endif -%}
            {%- endfor -%}
        {%- endfor -%}
        {%- unless skill_found -%}
            {%- continue -%}
        {%- endunless -%}

        <h2> {{ skill.name }} </h2>

        {%- comment -%} The number of possible versions will determine rowspan and colspan {%- endcomment -%}
        {%- assign ver_cnt = skill.vers.size -%}
        {%- if ver_cnt > 1 -%}
        {%- assign rspan = 2 -%}
        {%- assign cspan = ver_cnt -%}
        {%- else -%}
        {%- assign rspan = 1 -%}
        {%- assign cspan = 1 -%}
        {%- endif -%}

        <table>
            <tr>
                <th rowspan="{{rspan}}"> Person </th>
                <th colspan="{{cspan}}"> Self </th>
                <th colspan="{{cspan}}"> Want </th>
            </tr>
        {%- comment -%} If there are more versions, print a column for each one {%- endcomment -%}
        {%- if ver_cnt > 1 -%}
            <tr>
            {%- for type in self_want -%}
                {%- for ver in skill.vers -%}
                    <th> {{ver}} </th>
                {%- endfor -%}
            {%- endfor -%}
            </tr>
        {%- endif -%}

            {%- for author in site.authors -%}

                {%- comment -%} Check if skill_name is found inside the author skill list, continue otherwise {%- endcomment -%}
                {%- assign skill_found = false -%}
                {%- for a_skill in author[stype] -%}
                    {%- if a_skill.name == skill_name -%}
                        {%- assign skill_found = a_skill -%}
                        {%- break -%}
                    {%- endif -%}
                {%- endfor -%}
                {%- unless skill_found -%}
                    {%- continue -%}
                {%- endunless -%}

                <tr>
                    <td><a href="{{author.url}}">{{author.name}}</a></td>
                {%- for type in self_want -%}
                    {%- if skill.vers -%}
                        {%- for ver in skill.vers -%}
                            {%- assign score = 0 -%}

{%- comment -%} returns score for matching (skill_name, ver). If no matching version is available but
                there is a versionless entry, such score will be used {%- endcomment -%}
                            {%- assign skill_list = author[stype] -%}
                            {%- assign skill_found = false -%}
                            {%- assign skill_found_generic = false -%}
                            {%- for a_skill in skill_list -%}
                                {%- if a_skill.name == skill_name -%}
                                    {% if a_skill.ver%}
                                        {%- for a_ver in a_skill.ver -%}
                                            {%- if a_ver == ver -%}
                                                {%- assign skill_found = a_skill -%}
                                                {%- break -%}
                                            {%- endif -%}
                                        {%- endfor -%}
                                    {%- else -%}
                                        {%- assign skill_found_generic = a_skill -%}
                                    {%- endif -%}
                                {%- endif -%}
                                {%- if skill_found -%}
                                    {%- break -%}
                                {%- endif -%}
                            {%- endfor -%}
                            {%- if skill_found or skill_found_generic -%}
                                {%- unless skill_found -%}
                                    {%- assign skill_found = skill_found_generic -%}
                                {%- endunless -%}
                                {%- assign score = skill_found[type] -%}
                            {%- endif -%}
                            <td>{%- if score > 0 -%} {{score}} {%- endif -%}</td>
                        {%- endfor -%}
                    {%- else -%}
                        {%- assign score = skill_found[type] -%}
                        <td>{%- if score > 0 -%} {{score}} {%- endif -%}</td>
                    {%- endif -%}
                {%- endfor -%}
                </tr>
            {%- endfor -%}
        </table>

    {%-endfor-%}
------
------
{%endfor%}
