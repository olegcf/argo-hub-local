# Upload

## Summary
Create github release. Workflow consists of two subsequent tasks, since github release can be attached a files we firstly clone repository by using [clone](https://github.com/codefresh-io/argo-hub/blob/main/workflows/git/versions/0.0.3/docs/clone.md) template from the Markteplace that stores file in the "repo" artifact and then creating release in another step. That's why __S3 storage must be configured prior__ you can use the template.

## Inputs/Outputs

### Inputs
#### Parameters
* BASE_URL              API endpoint (default: "https://api.github.com") 
* DRAFT                 `true` makes the release a draft, and `false` publish the release (default: "false")
* PRERELEASE            if `true` create pre-release (default: "false")
* REPO_URL              used by clone step (inside plugin)
* REPO_OWNER            repository owner (Git username) (required)
* REPO_NAME             repository name (required) 
* RELEASE_NAME          release name (required)
* RELEASE_TAG           release tag  (required)
* RELEASE_DESCRIPTION   release message (required)
* FILES                 list of files inside cloned directory to attach to the release
* GIT_TOKEN_SECRET      Kubernetes secret name with git token (default: github-token)

### Outputs
#### Artifacts

## Examples

### task Example
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  name: create-github-release
spec:
   entrypoint: main
   templates:
     - name: main
       inputs:
         parameters:                                
          # Used by close step
          - name: REPO_URL
          - name: GIT_TOKEN_SECRET
            value: 'github-token'                
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
          - name: FILES
            default: ''
       dag:
         tasks:
           - name: create-github-release
             templateRef:
               name: git-release.0.0.2
               template: upload
             arguments:
               parameters:
               # https://api.github.com
               - name: BASE_URL
               # set to true to create draft
               - name: DRAFT
                 value: '{{ inputs.parameters.DRAFT }}'
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
               - name: FILES
                 value: '{{ inputs.parameters.FILES }}'
```
