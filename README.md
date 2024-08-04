# de-stock-market-data-analysis

Run through the steps below to setup Kafka on the EC2 instance created by terraform.

Note 1: As data costs money to call from an api we will be using a given set of data in this repo. This can be easily updated to call from an api if you wish to do so!

Note 2: We are using the free tier of the EC2 instance so it does not have much memory or computational power. Due to this we have added a delay to data uploading. Removing this will cause zookeeper/kafka to crash upon running the kafka python files for any meaningful amount of time. 

# Security warning

WARNING! It is best practice to limit the traffic to only be able to use authorised ip addresses, and to limit ports to the only ones required. I have not done this as this is primarily a data engineering project. (See main.tf file to update as you wish)

# Provider 

For fastest server response please change the provider.tf file to the closest region for you!

# Shout out!

This project is inspired by Darshil Parmar! Big respect to him. I have built upon it by using terraform and python files rather than jupyter notebooks.

# AWS Credentials

Please export your AWS credentials to the console or run aws configure with a setup IAM rule with the correct permissions or terraform (and other code) will not run!

# Terraform

Change dir into the terraform folder and run:
terraform init
terraform plan 
terraform apply

Then hit yes to apply this to your aws account!

# EC2

Once you have deployed your EC2 instance run:

wget https://downloads.apache.org/kafka/3.8.0/kafka_2.12-3.8.0.tgz
tar -xvf kafka_2.12-3.8.0.tgz
export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"

Change dir into the kafka folder:
cd kafka_2.12-3.8.0
sudo nano config/server.properties

scroll down to advertised.listeners and uncomment it, set it to: 
advertised.listeners=PLAINTEXT://(ec2 Public IPv4 address):9092
Save and exit.


Start zookeeper:
bin/zookeeper-server-start.sh config/zookeeper.properties

Open a new terminal and reconnect to the ec2 instance then run:
bin/kafka-server-start.sh config/server.properties

# Glue

Upon running the producer and consumer, the consumer will upload some data to s3.

Go into AWS Glue and create a crawler. Give the crawler a unique name and add a data source. Set this to the S3 bucket that was created by terraform. 

To interact with the S3 bucket, Glue needs permissions to interact with it. Create an IAM role and give it the correct permissions. Then add this to the Glue crawler.

Create a database that can contain the table the Glue crawler will create. Give this any name you want. Assign this to the crawler and then create the crawler.

Run this crawler and wait for it to finish!

# Athena

AWS Athena lets us run SQL queries on the database that we created. This database holds the table that was created by the glue crawler which was based on the stock market data we provided.

You will need to set in the settings of Athena an S3 bucket that can store the queries. This has been created by terraform and just needs to be selected in the settings.

Now you can create queries and run them on the database to pull out any data you would want from the stock market data in real time! Run SELECT COUNT(*) FROM database_name to see how more records are added by the second!

# Congratulations!

This is the end of the project. Here is what we have done:

Using terraform

- Created an EC2 instance
- An S3 bucket to hold our stock market data in json format
- An S3 bucket to hold our Athena queries
- Created a security group and added rules to them to allow for us to interact with the EC2 instance

Using Kafka

- Deployed a Kafka server onto our EC2 instance
- Used this to take in data using our Producer and send this to the Consumer
- Used the Consumer to upload stock market data to our S3 bucket

Using Glue

- Created a database to hold our stock market data
- Created a crawler to crawl across our stock market data bucket and put this in a table in our database

Using Athena

- Queried our table that was created in Glue
- Seen that our database updates in real time

Thanks for following along!