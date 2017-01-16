FROM centos:7
MAINTAINER "midolin limegreen" <lime@midolin.info>

RUN yum install -y ruby ruby-devel mecab mecab-devel mecab-ipadic imagemagick imagemagick-devel pandoc python ;\
  gem install jekyll rmagick natto bundler ;\
  pip install pygments ;\
  bundle install 

CMD ["/bin/bash", "start.sh"]
