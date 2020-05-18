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