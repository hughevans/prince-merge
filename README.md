Prince Merge
============

Generate multiple addressed PDFs with the excellent [PrinceXML](http://princexml.com).

Usage
-----

    ruby prince_merge.rb addresses.csv mailrun.pdf

The first argument is a CSV containing the recipients. The CSV file needs a headers row and the bundled ``standard_envelope.haml`` template requires the following:

    name
    address_one
    address_two
    address_three
    city
    state
    postal_code
    country

The second argument is the file for output. There is also an optional third argument for specifying a different [HAML](http://haml-lang.com) template:

    ruby prince_merge.rb addresses.csv mailrun.pdf letter.haml

TODO
----

* Make and publish a gem with an executable +prince_merge+
* Add some inline usage
* Error handling

Contributors
------------

* [Hugh Evans](http://github.com/hughevans)
* [Tim Riley](http://github.com/timriley)
* [Jared Fraser](http://github.com/modsognir)

Copyright
---------

Copyright © 2010 Hugh Evans. See LICENSE for details.