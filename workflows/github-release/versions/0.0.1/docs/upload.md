# Upload

## Summary
Create github release

## Inputs/Outputs

### Inputs
#### Parameters
* BASE_URL              API endpoint (default: "https://api.github.com") 
* DRAFT                 `true` makes the release a draft, and `false` publish the release (default: "false")
* PRERELEASE            if `true` create pre-release (default: "false")
* REPO_OWNER            repository owner (Git username) (required)
* REPO_NAME             repository name (required) 
* RELEASE_NAME          release name (required)
* RELEASE_TAG           release tag  (required)
* RELEASE_DESCRIPTION   release message (required)
* GIT_TOKEN_SECRET      Kubernetes secret name with git token (default: github-token)

### Outputs
#### Artifacts

## Examples

### task Example
```yaml
apiVersion: argoproj.io/v1alpha1
kind: WorkflowTemplate
metadata:
  name: create-release-for-node
spec:
   entrypoint: git-release
   templates:
     - name: git-release
       inputs:
         parameters:
          - name: BASE_URL
            default: 'https://api.github.com'
           # set to true to create draft
          - name: DRAFT
            default: 'false'
           # set to true to create pre-release
          - name: PRERELEASE
            default: 'false'
          - name: REPO_OWNER
          - name: REPO_NAME
          - name: RELEASE_NAME
          - name: RELEASE_TAG
          - name: RELEASE_DESCRIPTION
          - name: GIT_TOKEN_SECRET
            default: github-token   # name of secret
       dag:
         tasks:
           - name: upload-git-release
             templateRef:
               name: git-release.0.0.1
               template: upload
             arguments:
               parameters:
               # https://api.github.com
               - name: BASE_URL
                 value: '{{ inputs.parameters.GIT_TOKEN_SECRET }}'
                 # set to true to create draft
               - name: DRAFT
                 value: '{{ inputs.parameters. }}'
               # set to true to create pre-release
               - name: PRERELEASE
                 value: '{{ inputs.parameters.PRERELEASE }}'
               - name: REPO_OWNER
                 value: '{{ inputs.parameters.REPO_OWNER }}'
               - name: REPO_NAME
                 value: '{{ inputs.parameters.REPO_NAME }}'
               - name: REVISION
                 value: '{{ inputs.parameters.REVISION }}'
               - name: GIT_TOKEN_SECRET
                 value: '{{ inputs.parameters.GIT_TOKEN_SECRET }}'
               # MANDATORY vars
               - name: RELEASE_NAME
                 value: '{{ inputs.parameters.RELEASE_NAME }}'
               - name: RELEASE_TAG
                 value: '{{ inputs.parameters.RELEASE_TAG }}'
               - name: RELEASE_DESCRIPTION
                 value: '{{ inputs.parameters.RELEASE_DESCRIPTION }}'
```
