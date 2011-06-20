= rubygems-changelog

https://github.com/lhm/rubygems-changelog

== DESCRIPTION:

A rubygem plugin which adds a 'changelog' command to display a gems
changelog or history file.

== FEATURES/PROBLEMS:

* displays the changelog file of a given gem
* currently detects files named /(changelog|history)/i
* handles ambiguous file names (could still need some work, though..)

== SYNOPSIS:

  gem changelog GEMNAME

== REQUIREMENTS:

* rubygems >= 1.8.5
* ruby 1.9

== INSTALL:

* rake package
* gem install -l pkg/rubygems-changelog-0.0.2

== LICENSE:

(The MIT License)

Copyright (c) 2011 Lars Henrik Mai <lars.mai@kontinui.de>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
