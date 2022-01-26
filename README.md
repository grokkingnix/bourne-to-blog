# Bourne to Blog 

### Table of contents

- [About](#about)
- [Demo](#demo)
- [Features](#features)
- [How it works](#how-it-works)
- [Requirements](#requirements)
- [Installation](#installation)
    - [Overall Installation Steps](#overall-installation-steps)
    - [Sample Files](#sample-files)
    - [SFTP Configuration](#sftp-configuration)
    - [Linux and OS X Installation](#linux-and-os-x-installation)
- [How to use Bourne to Blog](#how-to-use-bourne-to-blog)
    - [Basic Usage](#basic-usage)
    - [Custom Header and Footer](#custom-header-and-footer)
    - [Force Publishing](#force-publishing)
    - [Build and Publish Single Post](#build-and-publish-single-post)
    - [Build and Publish Blog Index Page](#build-and-publish-blog-index-page)
    - [Build and Publish an RSS feed](#build-and-publish-an-rss-feed)
    - [Build and Publish a sitemap](#build-and-publish-a-sitemap)
- [Modules](#modules)
    - [Use openring](#use-openring)
- [Other use cases](#other-use-cases)
    - [Create a Wiki](#create-a-wiki)
- [To-do](#to-do)

## About

Bourne to Blog is a bash script to create blog posts from `.md` files in a simple manner.

You can take a look at this [blog](https://nixing.mx/posts/update-to-my-blogging-workflow.html) post for additional information on my motivation to create this tool

## Demo

You can take a look at my [blog](https://nixing.mx/index.html) for a sample of what type of blog posts will be produced by using Bourne to Blog.

You can also take a look at others' blogs created with Bourne to Blog [here](https://github.com/grokkingnix/bourne-to-blog/blob/master/samples/sample-blogs.md).

## Features

Bourne to Blog is meant to be simple and easy to use, these are the features currently implemented:

1. Generate blog posts from Markdown files
2. Publish blog posts to a public web server via SFTP
3. Build and publish RSS feed
4. Build and publish posts page
5. Build and publish sitemap.xml


## How it Works

Bourne to Blog is designed to be installed on a common-access computer (laptop / desktop) with access to a public web server over SFTP (Internet).

The expected workflow is the following:

![Bourne to Blog Workflow](samples/img/bourne-to-blog-workflow.png "Diagram showing the expected bourne to blog workflow")

## Requirements

- A Bash CLI environment (Not yet tested on other shell environments but I believe it should work as well)
- The [discount](https://github.com/nueh/discount) markdown to html conversion tool
- Internet access (Only for publishing)
- An existing STFP capable public web server

## Installation

### Overall installation steps

1. Download only the `blog` file from the repository
2. Place it in `/usr/local/bin` directory
3. Make your local user the owner of the `/usr/local/bin/blog` file
4. Enable execution privileges to the `/usr/local/bin/blog` file
5. Edit the `/usr/local/bin/blog` file variables to fit your environment

### Sample Files

Along with the core script I have also provided some sample files (header, footer and CSS). You can find these in the `samples` folder in the repository, these provide the basics that you'll need to get started with building your blog with Bourne to Blog.

### SFTP Configuration

In order to keep Bourne to Blog as safe as possible the sftp connection uses the built in OpenSSH identity_file mechanism that should be available on any system that can invoke the SSH command. This ensures that you don't use a clear text password while using Bourne to Blog.

In case you already have a password-less public / private SSH key pair you can use that, otherwise you can generate them as follows.

Execute the following commands from your terminal:

    $ cd ~/.ssh
    $ ssh-keygen -t ed25519
    
Press the enter key when prompted for a password to leave the key pair without a password.

Copy the generated public key to your SFTP server:

    $ ssh-copy-id -i ~/.ssh/ed25519.pub ftpuser@ftp.host.com

### Linux and OS X Installation

1. Install the [discount](https://github.com/nueh/discount) library with your system's preferred method
2. Ensure that you have `/usr/local/bin/` in your `$PATH` i.e. `$ echo $PATH`
3. `su - root` 
4. `wget https://raw.githubusercontent.com/grokkingnix/bourne-to-blog/master/blog -P /usr/local/bin/`
5. `chown YOUR_USER:YOUR_USER_GROUP /usr/local/bin/blog` i.e. `chown username:groupname /usr/local/bin/blog`
6. `chmod +x /usr/local/bin/blog`
7. `vim /usr/local/bin/blog`

## How to use Bourne to Blog

Details of how to use Bourne to Blog with some examples

### Basic Usage

1. Simply create a text file using the markdown extension `.md` with your favorite text editor, for example:

```
# This is my first blog post!
 
## It was very simple to accomplish
 
This is my first blog post using `Bourne to Blog`
```

2. From the command line run the `blog -b` command to build your first blog post, at this point you can preview what your blog post will look like before publishing it publicly.

3. Once you like the way your blog post looks you can publish it to your public web server with `blog -p`.

Done! You can now visit your public web server address and check your blog post out! 

In case you have any doubts about what the different options do, you can run `blog -H` to get some help.

### Custom Header and Footer

Additionally to the preset header and footer files that you configure, you can also specify the header and footer file on the fly for your posts. This feature can be beneficial when creating different type of posts within your blog, or using Bourne to Blog to build different blogs from the same system.

To specify the header file you can use the `-h` flag with the path to your file as an argument, i.e.:

    $ blog -bh /home/user/header-file
    
To specify the footer file you can use the `-f` flag with the path to your file as an argument, i.e.:

    $ blog -bf /home/user/footer-file
    
To specify both the header and footer file:

    $ blog -bh /home/user/header-file -f /home/user/footer-file
    
### Force Publishing

By default Bourne to Blog does not overwrite the posts that already exist on your public SFTP server when using the `-p` flag. This avoids re-publishing posts and ultimately saves bandwidth.

In case you'd like to force all built posts to be published to your public SFTP server regardless of whether those posts already exist or not, you can use the `-z` option, i.e.:

    $ blog -bz

### Build and Publish Single Post

By default when you build and publish posts Bourne to Blog will do this in batches. So if you have several articles you can simply run `blog -bp` and this will build all the posts and then publish all of them with this single command (This will not overwrite any duplicate file names in the SFTP server). 

Alternatively you can build and publish a single post by using the `-s` flag, for example: `blog -bps file.md` this will only perform the building and publishing functions on the specified file.

### Build and Publish Blog Index Page

You can build and publish the blog index page with the `-m` option. Depending on your blog setup this can be thought of as your home page. Three variables need to be specified for this option to work:

1. `BLOG_MAIN`: This variable is the relative path on your web server to where your blog index page resides
2. `BLOG_DOMAIN`: This is your blog web address i.e. `https://domain.com`
3. `BLOG_INDEX`: This variable is the full path to a `.md` file that contains the introduction to your blog index page

The `-m` option will get all of the posts currently published on your website (internet access required) and create a local list, it will then build a new page from that list of posts and upload it to your public ftp server. 

This option requires for your post `.md` files to start with the following style of heading:

    # CSS Grid Navigation Bar
     
    ##### Published: 2020-08-20 | Last Updated: 2021-02-02 | ~8 Minute Read
    
This is because of how each post is parsed, the title and published date are expected to be in this specific format. If you have a different format, your index page may not be built as expected. 

For an example of how this index page will look please see [here](https://nixing.mx/index.html).

### Build and publish an RSS feed

You can use the `-r` option in order to publish an updated RSS feed of our post entries. This feature is meant to be used along with the `-m` option when publishing a new post to your blog. The RSS feed `<items>` get created based on the format that the `-m` options generates. 

Examples: 

This will build and publish a `feed.xml` file based on the contents of your blog index page:

    $ blog -r
    
### Build and publish a sitemap

You can use the `-S` option in order to publish an updated sitemap from post entries. This feature is meant to be used along with the `-m` option when publishing a new post/s to your blog. The sitemap.xml `<url>` tags get created based on the format that the `-m` options generates. 

Examples: 

This will build and publish a `sitemap.xml` file based on the contents of your blog index page:

    $ blog -S

## Modules

Bourne to Blog aims to be modular, below are some modules that have been created to add functionality to the core set of features.

### Use Openring

You can make use of [openring](https://git.sr.ht/~sircmpwn/openring) with the `-o` flag when building your posts. You need the additional `openring.sh` file from the `modules` folder. Configure the variable values and you can add the flag to your regular post build/publish workflow i.e. `blog -bops post-file.md`. You can find more details on this [post](https://nixing.mx/posts/integrating-openring-into-a-blog.html).
    
## Other use cases

Below are some additional use cases for Bourne to Blog that may be of interest to some.

### Create a Wiki

You can create your very own Wiki with Bourne to Blog, take a look at the `samples` folder for the files that can help you. You can see a detailed step by step guide [here](https://nixing.mx/posts/creating-a-wiki-with-bourne-to-blog.html)
    
## To-do

1. ~~Add sitemap.xml feature~~
1. ~~Add post title to HTML title tag~~
1. ~~Integrate openring~~
1. ~~Generate valid RFC822 date-times in the RSS feed~~
1. ~~Add visible SVG icon with link to post id tag sections~~
1. ~~Add RSS feed feature~~
1. ~~Add option to build main blog index file~~
1. ~~Add sample header file~~
1. ~~Add sample footer file~~
1. ~~Add sample CSS file~~
1. ~~Add option to build a single article~~
1. ~~Add option to publish a single article~~
1. ~~Add option to specify header and footer files to build posts with~~
1. ~~Add CSS `id` attribute o all `h2-h4` HTML tags~~
1. ~~Add major Linux distribution installation instructions~~

