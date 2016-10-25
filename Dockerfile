#Inspiration 1: DotCloud
#Inspiration 2: https://github.com/justnidleguy/
#Inspiration 3: https://bitbucket.org/xcgd/ubuntu4b

FROM softapps/docker-ubuntubaseimage
MAINTAINER Arun T K <arun.kalikeri@xxxxxxxx.com>

ADD . /pd_build

RUN /pd_build/odoo.sh

# ADD sources for the oe components
# ADD an URI always gives 600 permission with UID:GID 0 => need to chmod accordingly
# /!\ carefully select the source archive depending on the version
RUN cp /pd_build/sources/odoo.tar.gz /opt/odoo/odoo.tar.gz
RUN chown odoo:odoo /opt/odoo/odoo.tar.gz

# changing user is required by openerp which won't start with root
# makes the container more unlikely to be unwillingly changed in interactive mode
USER odoo

RUN /bin/bash -c "mkdir -p /opt/odoo/{bin,etc,sources/odoo/addons,additional_addons,data}" && \
    cd /opt/odoo/sources/odoo && \
        tar -xvf /opt/odoo/odoo.tar.gz --strip 1 && \
        rm /opt/odoo/odoo.tar.gz

RUN /bin/bash -c "mkdir -p /opt/odoo/var/{run,log,egg-cache,ftp}"

# Execution environment
USER 0

VOLUME ["/opt/odoo/var", "/opt/odoo/etc", "/opt/odoo/additional_addons", "/opt/odoo/data"]

ADD sources/odoo.conf /opt/odoo/etc/odoo.conf
WORKDIR /app
ADD bin /app/bin/
# Expose the odoo ports (for linked containers)
EXPOSE 8069 8072

USER root
RUN rm -rf /pd_build
