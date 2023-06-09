To deploy, simply run terraform:

```
terraform init
terraform apply
```

Additional notes on things you would also usually have, but org/dept dependent

- Terra form backend e.g. S3 with DynamoDB locking if applicable
- Encryption
- Locked down ciphers for HTTPS depending on internal Info Sec requirements
- DNS with certs
- WAF
- Monitoring
- Not adding users. They should be SSO users
- Data and application code should be split
- CICD system for automation

Any manual changes to the website data will require a cloud front cache invalidation