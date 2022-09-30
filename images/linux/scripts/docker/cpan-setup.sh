#!/bin/bash -e
# https://rt.cpan.org/Public/Bug/Display.html?id=131313
export SHELL=$(which bash)
# https://stackoverflow.com/questions/3462058/how-do-i-automate-cpan-configuration
(echo y;echo o conf prerequisites_policy follow;echo o conf commit)|cpan