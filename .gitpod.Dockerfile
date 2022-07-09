FROM gitpod/workspace-base

USER root

RUN apt-get -y update \
 && apt-get install -y apt-transport-https \
 && apt-get install -y curl \
 && apt-get install -y  bzip2 \ 
 && mkdir -p /nix /etc/nix \
 && chmod a+rwx /nix \
 && echo 'sandbox = false' > /etc/nix/nix.conf \
 && echo 'build-users-group =' >> /etc/nix/nix.conf \
 && echo "substituters  = https://hydra.iohk.io https://iohk.cachix.org https://cache.nixos.org/\ntrusted-public-keys = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" >> /etc/nix/nix.conf \
 && addgroup nixbld



RUN adduser user --home /home/user --disabled-password --gecos "" --shell /bin/bash

USER user
ENV USER user
WORKDIR /home/user

RUN cd /home/user && git clone https://github.com/input-output-hk/plutus 



RUN touch .bash_profile \
 && curl https://nixos.org/releases/nix/nix-2.2.1/install | sh

USER root

RUN sh -c 'cd /home/user/plutus &&  nix-shell'

CMD /bin/bash 

# USER root

# # Install Nix
# RUN addgroup --system nixbld \
#   && adduser gitpod nixbld \
#   && for i in $(seq 1 30); do useradd -ms /bin/bash nixbld$i &&  adduser nixbld$i nixbld; done \
#   && mkdir -m 0755 /nix && chown gitpod /nix \
#   && mkdir -p /etc/nix && echo 'sandbox = false' > /etc/nix/nix.conf \
#   && echo 'substituters = https://hydra.iohk.io https://iohk.cachix.org https://cache.nixos.org/' >> ~/.config/nix/nix.conf \
#   && echo 'trusted-public-keys = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=' >> ~/.config/nix/nix.conf
  
# # Install Nix
# CMD /bin/bash -l
# USER gitpod
# ENV USER gitpod
# WORKDIR /home/gitpod

# RUN touch .bash_profile \
#  && curl https://releases.nixos.org/nix/nix-2.9.2/install | sh

# RUN echo '. /home/gitpod/.nix-profile/etc/profile.d/nix.sh' >> /home/gitpod/.bashrc
# RUN mkdir -p /home/gitpod/.config/nixpkgs && echo '{ allowUnfree = true; }' >> /home/gitpod/.config/nixpkgs/config.nix

# # Install cachix
# RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
#   && nix-env -iA cachix -f https://cachix.org/api/v1/install \
#   && cachix use cachix \
#   && cachix use digitallyinduced

# # Install git
# RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
#   && nix-env -i git git-lfs

# # Install direnv
# RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
#   && nix-env -i direnv \
#   && direnv hook bash >> /home/gitpod/.bashrc

# # Make an empty IHP project to warm up the nix store
# RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
#     && git clone https://github.com/digitallyinduced/ihp-boilerplate.git /tmp/warmup \
#     && cd /tmp/warmup \
#     && (nix-shell -j auto --cores 0 --quiet --run 'echo ok' || true)

