#!/bin/bash
set -euo pipefail

function _get_ca_flag {
    payload=$1

    k8s_ca_path="$(mktemp "/tmp/k8s-cluster-ca.XXXXXX")"
    jq -r .source.cluster_ca < "$payload" | base64 -d > "$k8s_ca_path"

    echo "--certificate-authority=$k8s_ca_path"
}

function _get_client_key_cert_flags {
    payload=$1

    k8s_client_key_path="$(mktemp "/tmp/k8s-client-key.XXXXXX")"
    k8s_client_cert_path="$(mktemp "/tmp/k8s-client-cert.XXXXXX")"

    jq -r .source.admin_key < "$payload" | base64 -d  > "$k8s_client_key_path"
    jq -r .source.admin_cert < "$payload" | base64 -d > "$k8s_client_cert_path"

    echo "--client-key $k8s_client_key_path --client-certificate=$k8s_client_cert_path"
}

function _get_user_password_flags {
    payload=$1
    username=$(jq -r .source.username < "$payload")
    password=$(jq -r .source.password < "$payload")

    echo "--username=$username --password=$password"
}

function get_payload_file_path {
    payload="$(mktemp "/tmp/k8s-resource-request.XXXXXX")"
    cat > "$payload" <&0
    echo "$payload"
}

function get_kubectl_cmd {
    payload=$1

    k8s_url=$(jq -r .source.cluster_url < "$payload")
    k8s_auth=$(jq -r .source.auth_method < "$payload")
    namespace=$(jq -r .source.namespace < "$payload")

    kubectl="/usr/local/bin/kubectl --server=$k8s_url --namespace=$namespace"


    # configure SSL Certs if available
    if [[ "$k8s_url" =~ https.* ]]; then
        kubectl+=" $(_get_ca_flag "$payload")"
    fi

    # TODO allow client cert + key as well
    if [[ "$k8s_auth" =~ password ]]; then
        kubectl+=" $(_get_user_password_flags "$payload")"
    fi

    echo "$kubectl" > /kubectl

    echo "$kubectl"
}


PAYLOAD=$(get_payload_file_path)
KUBECTL=$(get_kubectl_cmd "$PAYLOAD")
export PAYLOAD
export KUBECTL

