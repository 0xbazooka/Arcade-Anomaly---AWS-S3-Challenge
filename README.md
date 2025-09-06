# Arcade Anomaly - An AWS S3 Miscofiguration Lab

<img width="1509" height="787" alt="image" src="https://github.com/user-attachments/assets/011a2a40-f37c-4432-9a58-6b0a64495d8c" />



I originally created this challenge for the ASC Wargames Qualifications CTF but it couldn't be uploaded due to financial issues, so i thought i would upload here at least :)

--- 

## Requirements

1. Create an AWS account and generate access keys  
2. Install Terraform  
3. Install AWS CLI  
4. Create 2 IAM users: `badUser` and `badAdmin`
Verify installation:

```bash
terraform version
aws --version
```

Configure AWS Access Keys
```bash
aws configure
```


Initialize Terraform
```bash
terraform init
```


Format Code
```bash
terraform fmt
```

Validate Configuration
```bash
terraform validate
# Output:
# Success! The configuration is valid.
```


Build the Environment
```bash
terraform apply
```

Cleanup

When you’re done with the lab, destroy the environment to avoid unnecessary costs:

```bash
terraform destroy
```


# The Scenario

1. The given URL loads a static web application.  
2. By checking the page src code, an s3 bucket used for images and scripts will be found.  
3. Taking that S3 bucket URL, the player starts enumerating it.  
4. Inside, they’ll find 4 directories and a file:  
   - /`static`  
   - /`shared`  
   - /`badBackup`  
   - /`admin`  
   - `index.html`  
5. The player can list `static`, `shared`, and `badBackup` , but can only download from `static` and `shared`.  
6. In `shared`, there’s a zip file waiting. It’s password-protected.  
7. after cracking it with rockyou.txt the password will be 1970basma 
8. Inside, a powershell script will be found: `PixelSync.ps1`, which will contain iam user creds for **badUser**.  
9. After configuring `badUser` in the AWS CLI, the player can start enumerating the s3 bucket this time as an authenticated user.  
10. With that, access to `badBackup` is unlocked, revealing lots of log files and a backup file.  
11. after searching through the log files another iam user creds will be found, this time for **badAdmin**.  
12. Configure `badAdmin`, head into the `admin` directory... and there it is  the flag :D


