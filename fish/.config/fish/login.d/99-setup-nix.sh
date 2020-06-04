#sync with https://github.com/NixOS/nix/blob/3be58fe1bc781fd39649f616c8ba4e5be672d505/scripts/nix-profile-daemon.sh.in

export NIX_USER_PROFILE_DIR="/nix/var/nix/profiles/per-user/$USER"
export NIX_PROFILES="/nix/var/nix/profiles/default $HOME/.nix-profile"

# Set up the per-user profile.
mkdir -m 0755 -p $NIX_USER_PROFILE_DIR
if ! test -O "$NIX_USER_PROFILE_DIR"
	echo "WARNING: bad ownership on $NIX_USER_PROFILE_DIR" >&2
end

if test -w $HOME
	if ! test -L $HOME/.nix-profile
		if test "$USER" != root
			ln -s $NIX_USER_PROFILE_DIR/profile $HOME/.nix-profile
		else
			# Root installs in the system-wide profile by default.
			ln -s /nix/var/nix/profiles/default $HOME/.nix-profile
		end
	end

	# Subscribe the root user to the NixOS channel by default.
	if [ "$USER" = root -a ! -e $HOME/.nix-channels ]
		echo "https://nixos.org/channels/nixpkgs-unstable nixpkgs" > $HOME/.nix-channels
	end

	# Create the per-user garbage collector roots directory.
	set NIX_USER_GCROOTS_DIR /nix/var/nix/gcroots/per-user/$USER
	mkdir -m 0755 -p $NIX_USER_GCROOTS_DIR
	if ! test -O "$NIX_USER_GCROOTS_DIR"
		echo "WARNING: bad ownership on $NIX_USER_GCROOTS_DIR" >&2
	end

	# Set up a default Nix expression from which to install stuff.
	if [ ! -e $HOME/.nix-defexpr -o -L $HOME/.nix-defexpr ]
		rm -f $HOME/.nix-defexpr
		mkdir -p $HOME/.nix-defexpr
		if [ "$USER" != root ]
			ln -s /nix/var/nix/profiles/per-user/root/channels $HOME/.nix-defexpr/channels_root
		end
	end
end

export PATH="/nix/var/nix/profiles/default/bin:$PATH"
export PATH="$HOME/.nix-profile/bin:$PATH"
export NIX_PATH=$HOME/.nix-defexpr/channels
