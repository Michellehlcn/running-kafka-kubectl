# Running in Kubernetes (using a Helm Chart)
# Using Helm repository
# Add the AKHQ helm charts repository:
helm repo add akhq https://akhq.io/
# Install or upgrade
helm upgrade --install akhq akhq/akhq
# Requirements
# Chart version >=0.1.1 requires Kubernetes version >=1.14
# Chart version 0.1.0 works on previous Kubernetes versions
helm install akhq akhq/akhq --version 0.1.0
