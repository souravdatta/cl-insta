FROM ubuntu

# build variables

ARG SBCL_VERSION 
ARG SBCL_URL=https://prdownloads.sourceforge.net/sbcl/sbcl-2.0.7-source.tar.bz2
ARG QUICKLISP_VERSION
ARG QUICKLISP_URL=http://beta.quicklisp.org/dist/quicklisp/2020-01-04/distinfo.txt

RUN apt-get update && \
    apt-get install -y build-essential && \
    apt-get install -y curl \
                libblas-dev \
                libffi-dev \
                liblapack-dev \
                libz-dev \
                libzmq3-dev \
                rlwrap \
                sbcl && \
    apt-get clean

WORKDIR /src

RUN curl -o /tmp/quicklisp.lisp 'https://beta.quicklisp.org/quicklisp.lisp' && \
    sbcl --noinform --non-interactive --load /tmp/quicklisp.lisp --eval \
        "(quicklisp-quickstart:install)" && \
    sbcl --noinform --non-interactive --load ~/quicklisp/setup.lisp --eval \
        '(ql-util:without-prompting (ql:add-to-init-file))' && \
    echo '#+quicklisp(push "/src" ql:*local-project-directories*)' >> ~/.sbclrc && \
    rm -f /tmp/quicklisp.lisp

COPY . /src/quicklisp/local-projects/cl-insta/

CMD ["sbcl", "--load", "quicklisp/local-projects/cl-insta/start_server.lisp"]

