ServiceNow Accelerator
======================

ServiceNow specific Accelerator/starter suite.


Overview
--------

This repository provides an example how to work with ServiceNow cloud.
It's meant to be used as a template for ServiceNow testing projects.

Some ServiceNow specific keywords are included to make testing easier.


Usage
-----
* IMPORTANT:
* Add your ServiceNow instance url to CRT variable "login_url"
* Add your ServiceNow user to CRT variable "username"
* Add your ServiceNow user password to CRT variable "password"
  * Note: it's best to encrypt/hide sensitive information (password)

Variables can be added by hovering on top of your test suite, selecting
"Suite details" icon and adding them using "+Variable" button.

Use these automated test cases as a basis to learn and start modifying
them to suit your specific needs.


Additional information
----------------------

Directory structure:

* Tests are under "tests" folder
* Supporting files are under "resources" folder