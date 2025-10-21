# Stage 1: Base build stage
FROM python:3.13.9-slim-trixie AS builder
# Create the app directory
RUN mkdir /app
# Set the working directory
WORKDIR /app
# Set environment variables to optimize Python
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1 
COPY ali-cache.list /etc/apt/sources.list
RUN apt-get update 
RUN apt-get install -y --no-install-recommends \
    default-libmysqlclient-dev gcc && rm -rf /var/lib/apt/lists/*
RUN mkdir ~/.pip
COPY pip.conf ~/.pip
# Upgrade pip and install dependencies
RUN pip install --upgrade pip==24.3.1
# Copy the requirements file first (better caching)
COPY requirements.txt /app/
# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt
 
# Stage 2: Production stage
FROM python:3.13.9-slim-trixie
RUN useradd -m -r appuser && \
   mkdir /app && \
   chown -R appuser /app
# Copy the Python dependencies from the builder stage
COPY --from=builder /usr/local/lib/python3.13/site-packages/ /usr/local/lib/python3.13/site-packages/
COPY --from=builder /usr/local/bin/ /usr/local/bin/
# Set the working directory
WORKDIR /app
# Copy application code
COPY --chown=appuser:appuser . .
# Set environment variables to optimize Python
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1 
# Switch to non-root user
USER appuser
# Expose the application port
EXPOSE 5571
 
CMD ["python3", "manage.py" , "runserver", "0.0.0.0:5571"]

