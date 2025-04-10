#!/bin/bash

REGISTRY="registry.andreybondarenko.com"
AUTH="user:password"  # Replace with your username and password

# Get list of repositories
repos=$(curl -s -u "$AUTH" https://$REGISTRY/v2/_catalog | jq -r '.repositories[]?')
echo -e "Found repositories:\n$repos\n"

# Loop over repositories
for repo in $repos; do
    echo "Repository: $repo"

    # Get list of tags
    tags=$(curl -s -u "$AUTH" https://$REGISTRY/v2/$repo/tags/list | jq -r '.tags[]?')
    if [[ -z "$tags" ]]; then
        echo "  (no tags)"
        continue
    fi

    for tag in $tags; do
        echo -n "  Tag: $tag -> "

        # Try fetching as multi-arch manifest list
           manifest_json=$(curl -s -u "$AUTH" \
               -H "Accept: application/vnd.oci.image.index.v1+json, application/vnd.docker.distribution.manifest.list.v2+json, application/vnd.oci.image.manifest.v1+json, application/vnd.docker.distribution.manifest.v2+json" \
               https://$REGISTRY/v2/$repo/manifests/$tag)

        if echo "$manifest_json" | jq -e 'has("manifests")' > /dev/null 2>&1; then
            # It's a manifest list
            platforms=$(echo "$manifest_json" | jq -r '.manifests[] | "\(.platform.os)/\(.platform.architecture)\(.platform.variant // "")"' | sort)
            echo "Platforms:"
            echo "$platforms" | sed 's/^/    - /'
        else
            # Try fetching as single manifest
            single_manifest=$(curl -s -u "$AUTH" -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
                              https://$REGISTRY/v2/$repo/manifests/$tag)

            config_digest=$(echo "$single_manifest" | jq -r '.config.digest // empty')

            if [[ -z "$config_digest" ]]; then
                echo "(invalid manifest or config digest missing)"
                echo "    Raw manifest:"
                echo "$single_manifest" | jq
                continue
            fi

            config_json=$(curl -s -u "$AUTH" https://$REGISTRY/v2/$repo/blobs/$config_digest)
            os=$(echo "$config_json" | jq -r '.os // empty')
            arch=$(echo "$config_json" | jq -r '.architecture // empty')

            if [[ -n "$os" && -n "$arch" ]]; then
                echo "Platform: $os/$arch"
            else
                echo "(failed to parse config)"
            fi
        fi
    done

    echo ""
done