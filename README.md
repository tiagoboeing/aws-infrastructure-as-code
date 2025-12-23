# Infrastructure as Code (IaC) for AWS

![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)

Infrastructure as Code (IaC) stacks for Amazon Web Services (AWS).

## Infrastructures

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)

- [Terraform Backend with S3 and DynamoDB (Remote State + State Locking)](./terraform-backend)
- [App Runner with ECR, CloudFront, ACM and Route53](./app-runner)
- [Cognito User Pool with Identity Providers (social logins)](./cognito-user-pool)
- [CDN on custom domain with CloudFront, S3, Route53 and Certificate Manager](./cloudfront-cdn)
- [ECS Cluster with VPC, NAT Gateway, Internet Gateway and custom domain](./ecs-cluster-vpc-nat)

Each infrastructure has its own README with instructions.

## How to contribute

1. Fork this repository
2. Create a new branch
3. Commit your changes
4. Push to the branch
5. Create a new pull request
6. Wait for the review and merge approval

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="http://tiagoboeing.com"><img src="https://avatars.githubusercontent.com/u/3449932?v=4?s=100" width="100px;" alt="Tiago Boeing"/><br /><sub><b>Tiago Boeing</b></sub></a><br /><a href="https://github.com/tiagoboeing/terraform-aws/commits?author=tiagoboeing" title="Documentation">📖</a> <a href="https://github.com/tiagoboeing/terraform-aws/commits?author=tiagoboeing" title="Code">💻</a> <a href="#infra-tiagoboeing" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
