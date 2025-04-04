# Use the official Jupyter image
FROM jupyter/base-notebook

# Switch to root user
USER root

# Set the working directory
WORKDIR /home/jane

# Install system dependencies
RUN apt-get update && apt-get install -y \
    g++ \
    libopenblas-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python libraries
RUN pip install networkx pymc numpy arviz aesara matplotlib

# Expose port 8000 for Jupyter
EXPOSE 8000

# Start Jupyter Notebook with no token and no password
CMD ["start-notebook.sh", "--NotebookApp.token=''", "--NotebookApp.password=''"]
