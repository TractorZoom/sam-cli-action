# @TractorZoom/sam-cli-action

_Tractor Zoom primarily works in Node.js so this action has NOT been tested extensively with Python. As always, new features, bug fixes, and other contributions are always welcome! Please submit a PR or an Issue._

Github action for using the [AWS SAM CLI](https://github.com/awslabs/aws-sam-cli) to build and deploy serverless applications written in node 12.x and python 3.8.

### Getting Started:

1. Add `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_DEFAULT_REGION` in Settings > Secrets.

2. Add the following to your Github workflow within your SAM project to build and deploy:

```yaml
- name: sam build
  uses: TractorZoom/sam-cli-action@master
  with:
    sam_command: "build"
  env:
    AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
    AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    AWS_DEFAULT_REGION: ${{ secrets.AWS_DEFAULT_REGION }}
- name: sam deploy
  uses: TractorZoom/sam-cli-action@master
  with:
    sam_command: "deploy"
  env:
    AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
    AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    AWS_DEFAULT_REGION: ${{ secrets.AWS_ACCESS_KEY_ID }}
```
