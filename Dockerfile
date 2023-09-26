# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install sudo and other required packages for system
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y sudo gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install sudo itself
RUN apt-get install -y sudo

# Create a non-root user and grant sudo privileges if needed
# For example, you can create a user named 'myuser' and give it sudo access:
# RUN useradd -m -s /bin/bash myuser
# RUN usermod -aG sudo myuser

# Copy the requirements file into the container
COPY requirements.txt .

# Install app dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Specify the command to run your application
CMD ["python", "app.py"]
