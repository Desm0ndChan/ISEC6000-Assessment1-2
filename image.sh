#!/bin/bash

# Extract image names from docker-compose.yml
images=$(docker compose config | grep image: | awk '{print $2}' | sort | uniq)

for image in $images; do
    echo "Scanning image: $image"

    # Generate a filename-safe string from the image name
    filename=$(echo $image | tr ':/' '--').report

    trivy image --report all --output scan/$filename $image 
    echo "Results saved to: $filename"
    echo "----------------------------------------"
done