Dynamic Asset Helper - A set of ActionView helper methods for easier dynamic JS and CSS includes
====================

This plugin allows for dynamic inclusion of javascript and css assets based on routes.
A given page might have custom JS or CSS files specifically for it's own use, and no others.
This plugin aims to make that easier.

Example Usage
-------------

Consider the following:
:controller => 'products', :action => 'list'

By placing <%= dynamic_stylesheet_link_tag %> and/or <%= dynamic_javascript_include_tag %>
in your view, this plugin will look for files at the following paths:

'/stylesheets/products.css'
'/stylesheets/products/list.css'
'/javascripts/products.js'
'/javascripts/products/list.js'

A "script" and/or "link" tag will be generated for each file that exists.

This can be especially helpful since no tags will be output if no css or js file exists
to be included. Think of it as a way to override or add on to the global look and feel of your
site, for a specific path.

I realize this plugin may not have performance in mind, since it's doing File.exists? checks
upon every page load. So please keep in mind this is intended for a small audience who needs it
and should probably only be used to speed up development.


Options
-------

Both dynamic_stylesheet_link_tag and dynamic_javascript_include_tag accept an :extras parameter.
:extras is expected to be an array of symbols for "extra" query parameters to use when building paths
to look up and possibly include as part of final list of JS and CSS files.

Consider the following:
:controller => 'products', :action => 'list', :tab => 'sale'

dynamic_stylesheet_link_tag :extras => [:tab]

Will attempt to find and generate script include tags following paths:
'/javascripts/products.js'
'/javascripts/products/list.js'
'/javascripts/products/list/tabs.js'
'/javascripts/products/list/tabs/sale.js'