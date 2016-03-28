FROM ubuntu:16.04

MAINTAINER yagince <straitwalk@gmail.com>

RUN apt-get update
RUN apt-get install -y libpoppler-glib-dev poppler-data libgirepository1.0 curl git

RUN echo "deb http://it.archive.ubuntu.com/ubuntu/ wily main universe restricted multiverse" >> /etc/apt/sources.list.d/wily.list
RUN apt-get update
RUN apt-get install -y build-essential zlib1g-dev ruby2.2 ruby2.2-dev
RUN ln -s /usr/bin/ruby2.2 /usr/bin/ruby
RUN ln -s /usr/bin/gem2.2 /usr/bin/gem
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN gem i bundler -v 1.11.2

CMD ["/bin/bash"]
