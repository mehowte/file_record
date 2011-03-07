FileRecord
==========

Simplistic implementation of persistent model library. 
Inspired by ActiveRecord. And fully compatible with ActiveModel.

Created alongside the presentation [Digging into Rails 3.x internals - ActiveModel][0]

Installation
------------

    git clone git://github.com/mehowte/file_record.git
    cd file_record
    bundle install

Documentation
------------

1. See [the presentation][0]

2. Look into 
    test 
and 
    test/dummy directory.

Running tests
-------

    rake

Running demo app
--------
    cd test/dummy
    rails server

... and then visit [addresses index on localhost](http://localhost:3000/addresses)

models will be saved into 
    
    test/dummy/tmp/file_records

License
-------
Copyright 2011 Michal Taszycki

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[0]: http://active-model-krug-1-3-2011.heroku.com/
