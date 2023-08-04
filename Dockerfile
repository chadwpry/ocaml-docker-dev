FROM ocaml/opam

RUN sudo apt-get update -y

WORKDIR /home/opam

# BUILD TOOLS
RUN sudo apt-get install ninja-build gettext cmake unzip curl -y

# NEOVIM
RUN git clone https://github.com/neovim/neovim
RUN cd /home/opam/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
RUN cd /home/opam/neovim && sudo make install
RUN rm -rf /home/opam/neovim

# OCAML
RUN opam update
# #RUN opam switch create 4.14.1

RUN opam user-setup install

RUN opam install dune
RUN opam install merlin
RUN opam install ocaml-lsp-server
RUN opam install odoc
RUN opam install ocamlformat
RUN opam install utop
RUN opam install dune-release
RUN opam install lwt

# NPM -> RELATING TO NEOVIM LSP-SERVERS
RUN sudo apt-get install npm -y

# MOVING ON FROM BASH
RUN sudo apt-get install zsh -y

# NEOVIM CONFIGURATION
RUN git clone https://github.com/chadwpry/dotfiles.git
RUN cd dotfiles && ./install

