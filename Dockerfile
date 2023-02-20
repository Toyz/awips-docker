FROM centos:7
LABEL Author="Helba The AI <me@helba.ai>"
LABEL Description="AWIPS2 Cave Docker Image"

ARG USER=awips
ARG UID=1000

# create a user with the same UID as the host user
RUN useradd -m -u $UID $USER

# Install dependencies
RUN yum -y update && yum -y install wget bzip2 libXext libSM libXrender mesa-libGLU mesa-libGL libXtst libXScrnSaver mesa-dri-drivers

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda
RUN rm Miniconda3-latest-Linux-x86_64.sh
ENV PATH="/opt/conda/bin:${PATH}"
RUN wget https://downloads.unidata.ucar.edu/awips2/current/linux/awips_install.sh
RUN chmod +x awips_install.sh
RUN bash awips_install.sh --cave

ENV MESA_GL_VERSION_OVERRIDE=3.3
ENV MESA_GLSL_VERSION_OVERRIDE=330

ENV JAVA_INSTALL=/awips2/java
ENV CAVE_INSTALL=/awips2/cave
ENV PYTHON_INSTALL=/awips2/python
ENV HDF5_INSTALL=/awips2/hdf5

ENV PATH="${JAVA_INSTALL}/bin:${CAVE_INSTALL}:${PYTHON_INSTALL}/bin:${HDF5_INSTALL}/bin:${PATH}"
ENV LD_LIBRARY_PATH="${HDF5_INSTALL}/lib:${JAVA_INSTALL}/lib:${PYTHON_INSTALL}/lib:${PYTHON_INSTALL}/lib/python2.7/site-packages/jepL${LD_LIBRARY_PATH}"

# set the user to use when running this image
USER $USER

ENTRYPOINT [ "sh", "-c", "cave.sh" ]