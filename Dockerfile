FROM centos:7
MAINTAINER "midolin limegreen" <lime@midolin.info>

RUN yum install -y gcc g++ make which git libffi-devel
RUN yum install -y ImageMagick ImageMagick-devel ImageMagick-c++ ImageMagick-c++-devel
RUN mkdir /tmp/ruby ;\
  pushd /tmp/ruby ;\
  yum install -y openssl openssl-devel ;\
  curl -O https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.0.tar.gz ;\
  tar xzvf ruby-2.4.0.tar.gz ;\
  cd ruby-2.4.0 ;\
  ./configure; make; make install ;\
  popd

RUN rpm -ivh http://packages.groonga.org/centos/groonga-release-1.1.0-1.noarch.rpm ;\
  yum install -y mecab mecab-devel

RUN mkdir /tmp/naist-jdic ;\
  pushd /tmp/naist-jdic ;\
  curl -L https://ja.osdn.net/projects/naist-jdic/downloads/53500/mecab-naist-jdic-0.6.3b-20111013.tar.gz/ > mecab-naist-jdic-0.6.3b-20111013 ;\
  tar zxfv mecab-naist-jdic-0.6.3b-20111013 ;\
  cd mecab-naist-jdic-0.6.3b-20111013 ;\
  ./configure --with-charset=utf8; make; make install ;\
  cat /etc/mecabrc | sed s/ipadic/naist-jdic/ > /tmp/mecabrc ;\
  cp /tmp/mecabrc /etc/mecabrc ;\
  popd

RUN yum install -y epel-release ;\
  yum install -y pandoc

RUN gem install ffi jekyll rmagick natto bundler --no-ri --no-rdoc
RUN mkdir /tmp/pip ;\
  pushd /tmp/pip;\
  curl -O https://bootstrap.pypa.io/get-pip.py ;\
  python get-pip.py;\
  pip install pygments pandocfilters ;\
  popd

ADD "Gemfile" /tmp/Gemfile
RUN pushd /tmp ;\
  bundle install ;\
  rm Gemfile.lock ;\
  popd

ADD "start.sh" /var/start.sh

CMD ["/bin/bash", "/var/start.sh"]

EXPOSE 80

