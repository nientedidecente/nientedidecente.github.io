[NDD.github.io](https://nientedidecente.github.io)


# How to contribute

In order to contribute to this blog, there are two prerequisites:

1. Create an author page
2. Write a post

## Create an author page

Every team member should have an author page. But every blog contributor _shall_ have one.

An author page is just a markdown file put into `_authors` with a YAML frontmatter and a content:

```yaml
---
layout: author
short_name: tdoe
name: Ted Doe
role: Writer
github: tdoe
discord: tdoe#123
reddit: teddoe
langs:
  - name: cpp
    ver: [11,14]
    self: 2
    want: 3
frameworks:
  - name: godot
    want: 2
misc:
  - name: 3D
    self: 1
    want: 2
---

Content of my personal page in _markdown_ **syntax**
```

* `layout`: mandatory to be set to `author`
* `short_name`: a short name to use in the `author` field of a post
* `name`: your name
* `role`: your role
* `github`: your github handle
* `discord`: your discord username
* `reddit`: your reddit username
* `langs`, `frameworks` and `misc`: your skills, refer to the next section.

`layout`, `short_name` and `name` are mandatory. Everything else is optional. Note that in case of **multilanguage author pages**, only these three mandatory variables and the language-specific ones (`lang` and `lang-ref`) are necessary. Everything else will be retrieved from the default-language (i.e. Italian) author page.  
At the end of the page content, a skill table and a list of your posts will be shown. The skill table is compiled with the skills in your YAML frontmatter. The post list is retrieved by your `short_name`, so be sure to put _that_ as post's `author`.

Refer to `_authors/slaierno.md` as an example to build your own author page.

### `langs`, `frameworks` and `misc`

Each one of such variables works like the other. We will refer to `langs` with this in mind.

* `name` short name of the skill. Those names can be found in `_data/skillset.yml`
* `ver` optional list of versions. Available versions can be found in `_data/skillset.yml`
* `self` how much an author is capable in a skill. Points go from 0 to 3, default (if absent) is 0
* `want` how much an author is want to learn a  skill. Points go from 0 to 3, default (if absent) is 0

Remember to put each skill in the correct category (`langs`, `frameworks`, `misc`) as defined in `_data/skillset.yml`.

For each skill, multiple entries can be put if they refer to different versions. If a version-less entry is put, this values will be used as default for every non-specified value. E.g.

```yaml
langs:
  - name: cpp
    ver: [11,14]
    self: 2
    want: 3
  - name: cpp
    self: 1
    want: 2
```
Means that the author has S/W=(2,3) for C++11 and C++14 and S/W=(1,2) for the other available versions (98, 17, 20).  
Beware that anytime you put a version-specific entry, such values will override the existing ones. E.g.
```yaml
langs:
  - name: cpp
    ver: [11,14]
    want: 3
  - name: cpp
    self: 1
    want: 2
```
The first entry specifies versions 11 and 14, but since `self` is skipped, 0 will be assumed and the author will find a skillset like:

| S98 | S11   | S14   | S17 | S20 | W98 | W11 | W14 | W17 | W20 |
| --- | ----- | ----- | --- | --- | --- | --- | --- | --- | --- |
| 1   | **0** | **0** | 1   | 1   | 2   | 3   | 3   | 2   | 2   |

### Adding more skills

If you want to add a skill or a skill version, just update `_data/skillset.yml` and you are free to add such skill/version in your personal page.

## Create a post

Every blog post shall be put into `_posts`. Jekyll requires blog post files to be named according to the following format:

`YEAR-MONTH-DAY-title.MARKUP`

Where `YEAR` is a four-digit number, `MONTH` and `DAY` are both two-digit numbers, and `MARKUP` is the file extension representing the format used in the file. After that, include the necessary front matter. An example of front matter can be:

```yaml
---
layout: post
title:  "Welcome to Jekyll!"
date:   2020-05-18 12:42:55 +0200
categories: jekyll update
author: teddoe
---
```

If you need to use LaTeX style math notation, add {% include mathjs %} to your post, just after the front matter.
You can then add equations by enclosing them in double dollar signs, like so: $$ a + b = c $$ 

An example post where you can refer is `_posts/example.markdown`.

## Multilanguage support

The blog support multiple languages for pretty much everything. The default language is Italian, for every other language you may:
* add a subfolder (project root included) named with the language short name (refer to `_data/languages.yml)
* add to the frontmatter two variables, `lang`, indicating the languages, and `lang-ref`, representing a label for that page.

Posts will be listed on a language basis. E.g. in you english author page you will not see your non-english posts.

A user can change the language for a page (if available) via the links on the footer of such page.

NOTE: multilanguage support is tricky. If you notice anything wrong, please issue a bug!

### Adding a language

Edit `_data/languages.yml` and `_data/translations.yml` accordingly. _Remember the emojis!_

# How to set up the blog and test it by yourself?

1. Install `ruby`
2. Install Jekyll and Bundler:
    `gem install jekyll bundler`
3. Clone this repo on your local folder
4. In the repo root run
    ```
    bundle install
    bundle update
    bundle exec jekyll serve`
    ```
5. You can find the blog hosted locally at http://localhost:4000
6. Ask on the discord server if something went wrong (which seems quite likely)

# Build it on Android+Termux

```sh
pkg install ruby zlib libiconv libxml2 libxslt pkg-config
gem install bundle jekyll pkg-config
git clone <this-repo>
cd nientedidecente.github.io
bundle install
bundle update
bundle exec jekyll serve
```

If it triggers an error like:

```sh
         2: from /data/data/com.termux/files/usr/lib/ruby/gems/2.7.0/gems/jekyll-3.8.5/lib/jekyll/utils/platforms.rb:75:in proc_version'
         1: from /data/data/com.termux/files/usr/lib/ruby/gems/2.7.0/gems/pathutil-0.16.2/lib/pathutil.rb:502:in read'
/data/data/com.termux/files/usr/lib/ruby/gems/2.7.0/gems/pathutil-0.16.2/lib/pathutil.rb:502:in `read': Permission denied @ rb_sysopen - /proc/version (Errno::EACCES)
```

modify `platforms.rb` with this command to fix it:

```
sed -i 's/rescue Errno::ENOENT/rescue Errno::ENOENT, Errno::EACCESS/' /var/lib/gems/2.7.0/gems/jekyll-3.8.5/lib/jekyll/utils/platforms.rb
```

# Run it locally with Docker

To build the docker container:
```
docker-compose up -d
```

First time it might take between 3 and 10 minutes.

Once done it will be reachable on [localhost:4000](http://localhost:4000).

To stop it
```
docker-compose stop
```
