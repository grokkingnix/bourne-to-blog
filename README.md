# Bourne to Blog 

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

## Requirements

- A Bash CLI environment (Not yet tested on other shell environments but I believe it should work as well)
- The [discount](https://github.com/nueh/discount) markdown to html conversion tool
- An existing STFP capable public web server

## Installation

### Overall installation steps

1. Download only the `blog` file from the repository
2. Place it in `/usr/local/bin` directory
3. Make your local user the owner of the `/usr/local/bin/blog` file
4. Enable execution privileges to the `/usr/local/bin/blog` file
5. Edit the `/usr/local/bin/blog` file variables to fit your environment

### Slackware Installation

1. `su - root` 
2. `wget https://github.com/grokkingnix/bourne-to-blog/blob/master/blog -P /usr/local/bin/`
3. `chown YOUR_USER:YOUR_USER_GROUP /usr/local/bin/blog` i.e. `chown username:groupname /usr/local/bin/blog`
4. `chmod +x /usr/local/bin/blog`
5. `vim /usr/local/bin/blog`

## Usage

1. Simply create a text file using the markdown extension `.md` with your favorite text editor, for example:

```
# This is my first blog post!
 
## It was very simple to accomplish
 
This is my first blog post using `Bourne to Blog`
```

2. From the command line run the `blog -b` command to build your first blog post, at this point you can preview what your blog post will look like before publishing it publicly.

3. Once you like the way your blog post looks you can publish it to your public web server with `blog -p`.

Done! You can now visit your public web server address and check your blog post out! 

## To-do

1. Add RSS feed feature
2. Add sample header file
3. Add sample footer file
4. Add sample CSS file
5. Add major Linux distribution installation instructions
6. Add BSD installation instructions
7. Add Mac installation instructions

## License

This program is libre software: You can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License version 3 for more details.
