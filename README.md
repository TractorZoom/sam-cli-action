# sam-cli-action

Github action for using the [AWS SAM CLI](https://github.com/awslabs/aws-sam-cli)

### Example Workflow:

```yaml
- name: sam build
  uses: TractorZoom/sam-cli-action@master
  with:
    sam_command: "build"
  env:
    AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
    AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    AWS_DEFAULT_REGION: us-east-1
- name: sam deploy
  uses: TractorZoom/sam-cli-action@master
  with:
    sam_command: "deploy"
  env:
    AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
    AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    AWS_DEFAULT_REGION: us-east-1
```
