FROM python:3.11.2-slim-bullseye

ENV PATH="/root/sfdx/bin:${PATH}"

ARG DX_CLI_URL=https://developer.salesforce.com/media/salesforce-cli/sfdx/channels/stable/sfdx-linux-x64.tar.xz

RUN \
	apt-get update && \
	apt-get install -y wget curl gpg git xz-utils && \
	curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor > /usr/share/keyrings/nodejs-archive-keyring.gpg && \
	echo "deb [signed-by=/usr/share/keyrings/nodejs-archive-keyring.gpg] https://deb.nodesource.com/node_18.x bullseye main" > /etc/apt/sources.list.d/nodejs.list && \
	curl -s https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor > /usr/share/keyrings/yarn-archive-keyring.gpg && \
	echo "deb [signed-by=/usr/share/keyrings/yarn-archive-keyring.gpg] https://dl.yarnpkg.com/debian stable main" > /etc/apt/sources.list.d/yarn.list && \
	curl -s https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /usr/share/keyrings/google-archive-keyring.gpg && \
	echo "deb [signed-by=/usr/share/keyrings/google-archive-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
	apt-get update && \
	apt-get install -y nodejs yarn google-chrome-stable ffmpeg && \
	rm -rf /var/lib/apt/lists/* && \
	pip install --no-cache-dir pipenv requests xmltodict url-normalize && \
	mkdir /root/sfdx && \
	wget --quiet --output-document=- $DX_CLI_URL | tar --extract --xz --directory=/root/sfdx --strip-components 1 \
