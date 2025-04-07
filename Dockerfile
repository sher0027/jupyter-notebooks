# Use the official Jupyter base image
FROM jupyter/base-notebook

# Use root to install system dependencies
USER root

# Set working directory
WORKDIR /home/jovyan

# Install system dependencies
RUN apt-get update && apt-get install -y \
    g++ \
    libopenblas-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy environment.yaml into the container
COPY environment.yaml /home/jovyan/environment.yaml

# Create conda environment from YAML
RUN conda env create -f /home/jovyan/environment.yaml && \
    conda clean --all --yes

# Set environment name (should match that in environment.yaml)
ARG CONDA_ENV=jupyter-env
ENV PATH /opt/conda/envs/${CONDA_ENV}/bin:$PATH

# Switch back to non-root user (recommended)
USER ${NB_UID}

# Expose Jupyter on port 8000
EXPOSE 8000

# Start Jupyter Notebook without token or password
CMD ["start-notebook.sh", "--NotebookApp.token=", "--NotebookApp.password="]
