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
- [Slackware Installation](#slackware-installation)
- [Basic Usage](#basic-usage)
- [Custom Header and Footer](#custom-header-and-footer)
- [Force Publishing](#force-publishing)
- [Build and Publish Single Post](#build-and-publish-single-post)
- [To-do](#to-do)
- [License](#license)

## About

Bourne to Blog is a bash script to create blog posts from `.md` files in a simple manner.

You can take a look at this [blog](https://nixing.mx/blog/update-to-my-blogging-workflow.html) post for additional information on my motivation to create this tool

## Demo

You can take a look at my [blog](https://nixing.mx/blog/blog.html) for a sample of what type of blog posts will be produced by using Bourne to Blog.

You can also take a look at other's blogs created with Bourne to Blog [here](https://github.com/grokkingnix/bourne-to-blog/blob/master/samples/sample-blogs.md).

## Features

Bourne to Blog is meant to be simple and easy to use, at the moment there are only two features implemented:

1. Convert / Build blog posts from Markdown files
2. Publish blog posts to a public web server via SFTP

A third feature is currently being developed

- Build and publish RSS feed

## How it Works

Bourne to Blog is designed to be installed on a common-access computer (laptop / desktop) with access to a public web server over SFTP (Internet).

The expected workflow is the following:

![Bourne to Blog Workflow](samples/img/bourne-to-blog-workflow.png "Diagram showing the expected bourne to blog workflow")

## Requirements

- A Bash CLI environment (Not yet tested on other shell environments but I believe it should work as well)
- The [discount](https://github.com/nueh/discount) markdown to html conversion tool
- Internet access (Only for publishing)
- An existing STFP capable public web server (Only for publishing)

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

### Slackware Installation

1. `su - root` 
2. `wget https://raw.githubusercontent.com/grokkingnix/bourne-to-blog/master/blog -P /usr/local/bin/`
3. `chown YOUR_USER:YOUR_USER_GROUP /usr/local/bin/blog` i.e. `chown username:groupname /usr/local/bin/blog`
4. `chmod +x /usr/local/bin/blog`
5. `vim /usr/local/bin/blog`

## Basic Usage

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

## Custom Header and Footer

Additionally to the preset header and footer files that you configure, you can also specify the header and footer file on the fly for your posts. This feature can be beneficial when creating different type of posts within your blog, or using Bourne to Blog to build different blogs from the same system.

To specify the header file you can use the `-h` flag with the path to your file as an argument, i.e.:

    $ blog -bh /home/user/header-file
    
To specify the footer file you can use the `-f` flag with the path to your file as an argument, i.e.:

    $ blog -bf /home/user/footer-file
    
To specify both the header and footer file:

    $ blog -bh /home/user/header-file -f /home/user/footer-file
    
## Force Publishing

By default Bourne to Blog does not overwrite the posts that already exist on your public SFTP server when using the `-p` flag. This avoids re-publishing posts and ultimately saves bandwidth.

In case you'd like to force all built posts to be published to your public SFTP server regardless of whether those posts already exist or not, you can use the `-z` option, i.e.:

    $ blog -bz

## Build and Publish Single Post

By default when you build and publish posts Bourne to Blog will do this in batches. So if you have several articles you can simply run `blog -bp` and this will build all the posts and then publish all of them with this single command (This will not overwrite any of the posts that already exist in the SFTP server). 

Alternatively you can build and publish a single post by using the `-s` flag, for example: `blog -bps file.md` this will only perform the building and publishing functions on the specified file.
    
## To-do

1. Add RSS feed feature
2. ~~Add sample header file~~
3. ~~Add sample footer file~~
4. ~~Add sample CSS file~~
5. ~~Add option to build a single article~~
6. ~~Add option to publish a single article~~
7. ~~Add option to specify header and footer files to build posts with~~
8. ~~Add CSS `id` attribute o all `h2-h4` HTML tags~~
9. Add major Linux distribution installation instructions

## License

This program is libre software: You can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License version 3 for more details.
