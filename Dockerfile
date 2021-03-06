FROM kbase/sdkbase2:python
MAINTAINER KBase Developer
# -----------------------------------------
# In this section, you can install any system dependencies required
# to run your App.  For instance, you could place an apt-get update or
# install line here, a git checkout to download code, or run any other
# installation scripts.

RUN apt-get update
RUN conda create --name py2 python=2.7 --yes
RUN echo "source activate py2" > ~/.bashrc &&\
    /bin/bash -c "source activate py2"
ENV PATH /miniconda/envs/py2/bin:$PATH
RUN conda install -c bioconda gtdbtk -n py2 --yes
ENV GTDBTK_DATA_PATH /kb/module/test/data/



# -----------------------------------------

COPY ./ /kb/module
RUN mkdir -p /kb/module/work
RUN chmod -R a+rw /kb/module

WORKDIR /kb/module

RUN make all

ENTRYPOINT [ "./scripts/entrypoint.sh" ]

CMD [ ]
