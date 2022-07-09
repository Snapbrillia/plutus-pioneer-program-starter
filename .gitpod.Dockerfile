FROM gitpod/workspace-base

USER root

# # Install Nix
CMD /bin/bash -l
USER gitpod
ENV USER gitpod
WORKDIR /home/gitpod


RUN curl https://releases.nixos.org/nix/nix-2.9.2/install | sh

RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
  && nix-env -iA cachix -f https://cachix.org/api/v1/install \
  && cachix use cachix
  
RUN mkdir -p /etc/nix && echo 'substituters = https://hydra.iohk.io https://iohk.cachix.org https://cache.nixos.org/ trusted-public-keys = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=' > /etc/nix/nix.conf
#  && echo -e 'substituters = https://hydra.iohk.io https://iohk.cachix.org https://cache.nixos.org/' >> ~/.config/nix/nix.conf \
#  && echo -e 'trusted-public-keys = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=' >> ~/.config/nix/nix.conf

# # Install Nix
# RUN addgroup --system nixbld \
#   && adduser gitpod nixbld \
#   && for i in $(seq 1 30); do useradd -ms /bin/bash nixbld$i &&  adduser nixbld$i nixbld; done \
#   && mkdir -m 0755 /nix && chown gitpod /nix \
#   && mkdir -p /etc/nix && echo 'sandbox = false' > /etc/nix/nix.conf
  
# # Install Nix
# CMD /bin/bash -l
# USER gitpod
# ENV USER gitpod
# WORKDIR /home/gitpod

# RUN touch .bash_profile \
#  && curl https://nixos.org/releases/nix/nix-2.3.14/install | sh

# RUN echo '. /home/gitpod/.nix-profile/etc/profile.d/nix.sh' >> /home/gitpod/.bashrc
# RUN mkdir -p /home/gitpod/.config/nixpkgs && echo '{ allowUnfree = true; }' >> /home/gitpod/.config/nixpkgs/config.nix

# # Install cachix
# RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
#   && nix-env -iA cachix -f https://cachix.org/api/v1/install \
#   && cachix use cachix

# # Install git
# RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
#   && nix-env -i git git-lfs

# # Install direnv
# RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
#   && nix-env -i direnv \
#   && direnv hook bash >> /home/gitpod/.bashrc

# # Install qemu
# RUN sudo apt update -y && sudo apt install qemu qemu-system-x86 linux-image-$(uname -r) libguestfs-tools sshpass netcat -y
