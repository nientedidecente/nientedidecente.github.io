# How to contribute

In order to contribute with to this blog, you have two prerequisites:

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

`layout`, `short_name` and `name` are mandatory. Everything else is optional.

At the end of the page content, a list of your posts will be shown. This list is retrieved by your `short_name`, so be sure to put _that_ as post's `author`.

Refer to `_authors/slaierno.md` to build your own author page.

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
