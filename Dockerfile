FROM		ubuntu:16.04
MAINTAINER	technopreneural@yahoo.com

			# Install latest updates (security best practice)
RUN			apt-get update \
			&& apt-get upgrade -y \

			# Install packages (without asking for user input)
			&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
				apt-cacher-ng \

			# Comment out specific lines of configuration
			&& sed -i '/gentoo/s/^/#/' /etc/apt-cacher-ng/acng.conf \

			# Remove repo lists (reduce image size)
			&& rm -rf /var/lib/apt/lists/*

			# Cached data folder
VOLUME		["/var/cache/apt-cacher-ng"]

			# Expose default port for apt-cacher-ng
EXPOSE  	3142

			# Popular execution code
			# Ensures data on mounted volumes are both readable & writable
			# Display all application logs on console
CMD			chmod 777 /var/cache/apt-cacher-ng \
			&& /etc/init.d/apt-cacher-ng start \
			&& tail -f /var/log/apt-cacher-ng/*