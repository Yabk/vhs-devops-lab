FROM registry.redhat.io/ubi8/ubi:8.7 as builder

# use nexus bundle url as a build arugment so we can easily change it to
# another version when building the image
ARG NEXUS_BUNDLE_URL=https://download.sonatype.com/nexus/3/nexus-3.37.3-02-unix.tar.gz

ENV NEXUS_HOME /opt/nexus
WORKDIR $NEXUS_HOME

ADD $NEXUS_BUNDLE_URL $NEXUS_HOME
RUN tar xf *.tar.gz; rm *.tar.gz
# remove version number from extracted directory
RUN mv nexus-* nexus


FROM registry.redhat.io/ubi8/ubi:8.7 as main

EXPOSE 8081
ENV NEXUS_HOME /opt/nexus
WORKDIR $NEXUS_HOME

RUN dnf -y install java-1.8.0-openjdk-devel; dnf clean all

# copy the extracted archive from the builder image
COPY --from=builder $NEXUS_HOME $NEXUS_HOME

VOLUME $NEXUS_HOME/sonatype-work

ENTRYPOINT $NEXUS_HOME/nexus/bin/nexus run

