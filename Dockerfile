FROM ubuntu:latest

# Add PPA to apt repository to fetch latest neovim version  -> see https://github.com/neovim/neovim/wiki/Installing-Neovim
RUN apt-get update \
 && apt-get -y install software-properties-common \
 && add-apt-repository ppa:neovim-ppa/stable

RUN apt-get update \
 && apt-get  install -y neovim python-dev python-pip python3 python3-pip python3-dev curl vim exuberant-ctags git ack-grep \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN pip3 install neovim pep8 flake8 pyflakes pylint isort
ADD config/init.vim /root/.config/nvim/
RUN mkdir /data
# Install plugins
RUN timeout 5m nvim || true
RUN timeout 5m nvim --headless +UpdateRemotePlugins +q
CMD ["nvim", "/data"]
