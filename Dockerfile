#Inspiration 1: DotCloud
#Inspiration 2: https://github.com/justnidleguy/
#Inspiration 3: https://bitbucket.org/xcgd/ubuntu4b

FROM softapps/docker-ubuntubaseimage
MAINTAINER Arun T K <arun.kalikeri@xxxxxxxx.com>

ADD . /pd_build

RUN /pd_build/install.sh

# Execution environment
USER 0

VOLUME ["/opt/odoo/var", "/opt/odoo/etc", "/opt/odoo/data", "/opt/odoo/additional_addons"]

WORKDIR /app
ADD bin /app/bin/

# Set the default entrypoint (non overridable) to run when starting the container
ENTRYPOINT ["/app/bin/boot"]
CMD ["help"]

# Expose the odoo ports (for linked containers)
EXPOSE 8069 8072
