LinkedListBrowser
=================

A Ruby Domain Specific Language (DSL) for accessing LinkedListNYC entries.  What is the [LinkedList](http://www.linkedlistnyc.org)?

Usage
-----

Example:

```ruby
issue = LinkedListNYC.issue_005 # gets you issue # 5
issue.css('a').map { |x| x.attributes['href'].to_s }
```

gives you:

```
=> ["*|ARCHIVE|*",	      
  "http://www.meetup.com/openny/events/16755815/",
  "http://www.meetup.com/PythonBrooklyn/events/16931174/",
  "http://www.meetup.com/lisp-59/events/16908923/",
  "http://en.wikipedia.org/wiki/Wikipedia:Meetup/NYC",
  "http://www.nycruby.org/events/16179487/",
  "mailto:tips@linkedlistnyc.org",
  "http://twitter.com/linkedlistnyc",
  "*|UNSUB|*"]
```

In general:

```
LinkedListNYC.issue_<issueNo> # where issueNo is a three digit number
```

This will give you a ``Nokogiri::HTML::Document`` which you can then manipulate.  Access individual entries this way.  To download and cache entries use ``LinkedListNYC.download_and_cache``.  Downloaded docs will be stored as ``./linkedlist_issues/0xx.html``.

Requirements
------------

	$ gem install nokogiri

License (MIT)
-------------

Copyright (c) 2012 Lucas Chi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.