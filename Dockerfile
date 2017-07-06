# Base image heroku-16
FROM heroku/heroku:16

# Make folder structure
RUN mkdir /app
RUN mkdir /app/.heroku
RUN mkdir /app/.heroku/vendor
ENV LD_LIBRARY_PATH /app/.heroku/vendor/lib/

# Cleanup Python
RUN apt-get remove -y python2.7
RUN apt-get remove -y python3.4
RUN apt-get remove -y python2.7-minimal
RUN apt-get remove -y python3.4-minimal
RUN apt-get remove -y libpython2.7-minimal
RUN apt-get remove -y libpython3.4-minimal

# Install python 
RUN apt install -y python-minimal python-pip python-setuptools python-opencv

# Install BLAS and LAPACK
RUN apt install -y libblas-dev liblapack-dev 

# Install zbar (QR code scanner)
sudo apt install -y libzbar0 libzbar-dev

# Install opencv and xpdf tools
sudo apt install -y xpdf opencv*

# Update pip 
RUN python -m pip install --upgrade pip

# Install Numpy and scipy
RUN pip install --user numpy scipy

# Install zbar-py,  imutils and PyPDF2
RUN pip install --user zbar-py imutils PyPDF2

# Install Matplotlib
RUN pip install --user matplotlib


# Create vendor package
WORKDIR /app/
RUN tar cvfj /vendor.tar.bz2 .
VOLUME /vendoring
CMD cp /vendor.tar.bz2 /vendoring
